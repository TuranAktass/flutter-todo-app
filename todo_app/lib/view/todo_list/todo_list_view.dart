import 'package:flutter/material.dart';
import 'package:todo_app/component/app_drawer.dart';
import 'package:todo_app/data_model/todo.dart';
import 'package:todo_app/fake_data.dart' as fake_data;
import 'package:todo_app/utils/color_constants.dart' as const_color;

class ToDoListView extends StatefulWidget {
  const ToDoListView({Key? key}) : super(key: key);

  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  List<ToDo> list = fake_data.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: buildAppBar(context),
      body: buildListView(),
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

  ListTile buildListTile(int index) {
    return ListTile(
        minVerticalPadding: 20,
        leading: list[index].isCompleted!
            ? const Icon(Icons.task_alt)
            : const Icon(Icons.clear),
        subtitle: Text(list[index].createdAt.toString()),
        trailing: const Icon(Icons.expand_more),
        title: Text(
          list[index].title!,
        ));
  }
}
