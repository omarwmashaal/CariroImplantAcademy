import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/StockModel.dart';
import '../SharedPages/StocksSharedPage.dart';

class Clinic_StockPage extends StatefulWidget {
  const Clinic_StockPage({Key? key}) : super(key: key);

  @override
  State<Clinic_StockPage> createState() => _Clinic_StockPageState();
}

class _Clinic_StockPageState extends State<Clinic_StockPage> {

  @override
  Widget build(BuildContext context) {
    return StockListSharedPage(

    );
  }
}
