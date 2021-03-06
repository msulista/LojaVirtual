import 'package:flutter/material.dart';
import 'package:loja_natura/models/user_model.dart';
import 'package:loja_natura/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: new MaterialApp(
        title: 'Loja da Gringa - Natura',
        theme: new ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 145)
        ),
        debugShowCheckedModeBanner: false,
        //home: HomeScreen(),
        home: HomeScreen(),
      ),
    );
  }
}

