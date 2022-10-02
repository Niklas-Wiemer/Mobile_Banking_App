import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChangePasswordWidgetState();
}

class ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  String? _errorMessage;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Passwort ändern"),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 10, right: 10),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: currentPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Aktuelles Passwort',
                    ),
                    onChanged: (v) {
                      setState(() {
                        _errorMessage = null;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Neues Passwort',
                    ),
                    onChanged: (v) {
                      setState(() {
                        _errorMessage = null;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Neues Passwort bestätigen',
                    ),
                    onChanged: (v) {
                      setState(() {
                        _errorMessage = null;
                      });
                    },
                  ),
                ),
                _errorMessage == null
                    ? const Text("")
                    : Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Passwort ändern",
                            textScaleFactor: 1.25,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.arrow_right, color: Colors.white)
                        ],
                      ),
                    ),
                    onTap: () {
                      if (UserService.instance.isPasswordForUser(
                          UserService.currentUser,
                          currentPasswordController.text)) {
                        if (newPasswordController.text ==
                            confirmPasswordController.text) {
                          Navigator.of(context).pop();
                          UserService.instance.changePassword(
                              UserService.currentUser,
                              confirmPasswordController.text);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    "Ihr Passwort wurde erfolgreich geändert",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )));
                        } else {
                          setState(() {
                            _errorMessage =
                                "Die Passwörter stimmen nicht überein";
                          });
                        }
                      } else {
                        setState(() {
                          _errorMessage = "Das aktuelle Passwort ist falsch";
                        });
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
