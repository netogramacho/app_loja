import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_Teste/models/product_manager.dart';
import 'package:loja_Teste/models/user_manager.dart';
import 'package:loja_Teste/screens/base/base_screen.dart';
import 'package:loja_Teste/screens/login/login_screen.dart';
import 'package:loja_Teste/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,  
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Loja Teste',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation:0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/base':
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen()
              );
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen() 
              );
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
            );
          }
        },
      ),
    );
  }
}
