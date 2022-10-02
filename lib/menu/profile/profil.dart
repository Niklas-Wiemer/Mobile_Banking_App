import 'package:banking_app_abgabe/boxArea.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    List<CategoryItem> notifications = [
      CategoryItem(
          icon: Icons.local_post_office_outlined,
          text: "Postfach",
          route: null),
      CategoryItem(
          icon: Icons.bookmark_border, text: "Merkzettel", route: null),
      CategoryItem(icon: Icons.alarm, text: "Kontowecker", route: null),
    ];
    List<CategoryItem> settings = [
      CategoryItem(
          icon: Icons.settings,
          text: "App-Einstellungen",
          route: "/profile/settings"),
      CategoryItem(icon: Icons.bar_chart, text: "Auswertungen", route: null),
    ];
    List<CategoryItem> paymentMethods = [
      CategoryItem(
          icon: Icons.mobile_friendly, text: "Mobiles Bezahlen", route: null),
      CategoryItem(icon: Icons.payment, text: "giropay | Kwitt", route: null),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 10, right: 10),
          children: [
            BoxAreaBuilder(context, this, "Benachrichtigungen", notifications)
                .build(),
            BoxAreaBuilder(context, this, "Einstellungen", settings).build(),
            BoxAreaBuilder(context, this, "Zahlungsmethoden", paymentMethods)
                .build(),
            BoxAreaBuilder.withoutCategory(context, this, [
              CategoryItem(icon: Icons.logout, text: "Abmelden", route: "/")
            ]).build()
          ]),
    );
  }
}
