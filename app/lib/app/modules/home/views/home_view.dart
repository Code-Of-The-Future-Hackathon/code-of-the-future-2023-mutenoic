import 'package:app/app/modules/home/components/drawer_content.dart';
import 'package:app/app/modules/map/views/map_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inner_drawer/inner_drawer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: controller.drawerKey,
      onTapClose: true,
      colorTransitionChild: Colors.transparent,
      colorTransitionScaffold: Colors.transparent,
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 15),
          color: Colors.black26,
          blurRadius: 30,
          spreadRadius: 10,
        )
      ],
      offset: const IDOffset.only(left: 0.5),
      scale: const IDOffset.horizontal(0.8), // set the offset in both directions
      proportionalChildArea: false, // default true
      borderRadius: 50, // default 0
      leftAnimationType: InnerDrawerAnimation.static,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      swipe: false,
      leftChild: const DrawerContent(),
      scaffold: const MapView(),
    );
  }
}
