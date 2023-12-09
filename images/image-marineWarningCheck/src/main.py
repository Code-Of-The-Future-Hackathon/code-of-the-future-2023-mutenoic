import pandas as pd
import openmeteo_requests
import requests_cache
import pandas as pd
from retry_requests import retry
from datetime import date
import firebase_admin
from firebase_admin import credentials, firestore, messaging
from google.cloud.firestore_v1.base_query import FieldFilter
import os
cwd = os.getcwd()

def sendPush(title, msg, registration_token, dataObject=None):
    # See documentation on defining a message payload.
    message = messaging.MulticastMessage(
        notification=messaging.Notification(
            title=title,
            body=msg
        ),
        data=dataObject,
        tokens=registration_token,
    )

    # Send a message to the device corresponding to the provided
    # registration token.
    response = messaging.send_multicast(message)
    # Response is a message ID string.
    print('Successfully sent message:', response)

def handler(event, context):
    if not firebase_admin._apps:
        cred = credentials.Certificate("serviceAccount.json")
        firebase_admin.initialize_app(cred)
        print("Firebase initialized")
    db = firestore.client()

    content = []
    with open('regions.txt', 'r', encoding='utf-8') as f:
        lines = f.readlines()
        for line in lines:
            split_reg = line.split(' - ')
            split_loc = split_reg[1].split(', ')
            content.append({split_reg[0]: [float(split_loc[0]), float(split_loc[1].replace('\n', ''))]})
    print(content)
    os.chdir("/tmp")
    cache_session = requests_cache.CachedSession('.cache', expire_after = 3600)
    retry_session = retry(cache_session, retries = 5, backoff_factor = 0.2)
    openmeteo = openmeteo_requests.Client(session = retry_session)

    # Make sure all required weather variables are listed here
    # The order of variables in hourly or daily is important to assign them correctly below
    dataframes = []
    url = "https://marine-api.open-meteo.com/v1/marine"
    for loc in content:
        coordinates = list(loc.values())[0]
        params = {
            "latitude": coordinates[0],
            "longitude": coordinates[1],
            "hourly": "wave_height",
            "timeformat": "unixtime"
        }
        try:
            responses = openmeteo.weather_api(url, params=params)
        except:
            print('Could not retrieve data')
            continue

        # Process first location. Add a for-loop for multiple locations or weather models
        response = responses[0]
        print(f"Coordinates {response.Latitude()}°E {response.Longitude()}°N")
        print(f"Elevation {response.Elevation()} m asl")
        print(f"Timezone {response.Timezone()} {response.TimezoneAbbreviation()}")
        print(f"Timezone difference to GMT+0 {response.UtcOffsetSeconds()} s")

        # Process hourly data. The order of variables needs to be the same as requested.
        hourly = response.Hourly()
        hourly_wave_height = hourly.Variables(0).ValuesAsNumpy()

        hourly_data = {"date": pd.date_range(
            start = pd.to_datetime(hourly.Time(), unit = "s"),
            end = pd.to_datetime(hourly.TimeEnd(), unit = "s"),
            freq = pd.Timedelta(seconds = hourly.Interval()),
            inclusive = "left"
        )}
        hourly_data["wave_height"] = hourly_wave_height

        hourly_dataframe = pd.DataFrame(data = hourly_data)
        dataframes.append({list(loc.keys())[0]: hourly_dataframe})

    print(len(dataframes))
    os.chdir(cwd)

    for df in dataframes:
        datf = list(df.values())[0]
        datk = list(df.keys())[0]
        if datf['wave_height'][0] > 3 or datf['wave_height'][1] > 3:
            needs_to_notify = False
            locations_to_change = []
            docs = db.collection("Regions").where(filter=FieldFilter("floodWarning", "==", False)).stream()
            for doc in docs:
                document = doc.to_dict()
                document["ref"] = doc.id
                locations_to_change.append(document)
            
            for location in locations_to_change:
                if location['ref'] == datk:
                    needs_to_notify = True
                    db.collection("Regions").document(datk).set({'floodWarning': True}, merge=True)
            
            users_to_notify = []
            if needs_to_notify:
                docs = db.collection("Users").where(filter=FieldFilter("region", "==", datk)).stream()
                for doc in docs:
                    document = doc.to_dict()
                    document["ref"] = doc.id
                    users_to_notify.append(document['notificationToken'])
            
                sendPush("Известяване", "Предупреждение за опасно високи вълни по крайбрежието във вашата област.", users_to_notify)
                
        else: 
            db.collection("Regions").document(datk).set({'floodWarning': False}, merge=True)