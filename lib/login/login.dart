import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _failed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Anmelden", textScaleFactor: 2),

            // Benutzername
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Benutzername',
                ),
              ),
            ),

            // Passwort
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Passwort',
                ),
              ),
            ),

            _failed
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text("Die Anmeldedaten sind ungültig",
                        style: TextStyle(color: Colors.red)),
                  )
                : const Text(""),

            // Login Button
            Container(
              margin: const EdgeInsets.only(top: 20),
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
                  if (UserService.instance.isPasswordForUsername(
                      usernameController.text, passwordController.text)) {
                    UserService.currentUser = UserService.instance
                        .getUserByUsername(usernameController.text)!;
                    Navigator.of(context).popAndPushNamed("/menu");
                  } else {
                    setState(() {
                      _failed = true;
                    });
                  }
                },
              ),
            ),

            // New Account
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: InkWell(
                child: const Text(
                  "Noch keinen Account? Hier beantragen",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () {},
              ),
            )
          ],
        ),
      )),
    );
  }
}
