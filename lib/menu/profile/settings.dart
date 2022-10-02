import 'package:banking_app_abgabe/boxArea.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Einstellungen"),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 10, right: 10),
                children: [
                  BoxAreaBuilder.withoutCategory(context, this, [
                    CategoryItem(
                        icon: Icons.remove_red_eye,
                        text: "Pin einsehen",
                        route: "/profile/settings/showPin")
                  ]).build(),
                  BoxAreaBuilder.withoutCategory(context, this, [
                    CategoryItem(
                        icon: Icons.edit,
                        text: "Pin ändern",
                        route: "/profile/settings/changePin")
                  ]).build(),
                  BoxAreaBuilder.withoutCategory(context, this, [
                    CategoryItem(
                        icon: Icons.password,
                        text: "App Passwort ändern",
                        route: "/profile/settings/changePassword")
                  ]).build(),
                ])));
  }
}
