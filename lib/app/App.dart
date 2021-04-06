import 'package:app_estacionamento/app/pages/home/HomePage.dart';
import 'package:app_estacionamento/app/pages/parking/newParking_page.dart';
import 'package:app_estacionamento/app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'iPark',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 5, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(), //SignInPage(),
      ),
    );
  }
}
