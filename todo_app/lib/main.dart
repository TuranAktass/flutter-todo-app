import 'package:flutter/material.dart';
import 'package:todo_app/utils/text_constants.dart';
import 'package:todo_app/view/home/home_view.dart';

void main() => runApp(MaterialApp(
    title: "ToDo App",
    theme: ThemeData(textTheme: TextConstants().constText),
    home: const HomeView()));

/*
1- delete işlemi eklenecek, database'de var, listTile'lara ikonlar eklenecek, belki yana kaydırarak silinebilir.
2-tasarımda değişiklikler yapılabilir
3- expand animasyounla ilgili todo büyüyebilir hale gelecek


*/