import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';

import 'package:flutter/material.dart';

class MobilePayWidget extends StatefulWidget {
  const MobilePayWidget({Key? key}) : super(key: key);

  @override
  State createState() => MobilePayWidgetState();
}

class MobilePayWidgetState extends State<MobilePayWidget> {
  int selectedAccount = 0;

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
          title: const Text("Mobiles Bezahlen"),
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
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
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
          const Divider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/mobiles_bezahlen.png"),
              const Divider(),
              const Text("Bitte halten Sie ihr Smartphone vor das Lesegerät")
            ],
          ),
        ]),
      );
    }
  }
}
