import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:todolist/responsive/Destoplayout/Desktoplayout.dart';
import 'package:todolist/url/url.dart';

class DesktopBody extends StatefulWidget {
  //const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  List Todolistitem = ['a', 'b', 'v', 'd'];

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Future<void> getTodo() async {
    //List allTodo = [];
    var url = Uri.http(urllocal, '/api/get_Todolist/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print("result : $result");
    setState(() {
      Todolistitem = jsonDecode(result);
    });
  }

  @override
  Future postTodo() async {
    var url = Uri.http(urllocal, '/api/post_Todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"date":"${dateController.text}","title":"${titleController.text}","detail":"${detailController.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result-------');
    print(response.body);
  }

  Future deleteTodo() async {
    print('DELETE_TODOLIST');
  }

  @override
  Widget build(BuildContext context) {
    //final currentWidth = MediaQuery.of(context).size.width;
    return Mydesktoplayout(dateController, titleController, detailController,
        Todolistitem, setState, context, postTodo, deleteTodo);
  }
}
