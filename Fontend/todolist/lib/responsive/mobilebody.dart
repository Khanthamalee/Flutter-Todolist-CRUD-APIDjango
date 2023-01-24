import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/responsive/mobileedit.dart';
import 'package:todolist/responsive/Mobilelayout/Mobilelayout.dart';
import 'package:todolist/url/url.dart';

class MobileBody extends StatefulWidget {
  //const Mobilelayout({super.key});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
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
    return Mobilelayout(dateController, titleController, detailController,
        Todolistitem, setState, context, postTodo, deleteTodo);
  }
}
