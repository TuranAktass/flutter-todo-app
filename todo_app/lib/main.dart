import 'package:flutter/material.dart';
import 'package:todo_app/utils/text_constants.dart';
import 'package:todo_app/view/home/home_view.dart';

void main() => runApp(MaterialApp(
    title: "ToDo App",
    theme: ThemeData(textTheme: TextConstants().constText),
    home: const HomeView()));
