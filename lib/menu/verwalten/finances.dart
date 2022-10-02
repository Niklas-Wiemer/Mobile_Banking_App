import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:flutter/material.dart';

class FinanceWidget extends StatefulWidget {
  const FinanceWidget({Key? key}) : super(key: key);

  @override
  State createState() => FinanceWidgetState();
}

class FinanceWidgetState extends State<FinanceWidget> {
  late BankAccount? selectedAccount;

  Future<bool> _backBtn(BuildContext context) async {
    Navigator.of(context).popAndPushNamed("/menu");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              child: const Icon(Icons.arrow_back_outlined),
              onTap: () {
                Navigator.of(context).popAndPushNamed("/menu");
              },
            ),
            title: const Text('Finanzübersicht bearbeiten'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                /// Überschrift
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Vorhandene Konten',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                /// Konten anzeigen
                Flexible(
                    child: ListView.separated(
                  itemCount: UserService.currentUser.selectedAccount.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildAccount(
                        UserService.currentUser.selectedAccount[index]);
                  },
                )),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.of(context).pushNamed("/newKonto");
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
        onWillPop: () => _backBtn(context));
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Konto entfernen'),
      content: const Text('Möchten Sie wirklich das Konto entfernen?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: () => {
            setState(() {
              UserService.currentUser.removeSelectedAccount(selectedAccount!);
              selectedAccount = null;
              Navigator.of(context).pop(true);
            })
          },
          child: const Text('Entfernen', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  Widget _buildAccount(BankAccount account) {
    return ListTile(
      title: Text(account.user.name),
      subtitle: Text(account.iban),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            selectedAccount = account;
            showDialog(
              context: context,
              builder: (context) => _buildExitDialog(context),
            );
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
