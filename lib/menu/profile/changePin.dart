import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePinWidget extends StatefulWidget {
  const ChangePinWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChangePinWidgetState();
}

class ChangePinWidgetState extends State<ChangePinWidget> {
  int selectedAccount = 0;

  String? _errorMessage;

  TextEditingController currentPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  updateSelectedAccount(BankAccount? newValue) {
    for (int i = 0; i < UserService.currentUser.selectedAccount.length; i++) {
      if (UserService.currentUser.selectedAccount[i] == newValue) {
        selectedAccount = i;
        return;
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pin ändern"),
        ),
        body: buildContent());
  }

  Widget buildContent() {
    if (UserService.currentUser.selectedAccount.isEmpty) {
      return const Center(
          child: Flexible(
              child: Text(
        "Sie haben kein Konto ausgewählt. Fügen Sie ein Konto unter Finanzübersicht bearbeiten hinzu.",
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
        textScaleFactor: 1.25,
        overflow: TextOverflow.clip,
      )));
    } else {
      return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            children: [
              const Text(
                "Konto auswählen:",
                textScaleFactor: 1.25,
              ),
              DropdownButton<BankAccount>(
                value: UserService.currentUser.selectedAccount[selectedAccount],
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.white38,
                ),
                onChanged: (BankAccount? newValue) {
                  setState(() {
                    updateSelectedAccount(newValue);
                  });
                },
                items: UserService.currentUser.selectedAccount
                    .map<DropdownMenuItem<BankAccount>>((BankAccount value) {
                  return DropdownMenuItem<BankAccount>(
                      value: value, child: Text(value.iban));
                }).toList(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+')),
                  ],
                  maxLength: 4,
                  controller: currentPinController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Aktueller Pin',
                      counterText: ""),
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
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+')),
                  ],
                  maxLength: 4,
                  controller: newPinController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Neuer Pin',
                      counterText: ""),
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
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+')),
                  ],
                  maxLength: 4,
                  controller: confirmPinController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Neuen Pin bestätigen',
                      counterText: ""),
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
                          "Pin ändern",
                          textScaleFactor: 1.25,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.arrow_right, color: Colors.white)
                      ],
                    ),
                  ),
                  onTap: () {
                    if (UserService.instance.isPinForAccount(
                        UserService
                            .currentUser.selectedAccount[selectedAccount],
                        currentPinController.text)) {
                      if (newPinController.text.length == 4) {
                        if (newPinController.text ==
                            confirmPinController.text) {
                          Navigator.of(context).pop();
                          UserService.instance.changePin(
                              UserService
                                  .currentUser.selectedAccount[selectedAccount],
                              confirmPinController.text);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    "Ihr Pin wurde erfolgreich geändert",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )));
                        } else {
                          setState(() {
                            _errorMessage = "Die Pin's stimmen nicht überein";
                          });
                        }
                      } else {
                        setState(() {
                          _errorMessage = "Ihr Pin muss 4 Zahlen lang sein";
                        });
                      }
                    } else {
                      setState(() {
                        _errorMessage = "Ihr aktueller Pin ist falsch";
                      });
                    }
                  },
                ),
              ),
            ],
          ));
    }
  }
}
