import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:flutter/material.dart';

class NewAccountWidget extends StatefulWidget {
  const NewAccountWidget({Key? key}) : super(key: key);

  @override
  State createState() => NewAccountWidgetState();
}

class NewAccountWidgetState extends State<NewAccountWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? _failed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konto hinzufügen"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 350,
          child: Column(
            children: [
              // Username
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Benutzername',
                  ),
                  onChanged: (v) {
                    setState(() {
                      _failed = null;
                    });
                  },
                ),
              ),

              // Password
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Passwort'),
                    onChanged: (v) {
                      setState(() {
                        _failed = null;
                      });
                    },
                  )),

              _failed == null
                  ? const Text("")
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        _failed!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

              // Login Button

              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: InkWell(
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Colors.green,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 0.5),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Anmelden",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.25,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (UserService.instance.isPasswordForUsername(
                          usernameController.text, passwordController.text)) {
                        UserService.overviewUser = UserService.instance
                            .getUserByUsername(usernameController.text)!;
                        Navigator.popAndPushNamed(context, "/konto/uebersicht");
                      } else {
                        setState(() {
                          _failed = "Die Anmeldedaten sind ungültig";
                        });
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
