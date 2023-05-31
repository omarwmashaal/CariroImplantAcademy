import 'package:cariro_implant_academy/Pages/SharedPages/StocksSharedPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/StockModel.dart';

class StockSearchPage extends StatefulWidget {
  const StockSearchPage({Key? key}) : super(key: key);

  @override
  State<StockSearchPage> createState() => _StockSearchPageState();
}

class _StockSearchPageState extends State<StockSearchPage> {
  StockLogsDataSource logs_dataSource = StockLogsDataSource();
  StockDataSource stocks_dataSource = StockDataSource();

  @override
  Widget build(BuildContext context) {
    return StockListSharedPage(

    );
  }
}
