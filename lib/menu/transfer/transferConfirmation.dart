import 'package:flutter/material.dart';

class TransferConfirmationWidget extends StatefulWidget {
  final String _iban;

  const TransferConfirmationWidget(this._iban, {Key? key}) : super(key: key);

  @override
  State createState() => TransferConfirmationWidgetState(_iban);
}

class TransferConfirmationWidgetState
    extends State<TransferConfirmationWidget> {
  final String _iban;

  TransferConfirmationWidgetState(this._iban);

  @override
  Widget build(BuildContext context) {
    Future<bool> _backBtn(BuildContext context) async {
      Navigator.of(context).popAndPushNamed("/menu");
      return true;
    }

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Überweisung abgeschlossen"),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(20),
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(75, 94, 208, 41),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.check_circle_outline),
                          RichText(
                              textScaleFactor: 1.2,
                              text: TextSpan(
                                text: "Ihre Überweisung an ",
                                children: <TextSpan>[
                                  TextSpan(
                                      text: _iban,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const TextSpan(
                                      text: " wurde erfolgreich abgesendet."),
                                ],
                              ))
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      child: const Text("Zurück zur Übersicht",
                          textScaleFactor: 1.2,
                          style:
                              TextStyle(decoration: TextDecoration.underline)),
                      onTap: () => {Navigator.of(context).pushNamed("/menu")},
                    ),
                  )
                ],
              ),
            )),
        onWillPop: () => _backBtn(context));
  }
}
