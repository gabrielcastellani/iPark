import 'package:app_estacionamento/app/common/custom_drawer/DrawerTile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerTile(
            iconData: Icons.home,
            title: 'Início',
            page: 0,
          ),
          DrawerTile(
            iconData: Icons.list,
            title: 'Estacionamentos',
            page: 1,
          ),
          DrawerTile(
            iconData: Icons.location_on,
            title: 'Mapa',
            page: 2,
          ),
          DrawerTile(
            iconData: Icons.person,
            title: 'Usuário',
            page: 3,
          ),
          DrawerTile(
            iconData: Icons.backspace,
            title: 'Sair',
            page: 4,
          ),
        ],
      ),
    );
  }
}
