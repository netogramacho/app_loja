import 'package:flutter/material.dart';
import 'package:loja_Teste/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_Teste/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  const Color.fromARGB(255, 100, 130, 150),
                  Colors.white,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
            ),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(color: Color.fromARGB(255, 4, 125, 141),),
              DrawerTile(iconData: Icons.home, title: 'Início', page: 0,),
              DrawerTile(iconData: Icons.list, title: 'Produtos', page: 1,),
              DrawerTile(iconData: Icons.playlist_add_check, title: 'Meus Pedidos', page: 2),
              DrawerTile(iconData: Icons.location_on, title: 'Lojas', page: 3),
            ],
          ),
        ],
      ),
      
    );
  }
}