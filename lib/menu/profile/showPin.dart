import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:flutter/material.dart';

class ShowPinWidget extends StatefulWidget {
  const ShowPinWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShowPinWidgetState();
}

class ShowPinWidgetState extends State<ShowPinWidget> {
  int selectedAccount = 0;

  var pin = ["*", "*", "*", "*"];

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
          title: const Text("Pin einsehen"),
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
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 4,
                                  color: Theme.of(context).disabledColor))),
                      child: Text(
                        pin[0],
                        textScaleFactor: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 4,
                                  color: Theme.of(context).disabledColor))),
                      child: Text(
                        pin[1],
                        textScaleFactor: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 4,
                                  color: Theme.of(context).disabledColor))),
                      child: Text(
                        pin[2],
                        textScaleFactor: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 4,
                                  color: Theme.of(context).disabledColor))),
                      child: Text(
                        pin[3],
                        textScaleFactor: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: InkWell(
                        child: const Icon(Icons.remove_red_eye, size: 32),
                        onTapCancel: () => {
                          setState(() {
                            for (int i = 0; i < 4; i++) {
                              pin[i] = "*";
                            }
                          })
                        },
                        onTap: () => {
                          setState(() {
                            for (int i = 0; i < 4; i++) {
                              pin[i] = "*";
                            }
                          })
                        },
                        onTapDown: (v) => {
                          setState(() {
                            for (int i = 0; i < 4; i++) {
                              pin[i] = UserService.currentUser
                                  .selectedAccount[selectedAccount].pin
                                  .split("")[i];
                            }
                          })
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ));
    }
  }
}
