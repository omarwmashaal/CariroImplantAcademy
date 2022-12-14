

import 'package:cariro_implant_academy/Pages/Pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorsPage extends StatefulWidget {
  DoctorsPage( {required this.notify, this.rows, Key? key}) : super(key: key);

  String title = "Doctors";
  List<DataRow>? rows;
  Function notify;
  PageStates? pageStates;
  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {

        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400),
                ),
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              label: Text("Search by name")),
                        ),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.notify(PageStates.AddDoctor);
                      });
                    },
                    child: Text("Add New " + widget.title),
                  )
                ],
              )),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Age")),
                    DataColumn(label: Text("Phone Number")),
                    DataColumn(label: Text("Join Date")),
                  ],
                  rows: widget.rows!,
                ),
              ))
        ]);


    }

  }

