import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/network/firebase/firebase_functions.dart';
import '../models/user_model.dart';

class MyProvider extends ChangeNotifier{


  ThemeMode themeMode = ThemeMode.light;
  String language='en';

  UserModel? userModel;
  User? firebaseUser;

  MyProvider(){
    firebaseUser= FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initMyUser();
    }
  }

  void initMyUser() async{
    firebaseUser=FirebaseAuth.instance.currentUser;
    userModel= await FirebaseFunctions.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void logOut(){
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }


  void changeThem(ThemeMode theme){
    themeMode=theme;
    notifyListeners();
  }
  void changeLanguage(String lang){
    language=lang;
    notifyListeners();
  }



}