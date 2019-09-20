import 'package:bookster/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import './Pages/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(
      home: _handleWindowDisplay(),
      debugShowCheckedModeBanner: false,
    ));

Widget _handleWindowDisplay() {
  
  return StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: Text("Loading..."));
      } else {
        if(snapshot.hasData){
          return HomePage();
        }else{
          return Login();
        }
      }
    },
  );
}
