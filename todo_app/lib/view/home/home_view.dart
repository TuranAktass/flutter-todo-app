import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/component/app_drawer.dart';
import 'package:todo_app/data_model/todo.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/utils/color_constants.dart' as color_constants;
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
          buildNearestEventCard(),
          buildImportantsList(size),

          //other elements will be inside this expanded
          list.isEmpty
              ? const Center(child: Text("There's no Data"))
              : buildHistoryList(),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

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

  Expanded buildImportantsList(Size size) {
    return Expanded(
      flex: 2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: importants.length,
          itemBuilder: (context, index) {
            return buildImportantsCard(index, size);
          }),
    );
  }

  Expanded buildNearestEventCard() {
    return Expanded(
        flex: 1,
        child: Card(
            color: Colors.amberAccent,
            child: Column(
              children: const [
                ListTile(
                    title: Text("Nearest Event"), subtitle: Text("Event Date")),
                Padding(
                    padding: EdgeInsets.all(12),
                    child: SingleChildScrollView(
                        child: Text("TEXEVEASDKSANDSAKNCNAKCSAKCS")))
              ],
            )));
  }

  Card buildImportantsCard(int index, Size size) {
    return Card(
        color: color_constants.anakiwa,
        child: SizedBox(
          height: size.height / 4,
          width: size.width / 1.5,
          child: Column(
            children: [
              ListTile(
                trailing: IconButton(
                    icon: const Icon(Icons.expand_more), onPressed: () {}),
                title: Text(importants[index].title),
                subtitle: Text(importants[index].createdAt),
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                      decoration: const BoxDecoration(),
                      height: size.height / 8,
                      child: SingleChildScrollView(
                          child: Text(importants[index].text,
                              textAlign: TextAlign.start)))),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: color_constants.gulfBlue,
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.done))
                ],
              )
            ],
          ),
        ));
  }

  Container getImportantsCard(Size size, int index) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color_constants.anakiwa),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        width: size.width / 2,
        height: size.height / 2,
        child: Column(
          children: [
            Text(importants[index].title),
          ],
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

String dateFormat(DateTime dateTime, bool withClock) {
  if (withClock) {
    return DateFormat('yyyy-MM-dd \n kk:mm').format(dateTime);
  }

  return DateFormat('yyyy-MM-dd').format(dateTime);
}

/*

Kullanıcı yapılacak listesi oluşturabilecek
Anasayfayda en yakın yapılacak iş gösterilecek
yapılacak eklenecek bir sayfa olacak
yapılacakların özellikleri:
  -> String olarak bir metin tutulacak
  -> verinin tarihi olacak
  -> önemli olarak işaretlenebilir olacak, eğer önemli olarak işaretlendiyse
  anasayfaya düşecek, yoksa düşmeyecek
*/