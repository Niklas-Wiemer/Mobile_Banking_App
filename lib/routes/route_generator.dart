import 'package:banking_app_abgabe/login/login.dart';
import 'package:banking_app_abgabe/menu/dashboard/history.dart';
import 'package:banking_app_abgabe/menu/lockCard/lockCard.dart';
import 'package:banking_app_abgabe/menu/menu.dart';
import 'package:banking_app_abgabe/menu/mobilePay/mobilePay.dart';
import 'package:banking_app_abgabe/menu/profile/changePassword.dart';
import 'package:banking_app_abgabe/menu/profile/changePin.dart';
import 'package:banking_app_abgabe/menu/profile/settings.dart';
import 'package:banking_app_abgabe/menu/profile/showPin.dart';
import 'package:banking_app_abgabe/menu/transfer/transfer.dart';
import 'package:banking_app_abgabe/menu/transfer/transferConfirmation.dart';
import 'package:banking_app_abgabe/menu/verwalten/finances.dart';
import 'package:banking_app_abgabe/menu/verwalten/accountOverview.dart';
import 'package:banking_app_abgabe/menu/verwalten/newAccount.dart';
import 'package:banking_app_abgabe/user/bankAccount.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginWidget());

      case '/menu':
        return MaterialPageRoute(builder: (_) => const MenuWidget());

      case "/history":
        if (args is BankAccount) {
          return MaterialPageRoute(builder: (_) => HistoryWidget(args));
        } else {
          return _errorRoute();
        }
      case '/verwalten':
        return MaterialPageRoute(builder: (_) => const FinanceWidget());

      case "/ueberweisung":
        return MaterialPageRoute(builder: (_) => const TransferWidget());

      case "/confirm":
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => TransferConfirmationWidget(args));
        } else {
          return _errorRoute();
        }
      case "/mobile":
        return MaterialPageRoute(builder: (_) => const MobilePayWidget());

      case "/newKonto":
        return MaterialPageRoute(builder: (_) => const NewAccountWidget());

      case "/konto/uebersicht":
        return MaterialPageRoute(builder: (_) => const AccountOverviewWidget());

      case "/profile/settings":
        return MaterialPageRoute(builder: (_) => const SettingsWidget());

      case "/profile/settings/changePassword":
        return MaterialPageRoute(builder: (_) => const ChangePasswordWidget());

      case "/profile/settings/changePin":
        return MaterialPageRoute(builder: (_) => const ChangePinWidget());

      case "/profile/settings/showPin":
        return MaterialPageRoute(builder: (_) => const ShowPinWidget());

      case "/lockCard":
        return MaterialPageRoute(builder: (_) => const LockCardWidget());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
