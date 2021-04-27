import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lsrtcc_flutter/screens/calendar_screen.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/screens/registerBand_screen.dart';
import 'package:lsrtcc_flutter/screens/registerPub_screen.dart';
import 'package:lsrtcc_flutter/screens/welcome_screen.dart';
import 'package:lsrtcc_flutter/screens/login_screen.dart';
import 'package:lsrtcc_flutter/screens/registration_screen.dart';
import 'package:lsrtcc_flutter/services/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/welcome_screen_debug.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String userInfo = prefs.getString('userLoggedInResponseBody');
  var isLoggedIn = userInfo == null ? false : true;
  Intl.defaultLocale = "pt_BR";
  initializeDateFormatting();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? ProfileScreen.id : WelcomeScreen.id,
      routes: {
        WelcomeScreenDebug.id: (context) => WelcomeScreenDebug(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        RegisterBandScreen.id: (context) => RegisterBandScreen(),
        RegisterPubScreen.id: (context) => RegisterPubScreen(),
        CalendarScreen.id: (context) => CalendarScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    ),
  );
}

// void main() => runApp(LsrTcc());

// void main() {
//   Intl.defaultLocale = "pt_BR";
//   initializeDateFormatting().then((_) => runApp(LsrTcc()));
// }

// class LsrTcc extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: WelcomeScreen.id,
//       routes: {
//         WelcomeScreenDebug.id: (context) => WelcomeScreenDebug(),
//         WelcomeScreen.id: (context) => WelcomeScreen(),
//         LoginScreen.id: (context) => LoginScreen(),
//         RegistrationScreen.id: (context) => RegistrationScreen(),
//         RegisterBandScreen.id: (context) => RegisterBandScreen(),
//         RegisterPubScreen.id: (context) => RegisterPubScreen(),
//         CalendarScreen.id: (context) => CalendarScreen(),
//         ProfileScreen.id: (context) => ProfileScreen(),
//       },
//     );
//   }
// }
