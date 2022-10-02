import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LockCardWidget extends StatelessWidget {

  const LockCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Karte sperren"),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                  "Der Sperr-Notruf ist täglich 24 Stunden erreichbar. In Deutschland gebührenfrei unter 116 116, aus dem Ausland gebührenpflichtig unter +49 116 116."),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: InkWell(
                  child: Container(
                    width: 200,
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
                      "+49 116 116",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.25,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () => {launchUrl(Uri.parse("tel:+116116"))},
                ),
              ),
            ],
          ),
        )));
  }
}
