import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:todolist/responsive/mobilebody.dart';
import 'package:todolist/url/url.dart';
import 'package:todolist/responsive/Destoplayout/Desktoplayout.dart';

class DesktopEdit extends StatefulWidget {
  //const DesktopBody({super.key});
  final v1, v2, v3, v4;
  DesktopEdit(this.v1, this.v2, this.v3, this.v4);

  @override
  State<DesktopEdit> createState() => _DesktopEditState();
}

class _DesktopEditState extends State<DesktopEdit> {
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
        return MobileBody();
      } else {
        return Mydesktoplayout(
            dateController,
            titleController,
            detailController,
            Todolistitem,
            setState,
            context,
            putTodo,
            deleteTodo);
      }
    });
  }
}
//dateController, titleController, detailController,
        //Todolistitem, setState, context, postTodo