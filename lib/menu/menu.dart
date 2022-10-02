import 'package:banking_app_abgabe/menu/dashboard/Dashboard.dart';
import 'package:banking_app_abgabe/menu/profile/profil.dart';
import 'package:banking_app_abgabe/menu/service/services.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  State<MenuWidget> createState() => MenuWidgetState();
}

class MenuWidgetState extends State<MenuWidget> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardWidget(),
    const ServicesWidget(),
    const ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Banking App verlassen'),
      content: const Text('Möchten Sie sich wirklich abmelden?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).popAndPushNamed("/"),
          child: const Text('Abmelden', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Image.asset(
              "images/icon.png",
              width: 32,
            ),
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).cardColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Start',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cleaning_services),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profil',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).unselectedWidgetColor,
            unselectedItemColor: Theme.of(context).disabledColor,
            onTap: _onItemTapped,
          ),
        ),
        onWillPop: () => _onWillPop(context));
  }
}
