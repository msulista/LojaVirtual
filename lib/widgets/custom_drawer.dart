import 'package:flutter/material.dart';
import 'package:loja_natura/models/user_model.dart';
import 'package:loja_natura/screens/login_screen.dart';
import 'package:loja_natura/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Produtos Natura",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Olá ${!model.isLoggedin() ? "" : model.userDate["name"]} sou a Leticia Sulzbacher,\n posso lhe ajudar?",
                                style:  TextStyle( fontSize: 18.0, fontStyle: FontStyle.italic),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedin() ?
                                  "Entre ou cadastre-se >"
                                  : "Sair",
                                  style: TextStyle(fontSize: 16.0, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  if(!model.isLoggedin()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>LoginScreen())
                                    );
                                  } else {
                                    model.singOut();
                                  }

                                },
                              ),
                            ],
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
