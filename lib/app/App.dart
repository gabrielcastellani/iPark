import 'package:app_estacionamento/app/pages/parking/ParkingPage.dart';
import 'package:app_estacionamento/app/pages/signup/signup_page.dart';
import 'package:app_estacionamento/app/providers/UserProvider.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:app_estacionamento/app/providers/ProfileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/signin/SignInPage.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ParkingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'iPark',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 5, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignInPage(),
      ),
    );
  }
}
