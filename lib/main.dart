import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lsrtcc_flutter/screens/calendar_screen.dart';
import 'package:lsrtcc_flutter/screens/my_bands_empty.dart';
import 'package:lsrtcc_flutter/screens/my_events.dart';
import 'package:lsrtcc_flutter/screens/my_events_empty.dart';
import 'package:lsrtcc_flutter/screens/my_pubs.dart';
import 'package:lsrtcc_flutter/screens/my_pubs_empty.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/screens/registerBand_screen.dart';
import 'package:lsrtcc_flutter/screens/registerPub_screen.dart';
import 'package:lsrtcc_flutter/screens/my_bands.dart';
import 'package:lsrtcc_flutter/screens/search.dart';
import 'package:lsrtcc_flutter/screens/welcome_screen.dart';
import 'package:lsrtcc_flutter/screens/login_screen.dart';
import 'package:lsrtcc_flutter/screens/registration_screen.dart';
import 'package:lsrtcc_flutter/services/api_data.dart';
import 'package:lsrtcc_flutter/services/user_preferences.dart';
import 'package:provider/provider.dart';
import 'components/DateTimePicker.dart';
import 'screens/all_registrations_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/welcome_screen_debug.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await UserSimplePreferences.init();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // String userInfo = prefs.getString('userLoggedInResponseBody');
  // var isLoggedIn = userInfo == null ? false : true;

  await GetStorage.init();
  final userdata = GetStorage();
  userdata.writeIfNull('userIsLogged', false);

  // Intl.defaultLocale = "pt_BR";
  // initializeDateFormatting();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiData(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("pt"),
        ],
        debugShowCheckedModeBanner: false,
        initialRoute:
            // ! tela inicial TESTE:
            // WelcomeScreenDebug.id,
            // * tela inicial verdadeira:
            userdata.read('userIsLogged') ? ProfileScreen.id : WelcomeScreen.id,
        routes: {
          WelcomeScreenDebug.id: (context) => WelcomeScreenDebug(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          RegisterBandScreen.id: (context) => RegisterBandScreen(),
          RegisterPubScreen.id: (context) => RegisterPubScreen(),
          CalendarScreen.id: (context) => CalendarScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          DateTimePicker.id: (context) => DateTimePicker(),
          AllRegistrationsScreen.id: (context) => AllRegistrationsScreen(),
          MyBands.id: (context) => MyBands(),
          MyBandsEmpty.id: (context) => MyBandsEmpty(),
          MyPubs.id: (context) => MyPubs(),
          MyPubsEmpty.id: (context) => MyPubsEmpty(),
          MyEvents.id: (context) => MyEvents(),
          MyEventsEmpty.id: (context) => MyEventsEmpty(),
          SearchScreen.id: (context) => SearchScreen(),
        },
      ),
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
