import 'package:banking_app_abgabe/user/transfer.dart';
import 'package:banking_app_abgabe/user/user.dart';

class BankAccount {
  User user;
  String iban;
  double balance;
  String pin;
  List<Transfer> transfers = [];

  BankAccount(this.user, this.iban, this.balance, this.pin);

  void addTransfer(Transfer transfer) {
    transfers.add(transfer);
  }
}
