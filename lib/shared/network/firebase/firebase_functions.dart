import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/task_model.dart';
import '../../../models/user_model.dart';

class FirebaseFunctions{
  static CollectionReference<TaskModel> getTasksCollection(){
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _){
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _){
        return value.toJson();
      },);

  }

  static CollectionReference<UserModel> getUsersCollection(){
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _){
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _){
        return value.toJson();
      },);

  }

  static Future<void> addTask(TaskModel task){
    var collection =getTasksCollection();
    var docRef= collection.doc();
    task.id=docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>>getTask(DateTime date){
    print(date.millisecondsSinceEpoch);
    return getTasksCollection()
    .where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void>deleteTask(String id){
    return getTasksCollection().doc(id).delete();
  }

  static Future<void>updateTask(TaskModel task){
    return getTasksCollection().doc(task.id).update(task.toJson());
  }

  static Future<void>signUp(String email, String password, String name, int age)async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      // credential.user!.sendEmailVerification();


      UserModel userModel=UserModel
        (name: name,
          id: credential.user!.uid,
          age: age,
          email: email);
      var collection= getUsersCollection();
      var docRef=collection.doc(credential.user!.uid);
      docRef.set(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void>login(String email, String password,Function onComplete)async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        onComplete();
      });
    } on FirebaseAuthException catch (e) {
      print("Wrong email or password");
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
    }
  }

  static Future<UserModel?> readUser(String userId) async{
    DocumentSnapshot<UserModel> userDoc=
    await getUsersCollection().doc(userId).get();
    return userDoc.data();
  }

}