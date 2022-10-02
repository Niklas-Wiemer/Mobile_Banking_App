import 'package:banking_app_abgabe/user/bankAccount.dart';

class Transfer {
  BankAccount from;
  BankAccount to;
  double amount;
  String usage;
  DateTime date;

  Transfer(this.from, this.to, this.amount, this.usage, this.date);
}
