import 'package:cariro_implant_academy/API/CashFlowAPI.dart';
import 'package:cariro_implant_academy/Helpers/CIA_DateConverters.dart';
import 'package:cariro_implant_academy/Models/DTOs/DropDownDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'API_Response.dart';

class CashFlowItemSummaryModel {
  DropDownDTO? category;
  int? total;

  CashFlowItemSummaryModel.fromJson(Map<String, dynamic> json) {
    category = DropDownDTO.fromJson((json['category'] ?? Map<String, dynamic>()));
    total = json['total'];
  }

  CashFlowItemSummaryModel({this.category, this.total});
}

class CashFlowSummaryModel {
  String? from;
  String? to;
  DropDownDTO? category;
  List<CashFlowItemSummaryModel>? income;
  List<CashFlowItemSummaryModel>? expenses;

  CashFlowSummaryModel.fromJson(Map<String, dynamic> json) {
    from = CIA_DateConverters.fromBackendToDateOnly(json['from']);
    to = CIA_DateConverters.fromBackendToDateOnly(json['to']);
    category = DropDownDTO.fromJson((json['category'] ?? Map<String, dynamic>()) as Map<String, dynamic>);
    income = ((json['income'] ?? []) as List<dynamic>).map((e) => CashFlowItemSummaryModel.fromJson(e as Map<String, dynamic>)).toList();
    expenses = ((json['expenses'] ?? []) as List<dynamic>).map((e) => CashFlowItemSummaryModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}

enum CashFlowType { income, expenses }
