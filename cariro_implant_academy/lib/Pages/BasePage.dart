import 'dart:math';
import 'dart:typed_data';

import 'package:cariro_implant_academy/Pages/Pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/myTextField.dart';

Uint8List? myImageBytes = new Uint8List(2);

enum PageStates {
  MainDoctor,
  MainPatient,
  MainCandidate,
  MainStock,
  MainOperation,
  AddDoctor,
  AddPatient,
  AddCandidate,
  AddStock,
  AddOperation,
  EditDoctor,
  EditPatient,
  EditCandidate,
  EditStock,
  EditOperation
}

enum MainPages { Doctors, Candidates, Patients, Operations, Stock }

class BasePage extends StatefulWidget {
  BasePage(
      {required this.mainPage,
      required this.pageState,
      required this.columnNames,
      required this.title,
      required this.rows});

  String title;
  List<List<String>> rows;
  List<String> columnNames;
  PageStates pageState;
  MainPages mainPage;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Content();
  }

  Widget Content() {
    if (widget.pageState == PageStates.MainDoctor) {
      return DoctorsPage(rows: GetRows(), notify: (value)
        {
          setState((){
            widget.pageState = value;
          });
        },);
    }
    else if (widget.pageState == PageStates.AddDoctor) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.pageState = PageStates.MainDoctor;
                          });
                        },
                        child: Icon(Icons.arrow_back))),
                Expanded(
                    flex: 10,
                    child: Center(
                        child: Text(
                      "Add New Doctor",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 50),
                    ))),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(200, 50, 200, 50),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Image.memory(
                            myImageBytes!
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var picked = await (await ImagePicker()
                                      .pickImage(source: ImageSource.gallery))
                                  !.readAsBytes();

                              setState(() {
                                myImageBytes = picked;
                              });
                            },
                            child: Text("Upload Image")),
                        Expanded(
                          child: MyTextField(
                            label: "Name",
                            icon: Icons.account_box_rounded,
                          ),
                        ),
                        Expanded(
                            child: MyTextField(
                          label: "Date Of Birth",
                          icon: Icons.calendar_month,
                        )),
                        Expanded(
                            child: MyTextField(
                          label: "National ID",
                          icon: Icons.supervisor_account,
                        )),
                        Expanded(
                            child: MyTextField(
                          label: "Email",
                          icon: Icons.email,
                        )),
                        Expanded(
                            child: MyTextField(
                          label: "Specialization",
                          icon: Icons.add,
                        )),
                        ElevatedButton(
                            onPressed: () {}, child: Text("Add New Doctor")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      );
    } else
      return Container();
  }

  List<DataRow> GetRows() {
    List<DataCell> tempCells = <DataCell>[];
    List<DataRow> returnRows = <DataRow>[];
    for (List<String> row in widget.rows) {
      tempCells = [];
      for (String cell in row) {
        tempCells.add(
          DataCell(
            GestureDetector(
              onTap: () {
                switch (widget.mainPage) {
                  case MainPages.Doctors:
                    setState(() {
                      widget.pageState = PageStates.EditDoctor;
                    });
                    break;
                  case MainPages.Operations:
                    setState(() {
                      widget.pageState = PageStates.EditOperation;
                    });
                    break;
                  case MainPages.Candidates:
                    setState(() {
                      widget.pageState = PageStates.EditCandidate;
                    });
                    break;
                  case MainPages.Patients:
                    setState(() {
                      widget.pageState = PageStates.EditPatient;
                    });
                    break;
                  case MainPages.Stock:
                    setState(() {
                      widget.pageState = PageStates.EditStock;
                    });
                    break;
                }
              },
              child: Text(cell),
            ),
          ),
        );
      }
      returnRows.add(DataRow(cells: tempCells));
    }
    return returnRows;
  }
}
