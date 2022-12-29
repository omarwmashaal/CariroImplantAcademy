import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'CIA_Table.dart';
import 'CIA_TextField.dart';
import 'Horizontal_RadioButtons.dart';

class SearchLayout extends StatefulWidget {
  SearchLayout(
      {Key? key,
      required this.radioButtons,
      required this.dataSource,
      this.loadMoreFuntcion,
      required this.columnNames,
      this.onCellTab})
      : super(key: key);

  List<String> radioButtons;
  DataGridSource dataSource;
  Function? loadMoreFuntcion;
  List<String> columnNames;
  Function? onCellTab;

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  late String Search;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Expanded(
                  child: CIA_TextField(
                    label: "Search",
                    icon: Icons.search,
                    onChange: (value) {
                      Search = value;
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: HorizontalRadioButtons(
                          names: widget.radioButtons,
                        ),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: CIA_Table(
            columnNames: widget.columnNames,
            loadFunction: widget.loadMoreFuntcion,
            dataSource: widget.dataSource,
            onCellClick: widget.onCellTab,
          ),
        ),
      ],
    );
  }
}
