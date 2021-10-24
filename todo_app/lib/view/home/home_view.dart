import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/component/app_drawer.dart';
import 'package:todo_app/data_model/todo.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/utils/constants/color_constants.dart'
    as color_constants;
import 'package:todo_app/utils/date_format.dart';
import 'package:todo_app/view/add_todo/input_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ToDo> list = [];

  bool _isLoading = false;

  getTodosFromDatabase() async {
    setState(() {
      _isLoading = true;
    });

    list = await ToDoDatabase.instance.readAllTodos();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getTodosFromDatabase();
    super.initState();
  }

  List<ToDo> importants = [];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // this should be change
    for (int i = 0; i < list.length; i++) {
      if (list[i].isImportant == 1) {
        importants.add(list[i]);
      }
    }
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: buildAppBar(context),
      body: Column(
        children: [
          list.isEmpty
              ? const Center(child: Text("There's no Data"))
              : Expanded(
                  child: StaggeredGridView.countBuilder(
                    itemCount: list.length,
                    crossAxisCount: 4,
                    itemBuilder: (BuildContext context, int index) =>
                        buildGridViewItem(size, list[index]),
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(2, index.isEven ? 2 : 1),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                )
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Container buildGridViewItem(Size size, ToDo todo) {
    return Container(
        color: Colors.amberAccent,
        height: size.height * 0.6,
        width: size.width * 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(todo.title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5),
                Text(dateFormat(todo.createdAt, true),
                    textAlign:
                        TextAlign.left), //true can be changed via settings page
                Text(todo.text),
              ],
            ),
          ),
        ));
  }

  //this should be change too, i'm going to add staggered grid view instead of this
  Expanded buildHistoryList() {
    return Expanded(
        flex: 2,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
                trailing: const Icon(Icons.arrow_forward),
                title: Text(list[index].title),
                subtitle: Text(list[index].createdAt));
          },
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: color_constants.gulfBlue,
        title: Text("ToDo App",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white)));
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InputView()));
      },
      child: const Icon(Icons.add),
      backgroundColor: color_constants.sapphire,
    );
  }
}
