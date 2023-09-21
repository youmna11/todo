import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../layout/home_layout.dart';
import '../../providers/my_provider.dart';
import '../../shared/network/firebase/firebase_functions.dart';
import '../../shared/styles/colors/app_colors.dart';
import '../login/login.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = 'SignUp';
  SignUpScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: nameController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please Enter Name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Name"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: ageController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please Enter Age";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Age"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: emailController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please Enter Email";
                  }
                  final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return "Please enter valid Email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("UserName"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.length < 4) {
                    return "Please enter valid Password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Password"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseFunctions.signUp(emailController.text,
                      passwordController.text,nameController.text,int.parse(ageController.text)).then((value){
                        pro.initMyUser();
                        Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routeName, (route) => false);
                      }).catchError((e){
                        print(e);
                      });

                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  )),
              Row(
                children: [
                  Text(" I Have an Account .....!"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.routeName, (route) => false);
                      },
                      child: Text("Login"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
