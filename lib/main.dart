import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/login/login.dart';
import 'package:todo/screens/signup/signup.dart';
import 'package:todo/screens/tasks/edit_task_bottomsheet.dart';
import 'package:todo/shared/styles/theming/my_theme.dart';
import 'firebase_options.dart';
import 'layout/home_layout.dart';
import 'providers/my_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const fatalError = true;
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
   // FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context)=> MyProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser!=null?HomeLayout.routeName
          :LoginScreen.routeName,
      routes: {
        HomeLayout.routeName: (context)=> HomeLayout(),
        EditTaskButtomSheet.routeName: (context)=>EditTaskButtomSheet(),
        LoginScreen.routeName:(context)=> LoginScreen(),
        SignUpScreen.routeName: (context)=> SignUpScreen(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
    );
  }
}

