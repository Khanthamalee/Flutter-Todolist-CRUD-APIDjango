import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:todolist/responsive/desktopedit.dart';
import 'package:todolist/responsive/desktopbody.dart';
import 'package:todolist/main.dart';

@override
Widget Mydesktoplayout(
  TextEditingController dateController,
  TextEditingController titleController,
  TextEditingController detailController,
  List Todolistitem,
  setState,
  context,
  post_putTodo(),
  delete_Todo(),
) {
  return Material(
    child: SafeArea(
      child: Row(
        children: [
          AspectRatio(
              aspectRatio: 0.8,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/flo.jpg"),
                  fit: BoxFit.cover,
                  scale: 0.5,
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(255, 254, 253, 253).withOpacity(0.2),
                      BlendMode.dstATop),
                )),
                //color: Colors.green[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          "TODOLISTAPPLICATION",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 6, 78, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Center(child: Text(currentWidth.toString())),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                              width: 130,
                              child: Column(children: [
                                TextField(
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                    controller:
                                        dateController, //editing controller of this TextField
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Color.fromARGB(255, 6, 78, 1),
                                      ),
                                      //icon of text field
                                      labelText: "DATE : ",
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(255, 6, 78, 1),
                                          fontSize: 18.0),
                                      //label text of field
                                    ),
                                    readOnly:
                                        true, // when true user cannot edit text
                                    onTap: () async {
                                      //when click we have to show the datepicker
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime
                                                  .now(), //get today's date
                                              firstDate: DateTime(
                                                  2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd').format(
                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2022-07-04
                                        //You can format date as per your need

                                        setState(() {
                                          dateController.text =
                                              formattedDate; //set foratted date to TextField value.
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    })
                              ])),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: titleController,
                          //obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 6, 78, 1)),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 6, 78, 1),
                                fontSize: 18.0),
                          ),
                          style: TextStyle(fontSize: 18.0, color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: detailController,
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                          maxLines: 15,
                          //obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 6, 78, 1)),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'Detail',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 6, 78, 1),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ElevatedButton(
                              onPressed: () {
                                print('-----result------');
                                print('Date : ${dateController.text}');
                                print('Title : ${titleController.text}');
                                print('Detail : ${detailController.text}');

                                post_putTodo();
                                setState(() {
                                  dateController.clear();
                                  titleController.clear();
                                  detailController.clear();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DesktopBody()));
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 6, 78, 1),
                                  fixedSize: const Size(100, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: const Text('SAVE'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              iconSize: 40.0,
                              color: Color.fromARGB(255, 255, 3, 3),
                              onPressed: () {
                                delete_Todo();
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DesktopBody()));
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                              icon: const Icon(Icons.refresh_sharp),
                              iconSize: 40.0,
                              color: Color.fromARGB(255, 5, 21, 248),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Homepage()));
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
            child: ListView.builder(
              itemCount: Todolistitem.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color.fromARGB(255, 32, 114, 64),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              "DATE : ${Todolistitem[index]["date"]} \nTITLE : ${Todolistitem[index]["title"]} \nDETAIL : ${Todolistitem[index]["detail"]}"),
                          textColor: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  print(
                                      'Todolistitem[index]["id"] : ${Todolistitem[index]["id"]}');
                                  print(Todolistitem[index]["date"]);
                                  print(Todolistitem[index]["title"]);
                                  print(Todolistitem[index]["detail"]);
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DesktopEdit(
                                                Todolistitem[index]["id"],
                                                Todolistitem[index]["date"],
                                                Todolistitem[index]["title"],
                                                Todolistitem[index]
                                                    ["detail"])));
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 180, 183, 3),
                                    fixedSize: const Size(70, 35),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: const Text('EDIT'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
