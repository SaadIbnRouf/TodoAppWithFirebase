import 'package:flutter/material.dart';
import 'package:todoappwithfirebase/model/todoDataModel.dart';
import 'package:todoappwithfirebase/route/routes.dart';
import 'package:todoappwithfirebase/service/authService.dart';
import 'package:todoappwithfirebase/view/authView/loginPageView.dart';
import 'package:todoappwithfirebase/view/todoView/newTodoView.dart';
import 'package:todoappwithfirebase/view/todoView/todoGridView.dart';
import 'package:todoappwithfirebase/view/todoView/todoListView.dart';
import '../../service/localDatabaseHelper.dart';

class TodoAppBarView extends StatefulWidget {
  const TodoAppBarView({Key? key}) : super(key: key);

  @override
  State<TodoAppBarView> createState() => _TodoAppBarViewState();
}

class _TodoAppBarViewState extends State<TodoAppBarView> {
  bool _check = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalDataBaseHelper.getDB();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: SizedBox(
                  height: 10.0,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.newspaper,
                ),
                title: const Text('Read Blog'),
                onTap: () {
                  Navigator.pushNamed(context, RouteManager.blogPage);
                },
              ),
              SizedBox(height: 5.0),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text('Logout'),
                onTap: logOut,
              ),
            ],
          ),
        ),
        floatingActionButton: myFabView(),
        appBar: myAppBar(),
        body: FutureBuilder<List<TodoDataModel>?>(
            future: LocalDataBaseHelper.getAllTask(),
            builder: (context, AsyncSnapshot<List<TodoDataModel>?> snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapShot.hasError) {
                return Center(
                  child: Text(
                    snapShot.error.toString(),
                  ),
                );
              } else if (snapShot.hasData) {
                if (snapShot.data != null) {
                  return _check
                      ? TodoListView(data: snapShot.data!) // snapShot.data!
                      : TodoGridView(data: snapShot.data!);
                }
              }
              return const Text('No Widget to Build');
            }),
      ),
    );
  }

  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: const Text('Your Tasks'),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      actions: [
        // iconButton(false),
        // iconButton(true),
        _check ? iconButton(false) : iconButton(true),
      ],
    );
  }

  Widget myFabView() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTodoView()),
        );
        setState(() {});
      },
      child: const Icon(Icons.add),
    );
  }

  Widget iconButton(bool item) {
    return IconButton(
      onPressed: () {
        setState(() {
          _check = item;
        });
      },
      icon: item ? const Icon(Icons.list) : const Icon(Icons.grid_view),
    );
  }

  void logOut() async {
    await AuthService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPageView(),
        settings: RouteSettings(name: '/login'),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
