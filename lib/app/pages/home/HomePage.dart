import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/pages/map/map_page.dart';
import 'package:app_estacionamento/app/pages/parking/ParkingPage.dart';
import 'package:app_estacionamento/app/pages/profile/ProfilePage.dart';
import 'package:app_estacionamento/app/blocs/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../parking/ParkingPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static const String _title = 'iPark';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: Menu(),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ParkingPage(),
    MapPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if(this.mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Estacionamento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
