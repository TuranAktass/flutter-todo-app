import 'package:flutter/material.dart';
import 'package:todo_app/component/app_drawer.dart';
import 'package:todo_app/data_model/todo.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/utils/constants/color_constants.dart' as const_color;
import 'package:todo_app/view/todo_list/todo_list_view.dart';

class InputView extends StatefulWidget {
  const InputView({Key? key}) : super(key: key);

  @override
  _InputViewState createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: const AppDrawer(),
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                buildPadding(10),
                buildTitleTextField(context),
                buildPadding(10),
                buildContentTextField(context),
                buildPadding(20),
                //buildIconButton(),
              ],
            ),
          ),
        ));
  }

  Padding buildPadding(double pad) {
    return Padding(
      padding: EdgeInsets.all(pad),
    );
  }

  TextField buildContentTextField(BuildContext context) {
    return TextField(
      style:
          Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
      controller: textController,
      minLines: 30,
      maxLines: 100,
      cursorWidth: 0,
      decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: const_color.sapphire,
          hintText: "Write something",
          hintStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white)),
    );
  }

  TextField buildTitleTextField(BuildContext context) {
    return TextField(
        controller: titleController,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          hintText: "Title",
          hintStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: const_color.sapphire,
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.menu_book, size: 30, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ToDoListView()));
          },
        ),
        const Padding(padding: EdgeInsets.all(10)),
        IconButton(
          icon: const Icon(Icons.done, size: 30, color: Colors.white),
          onPressed: () {
            ToDoDatabase.instance.create(ToDo(
                category: '',
                createdAt: DateTime.now().toString(),
                isCompleted: 0,
                isImportant: 0,
                text: textController.text,
                title: titleController.text));
          },
        ),
      ],
      backgroundColor: const_color.gulfBlue,
      bottomOpacity: 0.0,
      elevation: 0.0,
    );
  }
}
