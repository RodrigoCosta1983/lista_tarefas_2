import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    // debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _toDoController =
      TextEditingController(); // To search for the text there in the TextField, first create the controller

   List _toDoList = [];

  void _addTodo() {
   setState(() {
     Map<String, dynamic> newTodo = Map();
     newTodo["title"] = _toDoController.text;
     _toDoController.text = "";
     newTodo["OK"] = false;
     _toDoList.add(newTodo);
   });

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de Tarefas"),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: _toDoController,
                    decoration: const InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                  )),
                  ElevatedButton(
                      onPressed: _addTodo,
                      child: const Text(
                        "ADD",
                        style: TextStyle(color: Colors.blueGrey),
                      ))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(_toDoList[index]["title"]),
                      value: _toDoList[index]["OK"],
                      secondary: CircleAvatar(
                        child: Icon(
                            _toDoList[index]["OK"] ? Icons.check : Icons.error),
                      ),
                      onChanged: (bool? value) {},
                    );
                  }),
            )
          ],
        ),
      );
    }

    Future<File> _getFile() async {
      final directory = await getApplicationDocumentsDirectory();
      return File("${directory.path}/data.json");
    }

    Future<File> _saveData() async {
      String data = json.encode(_toDoList);
      final file = await _getFile();
      return file.writeAsString(data);
    }

    Future<String?> _readData() async {
      try {
        final file = await _getFile();
        return file.readAsString();
      } catch (e) {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
