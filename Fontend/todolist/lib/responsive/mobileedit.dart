import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/responsive/desktopedit.dart';
import 'package:todolist/responsive/desktopbody.dart';
import 'package:todolist/url/url.dart';
import 'package:todolist/responsive/Mobilelayout/Mobilelayout.dart';

class MobileEdit extends StatefulWidget {
  //const Mobilelayout({super.key});
  final v1, v2, v3, v4;
  MobileEdit(this.v1, this.v2, this.v3, this.v4);

  @override
  State<MobileEdit> createState() => _MobileEditState();
}

class _MobileEditState extends State<MobileEdit> {
  var _v1, _v2, _v3, _v4;
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  List Todolistitem = ['a', 'b', 'v', 'd'];

  @override
  void initState() {
    super.initState();
    getTodo();
    _v1 = widget.v1; //id
    _v2 = widget.v2; //date
    _v3 = widget.v3; //title
    _v4 = widget.v4; //detail
    dateController.text = _v2;
    titleController.text = _v3;
    detailController.text = _v4;
  }

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

  Future putTodo() async {
    var url = Uri.http(urllocal, '/api/put_Todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"date":"${dateController.text}","title":"${titleController.text}","detail":"${detailController.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('PUT_TODOLIST');
    print(url);
    print('--------result-------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http(urllocal, '/api/delete_Todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"date":"${dateController.text}","title":"${titleController.text}","detail":"${detailController.text}"}';
    var response = await http.delete(url, headers: header);
    print('DELETE_TODOLIST');
    print(url);
    print('--------result-------');
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    //final currentWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return Mobilelayout(dateController, titleController, detailController,
            Todolistitem, setState, context, putTodo, deleteTodo);
      } else {
        return DesktopBody();
      }
    });
  }
}
