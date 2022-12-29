import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/StockModel.dart';
import '../../Widgets/CIA_PrimaryButton.dart';
import '../../Widgets/Title.dart';

class LAB_StockSearchPage extends StatefulWidget {
  const LAB_StockSearchPage({Key? key}) : super(key: key);

  @override
  State<LAB_StockSearchPage> createState() => _LAB_StockSearchPageState();
}

class _LAB_StockSearchPageState extends State<LAB_StockSearchPage> {
  StockDataSource dataSource = StockDataSource();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(),
          ),

          Row(
            children: [
              Expanded(
                child: TitleWidget(
                  title: "Stock",
                ),
              ),
              CIA_PrimaryButton(
                onTab: () {},
                label: "Remove Item",
                isLong: true,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              CIA_PrimaryButton(
                onTab: () {},
                label: "Add Item",
                isLong: true,
                color: Colors.green,
              ),
              SizedBox(width: 30)
            ],
          ),
          // Obx(() =>widget.pages[tabsController.index.value] ),
          Expanded(
              flex: 10,
              child: SearchLayout(
                radioButtons: [
                  "ID",
                  "Name",
                ],
                dataSource: dataSource,
                columnNames: StockModel.columns,
                onCellTab: (value) {
                  print(dataSource.models[value - 1].ID);
                },
              ))
        ],
      ),
    );
  }
}
