import 'dart:developer';

import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:banking_app_abgabe/user/string_utility.dart';
import 'package:banking_app_abgabe/user/transfer.dart';
import 'package:banking_app_abgabe/user/user.dart';

class UserService {
  static UserService instance = UserService();

  static late User currentUser;
  static late User overviewUser;

  List<User> users = [];

  UserService() {
    instance = this;

    User user = User(0, "Maximilian", "Maximilian Mustermann", "1234");

    BankAccount account =
        BankAccount(user, "DE00 1234 4567 9101 1121 31", 3842.25, "4356");

    user.addAccount(account);
    user.addSelectedAccount(account);

    User user2 = User(1, "Franz", "Franz Wilhelm", "123");

    BankAccount otherAccount =
        BankAccount(user2, "DE00 4321 76543 9101 3243 53", 32.59, "5093");
    user2.addAccount(otherAccount);
    user2.addSelectedAccount(otherAccount);

    BankAccount newAccount =
        BankAccount(user2, "DE00 1234 12345 4321 4321 12", 473.15, "1123");
    user2.addAccount(newAccount);

    // Überweisungen simulieren
    transfer(account, otherAccount, 250.43, "FH Dortmund Wintersemester");
    transfer(account, otherAccount, 120.32, "Einkauf");
    transfer(otherAccount, account, 43.34, "Bestellung bei Amazon");
    transfer(account, otherAccount, 84.16, "");
    transfer(account, otherAccount, 94.85, "Taschengeld");
    transfer(otherAccount, account, 1.99, "");
    transfer(account, otherAccount, 457.43, "Geburtstagsgeld");
    transfer(otherAccount, account, 1.34, "Brötchen");
    transfer(otherAccount, account, 34.20, "");

    users.add(user);
    users.add(user2);
  }

  bool containsUsername(String username) {
    for (var element in users) {
      if (element.username == username) return true;
    }
    return false;
  }

  void changePassword(User user, String password) {
    user.password = password;
  }

  void changePin(BankAccount account, String pin) {
    account.pin = pin;
  }

  bool isPasswordForUsername(String username, String password) {
    for (var element in users) {
      if (StringUtility.equalsIgnoreCase(username, element.username) &&
          element.password == password) {
        return true;
      }
    }
    return false;
  }

  bool isPasswordForUser(User user, String password) {
    return user.password == password;
  }

  bool isPinForAccount(BankAccount account, String pin) {
    return account.pin == pin;
  }

  bool containsSelectedKonto(User user, BankAccount account) {
    return user.selectedAccount.contains(account);
  }

  BankAccount? getAccountByIBAN(String iban) {
    for (User user in users) {
      for (BankAccount account in user.accounts) {
        if (account.iban.replaceAll(" ", "") == iban.replaceAll(" ", "")) {
          return account;
        }
      }
    }
    return null;
  }

  User? getUserByUsername(String username) {
    for (var element in users) {
      if (StringUtility.equalsIgnoreCase(element.username, username)) {
        return element;
      }
    }
    return null;
  }

  User? getUserByID(int id) {
    for (var element in users) {
      if (element.userID == id) return element;
    }
    return null;
  }

  bool hasBalance(BankAccount account, double money) {
    return account.balance >= money;
  }

  void transfer(BankAccount fromAccount, BankAccount toAccount, double money,
      String usage) {
    fromAccount.balance -= money;
    fromAccount.balance = (fromAccount.balance * 100).roundToDouble() / 100;

    toAccount.balance += money;
    toAccount.balance = (toAccount.balance * 100).roundToDouble() / 100;

    fromAccount.transfers.insert(
        0, Transfer(fromAccount, toAccount, -money, usage, DateTime.now()));

    toAccount.transfers.insert(
        0, Transfer(fromAccount, toAccount, money, usage, DateTime.now()));
  }
}
