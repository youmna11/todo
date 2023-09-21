import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../layout/home_layout.dart';
import '../../providers/my_provider.dart';
import '../../shared/network/firebase/firebase_functions.dart';
import '../../shared/styles/colors/app_colors.dart';
import '../signup/signup.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName='LoginScreen';
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Log In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value){
                  if(value==null || value ==""){
                    return "Please Enter UserName";
                  }
                  final bool emailValid =
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                      .hasMatch(value);
                  if(!emailValid){
                    return "Please enter valid Email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("UserName"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: primaryColor
                      )
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: primaryColor
                      )
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: passwordController,
                validator: (value){
                  if(value==null || value.length<6){
                    return "Please enter valid Password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Password"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: primaryColor
                      )
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: primaryColor
                      )
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                     FirebaseFunctions.login(emailController.text,
                         passwordController.text,(){
                            pro.initMyUser();
                       Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routeName, (route) => false);
                         });
                    }
                  },
                  child: Text("Login",style: TextStyle(color: Colors.white),)),
              Row(
                children: [
                  Text("Don't have an Account ?..."),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Text("Create Account"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
