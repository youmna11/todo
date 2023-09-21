import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/settings/settings.dart';
import 'package:todo/screens/tasks/tasks.dart';
import '../providers/my_provider.dart';
import '../screens/login/login.dart';
import '../screens/tasks/add_task_bottomsheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName="HomeLayout";
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;
  List<Widget>tabs=[TasksTab(),SettingsTab()];

  @override
  Widget build(BuildContext context) {
    var pro =Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("ToDo ${pro.userModel?.name}"),
        actions: [IconButton(
            onPressed: (){
              pro.logOut();
              Navigator.pushNamedAndRemoveUntil(context,
                  LoginScreen.routeName, (route) => false);
            },
            icon: Icon(Icons.logout,
              color: Colors.white,size: 30,))],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 4,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: (){
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        notchMargin: 8,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap: (value){
            currentIndex=value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: ""),
          ],
        ),
      ),
      body: tabs[currentIndex],
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18)
          )),
        context: context,
        builder: (context) => Padding(
          padding:
          EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
            child: AddTaskBottomSheet()
        ),
    );
  }
}
