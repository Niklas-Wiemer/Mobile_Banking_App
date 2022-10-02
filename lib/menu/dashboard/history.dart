import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatefulWidget {
  BankAccount _account;

  HistoryWidget(this._account, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HistoryWidgetState(_account);
}

class HistoryWidgetState extends State<HistoryWidget> {
  BankAccount _account;

  String getFormattedDate(DateTime dateTime) {
    String value = "";

    if (dateTime.day < 10) {
      value += "0";
    }
    value += "${dateTime.day}.";

    if (dateTime.month < 10) {
      value += "0";
    }
    value += "${dateTime.month}.${dateTime.year}";

    return value;
  }

  String getFormattedTime(DateTime dateTime) {
    String value = "";

    if (dateTime.hour < 10) {
      value += "0";
    }
    value += "${dateTime.hour}:";

    if (dateTime.minute < 10) {
      value += "0";
    }
    value += dateTime.minute.toString();

    return value;
  }

  HistoryWidgetState(this._account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sichteneinlage"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: ListView(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _account.transfers.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              getFormattedDate(_account.transfers[index].date)),
                          Text(
                              "${getFormattedTime(_account.transfers[index].date)} Uhr")
                        ]),
                    title: Text(
                      _account.transfers[index].amount < 0
                          ? _account.transfers[index].to.user.name
                          : _account.transfers[index].from.user.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(_account.transfers[index].usage),
                    trailing: Text(
                      "${_account.transfers[index].amount.toString().replaceAll(".", ",")} €",
                      style: TextStyle(
                          color: _account.transfers[index].amount > 0
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
