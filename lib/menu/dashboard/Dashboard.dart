import 'package:banking_app_abgabe/service/UserService.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardWidgetState();
}

class DashboardWidgetState extends State<DashboardWidget> {
  var values = {};
  double height = 400;

  DashboardWidgetState() {
    for (BankAccount account in UserService.currentUser.accounts) {
      values[account] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildTopbar(), _buildFinances()],
    );
  }

  Widget _buildFinances() {
    return Flexible(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Gesamtsumme
              _buildTotalMoney(),

              _buildFinancialOverview(),
              // Gesamtsumme
              _buildTotalMoney(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/verwalten");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.settings),
                    Text("Finzanzübersicht bearbeiten")
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFinancialOverview() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.94,
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            values[UserService.currentUser.selectedAccount[index]] =
                !values[UserService.currentUser.selectedAccount[index]];
          });
        },
        children: UserService.currentUser.selectedAccount
            .map<ExpansionPanel>((BankAccount account) {
          return ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return const ListTile(
                  title: Text("Finanzübersicht"),
                );
              },
              body: InkWell(
                  child: ListTile(
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.user.name,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(account.iban, textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                              "${account.balance.toString().replaceAll(".", ",")} €",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
                onTap: () => {
                  Navigator.of(context)
                      .pushNamed("/history", arguments: account)
                },
              )),
              isExpanded: values.containsKey(account)
                  ? values[account]
                  : values[account] = false);
        }).toList(),
      ),
    );
  }

  Widget _buildTotalMoney() {
    double sum = 0;
    for (var element in UserService.currentUser.selectedAccount) {
      sum += element.balance;
    }
    sum = (sum * 100).roundToDouble() / 100;

    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: const [Text('Gesamtsumme')],
          ),
          Column(
            children: [
              Chip(
                label: Text("${sum.toString().replaceAll(".", ",")} €"),
                backgroundColor: const Color.fromARGB(150, 10, 230, 10),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopbar() {
    List<ScrollItem> children = [
      ScrollItem(title: "Geld senden", icon: Icons.send, link: "ueberweisung"),
      ScrollItem(title: "Mobiles Bezahlen", icon: Icons.wifi, link: "mobile"),
      ScrollItem(
          title: "Karte sperren",
          icon: Icons.sd_card_alert_outlined,
          link: "lockCard"),
    ];

    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: SizedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            generateItem(children[0]),
            generateItem(children[1]),
            generateItem(children[2]),
          ],
        )));
  }

  Widget generateItem(ScrollItem item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton(
            heroTag: item.title,
            backgroundColor: Theme.of(context).cardColor,
            onPressed: () {
              Navigator.of(context).pushNamed("/${item.link}");
            },
            child: Icon(item.icon, color: Theme.of(context).iconTheme.color),
          ),
        ),
        Text(
          item.title,
          textScaleFactor: 0.85,
        )
      ],
    );
  }
}

class ScrollItem {
  ScrollItem({required this.title, required this.icon, required this.link});

  String title;
  IconData icon;
  String link;
}
