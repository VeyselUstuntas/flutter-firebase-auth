import 'package:firebase_kullanimi/features/auth/views/sign_in.dart';
import 'package:firebase_kullanimi/service/auth_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var authService = AuthService().firebaseAuth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home"),),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: (){
              if(authService.currentUser != null){
                setState(() {
                  authService.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));
                });
              }
            }, child: Text("Cikis Yap")),
          ],
        ),
      ),
    );
  }
}
