import 'package:flutter/material.dart';
import 'package:todo_app/component/app_drawer.dart';
import 'package:todo_app/data_model/todo.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/utils/color_constants.dart' as const_color;

class ToDoListView extends StatefulWidget {
  const ToDoListView({Key? key}) : super(key: key);

  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: buildAppBar(context),
      body: _isLoading ? const CircularProgressIndicator() : buildListView(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: const [
        Padding(padding: EdgeInsets.all(10)),
      ],
      title: Text("ToDo's",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white)),
      backgroundColor: const_color.gulfBlue,
    );
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
              decoration: BoxDecoration(
                  color: const_color.anakiwa,
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.only(bottom: 10),
              child: buildListTile(index));
        });
  }

  Dismissible buildListTile(int index) {
    return Dismissible(
      key: ValueKey<ToDo>(list[index]),
      onDismissed: (direction) async {
        await ToDoDatabase.instance.delete(list[index].id!);
        getTodosFromDatabase();
      },
      child: ListTile(
          minVerticalPadding: 20,
          leading: list[index].isCompleted == 1
              ? const Icon(Icons.task_alt)
              : const Icon(Icons.clear),
          subtitle: Text(list[index].createdAt.toString()),
          trailing: const Icon(Icons.expand_more),
          title: Text(
            list[index].title,
          )),
    );
  }
}
