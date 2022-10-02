import 'package:banking_app_abgabe/user/bankAccount.dart';

class User {
  int userID;
  String username;
  String name;
  String password;

  List<BankAccount> accounts = [];
  List<BankAccount> selectedAccount = [];

  User(this.userID, this.username, this.name, this.password);

  void addAccount(BankAccount account) {
    accounts.add(account);
  }

  void addSelectedAccount(BankAccount account) {
    selectedAccount.add(account);
  }

  void removeSelectedAccount(BankAccount account) {
    selectedAccount.remove(account);
  }
}
