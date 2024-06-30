import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Controllers.dart';
import '../../Controllers/SiteController.dart';
import 'enums/enums.dart';
import '../injection_contianer.dart';

const _host = "http://localhost:5000/";
//const _host = "http://18.233.224.72/api/";

var t = File("host.txt").readAsStringSync();
final serverHost = "${_host}api";
final signalRHost = "${_host}notificationhub";
Website _site = Website.CIA;
Map<String, String> headers() => <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
      "Authorization": "Bearer ${siteController.getToken()}",
      "Site": siteController.getSite()!.index!.toString(),
    };

Website getSite() => _site;
setSite(Website site) => _site = site;

/***********************************
 * Controllers
 ***********************************/

/*****************
 * Authentication
 *****************/
const authenticationController = "Authentication";
const patientInfoController = "PatientInfo";
const notificationController = "Notifications";
const medicalController = "Medical";
const userController = "User";
const settingsController = "Settings";
const stockController = "Stock";
const imageController = "Image";
const cashFlowController = "CashFlow";
const labRequestsController = "LAB_Requests";
const labCustomerController = "Lab_Customers";
const clinicTreatmentController = "ClinicTreatments";
