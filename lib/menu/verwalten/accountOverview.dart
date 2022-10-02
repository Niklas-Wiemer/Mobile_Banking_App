import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:flutter/material.dart';

class AccountOverviewWidget extends StatefulWidget {
  const AccountOverviewWidget({Key? key}) : super(key: key);

  @override
  State createState() => AccountOverviewWidgetState();
}

class AccountOverviewWidgetState extends State<AccountOverviewWidget> {
  @override
  Widget build(BuildContext context) {
    Future<bool> _backBtn(BuildContext context) async {
      Navigator.of(context).popAndPushNamed("/verwalten");
      return true;
    }

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Konto auswählen"),
            ),
            body: Center(
              child: Column(
                children: [
                  Flexible(
                    child: ListView.separated(
                      itemCount: UserService.overviewUser.accounts.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return SwitchListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(UserService.overviewUser.name),
                              Text(UserService
                                  .overviewUser.accounts[index].iban),
                            ],
                          ),
                          value: UserService.instance.containsSelectedKonto(
                              UserService.currentUser,
                              UserService.overviewUser.accounts[index]),
                          onChanged: (bool value) {
                            setState(() {
                              BankAccount account =
                                  UserService.overviewUser.accounts[index];

                              if (UserService.instance.containsSelectedKonto(
                                  UserService.currentUser, account)) {
                                UserService.currentUser
                                    .removeSelectedAccount(account);
                              } else {
                                UserService.currentUser
                                    .addSelectedAccount(account);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
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
                          "Fertig",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.25,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.popAndPushNamed(context, "/verwalten");
                        });
                      },
                    ),
                  )
                ],
              ),
            )),
        onWillPop: () => _backBtn(context));
  }
}
