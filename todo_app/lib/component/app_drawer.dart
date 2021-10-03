import 'package:flutter/material.dart';
import 'package:todo_app/view/add_todo/input_view.dart';
import 'package:todo_app/view/home/home_view.dart';
import 'package:todo_app/view/todo_list/todo_list_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeView()))),
          _createDrawerItem(
              icon: Icons.list,
              text: "ToDo's",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ToDoListView()))),
          _createDrawerItem(
              icon: Icons.add,
              text: "Add something",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const InputView()))),
          const ListTile(
            title: Text('1.0.1'),
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: const <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("ToDo App",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
}

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
