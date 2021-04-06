import 'package:app_estacionamento/app/common/custom_drawer/CustomDrawer.dart';
import 'package:app_estacionamento/app/pages/signin/SignInPage.dart';
import 'package:app_estacionamento/app/pages/parking/ParkingPage.dart';
import 'package:app_estacionamento/app/providers/PageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageProvider(_pageController),
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          // Scaffold(
          //   drawer: CustomDrawer(),
          //   appBar: AppBar(
          //     title: const Text('Home'),
          //   ),
          // ),
          //ParkingPage(),
          SignInPage(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Estacionamentos'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Mapa'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Usuário'),
            ),
          ),
        ],
      ),
    );
  }
}
