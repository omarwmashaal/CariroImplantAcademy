import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/StockModel.dart';
import '../SharedPages/StocksSharedPage.dart';

class LAB_StockSearchPage extends StatefulWidget {
  const LAB_StockSearchPage({Key? key}) : super(key: key);

  @override
  State<LAB_StockSearchPage> createState() => _LAB_StockSearchPageState();
}

class _LAB_StockSearchPageState extends State<LAB_StockSearchPage> {
  StockLogsDataSource logs_dataSource = StockLogsDataSource();
  StockDataSource stocks_dataSource = StockDataSource();

  @override
  Widget build(BuildContext context) {
    return StockListSharedPage(

    );
  }
}
