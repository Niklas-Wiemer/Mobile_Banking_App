import 'package:banking_app_abgabe/boxArea.dart';
import 'package:flutter/material.dart';

class ServicesWidget extends StatefulWidget {
  const ServicesWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ServicesWidgetState();
}

class ServicesWidgetState extends State<ServicesWidget> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    switch (value) {
      case 0:
        return buildMain();
      default:
        return buildMain();
    }
  }

  Widget buildMain() {
    List<CategoryItem> service = [
      CategoryItem(
          icon: Icons.support_agent, text: "Service-Center", route: null),
    ];
    List<CategoryItem> branch = [
      CategoryItem(
          icon: Icons.gps_fixed,
          text: "Filiale und Geldautomaten",
          route: null),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 10, right: 10),
          children: [
            BoxAreaBuilder.withoutCategory(context, this, service).build(),
            BoxAreaBuilder.withoutCategory(context, this, branch).build(),
          ]),
    );
  }
}
