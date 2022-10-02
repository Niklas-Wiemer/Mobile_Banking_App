import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:banking_app_abgabe/user/string_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool _shouldFailed = false;

class TransferWidget extends StatefulWidget {
  const TransferWidget({Key? key}) : super(key: key);

  @override
  State createState() => TransferWidgetState();
}

class TransferWidgetState extends State<TransferWidget> {
  int selectedValue = 0;
  var values = {"Als Terminüberweisung", "Sofort Überweisung"};

  int selectedAccount = 0;

  updateSelectedValue(String? newValue) {
    if (newValue == values.elementAt(0)) {
      selectedValue = 0;
    } else if (newValue == values.elementAt(1)) {
      selectedValue = 1;
    }
  }

  updateSelectedAccount(BankAccount? newValue) {
    for (int i = 0; i < UserService.currentUser.selectedAccount.length; i++) {
      if (UserService.currentUser.selectedAccount[i] == newValue) {
        selectedAccount = i;
        return;
      }
    }
    return;
  }

  bool _sending = false;
  String? _failed;

  TextEditingController receiverController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController usageController = TextEditingController();

  bool _validReceiver = true;
  bool _validIban = true;
  bool _validAmount = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Überweisung tätigen"),
      ),
      body: buildContent(),
    );
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
      return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Konto auswählen",
                ),
                DropdownButton<BankAccount>(
                  value:
                      UserService.currentUser.selectedAccount[selectedAccount],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Kontostand:"),
                    Chip(
                      label: Text(
                          "${UserService.currentUser.selectedAccount[selectedAccount].balance.toString().replaceAll(".", ",")} €"),
                      backgroundColor: const Color.fromARGB(150, 10, 230, 10),
                    )
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    enabled: !_sending,
                    controller: receiverController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Empfänger',
                        errorText:
                            _validReceiver ? null : "Ungültiger Empfänger"),
                    onChanged: (v) => {
                      setState(() {
                        _failed = null;
                        if (receiverController.text.trim().isEmpty) {
                          _validReceiver = false;
                        } else {
                          _validReceiver = true;
                        }
                      })
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    enabled: !_sending,
                    controller: ibanController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'IBAN',
                        errorText: _validIban ? null : "Ungültige IBAN"),
                    onChanged: (v) => {
                      setState(() {
                        _failed = null;
                        if (ibanController.text.trim().isEmpty) {
                          _validIban = false;
                        } else {
                          _validIban = true;
                        }
                      })
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                      enabled: !_sending,
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Betrag',
                          errorText: _validAmount ? null : "Ungültiger Betrag"),
                      onChanged: (v) => {
                            setState(() {
                              _failed = null;
                              try {
                                double amount =
                                    double.parse(amountController.text);
                                if (amount <= 0) {
                                  _validAmount = false;
                                } else {
                                  _validAmount = true;
                                }
                              } catch (e) {
                                _validAmount = false;
                              }
                            })
                          }),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    enabled: !_sending,
                    controller: usageController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Verwendungszweck (Optional)',
                    ),
                  ),
                ),

                // Dropdown menu

                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: values.elementAt(selectedValue),
                    underline: Container(
                      height: 1,
                      color: Colors.white38,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        updateSelectedValue(newValue);
                      });
                    },
                    items: values.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _sending
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          )
                        : const Text(""),
                    _failed != null
                        ? Flexible(
                            child: Text(
                            _failed!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(color: Colors.red),
                          ))
                        : const Text(""),
                  ],
                ),

                // Ueberweisen Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        child: Container(
                          width: 150,
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
                            "Überweisen",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          BankAccount? targetAccount = UserService.instance
                              .getAccountByIBAN(ibanController.text);

                          if (targetAccount == null) {
                            setState(() {
                              _validIban = false;
                            });
                            return;
                          }

                          if (!StringUtility.equalsIgnoreCase(
                              targetAccount.user.name,
                              receiverController.text)) {
                            setState(() {
                              _failed =
                                  "Der Empfänger stimmt nicht mit der IBAN überein";
                            });
                            return;
                          }

                          if (targetAccount.iban ==
                              UserService.currentUser
                                  .selectedAccount[selectedAccount].iban) {
                            setState(() {
                              _failed =
                                  "Sie können nicht Geld an das gleiche Konto schicken";
                            });
                            return;
                          }

                          double amount = -1;

                          try {
                            amount = double.parse(amountController.text);
                          } catch (e) {
                            setState(() {
                              _validAmount = false;
                            });
                            return;
                          }

                          if (amount <= 0) {
                            setState(() {
                              _validAmount = false;
                            });
                            return;
                          }

                          if (!UserService.instance.hasBalance(
                              UserService
                                  .currentUser.selectedAccount[selectedAccount],
                              amount)) {
                            setState(() {
                              _failed =
                                  "Sie haben nicht so viel Guthaben auf ihrem Konto";
                            });
                            return;
                          }

                          setState(() {
                            _sending = true;
                            _failed = null;
                          });
                          Future.delayed(const Duration(seconds: 2), () {
                            if (_shouldFailed) {
                              setState(() {
                                _failed =
                                    "Bei der Überweiung ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut";
                                _sending = false;
                              });
                            } else {
                              _sending = false;
                              UserService.instance.transfer(
                                  UserService.currentUser
                                      .selectedAccount[selectedAccount],
                                  UserService.instance
                                      .getAccountByIBAN(ibanController.text)!,
                                  amount,
                                  usageController.text);

                              Navigator.of(context).pushNamed("/confirm",
                                  arguments: targetAccount.iban);
                            }
                            _shouldFailed = !_shouldFailed;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            color: Colors.red,
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
                            "Abbrechen",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
