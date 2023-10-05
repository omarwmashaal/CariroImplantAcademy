
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Controllers.dart';
import '../../Controllers/SiteController.dart';
import '../../Models/Enum.dart';
import '../injection_contianer.dart';

const _host ="http://localhost:5170/";
//const _host = "http://54.166.50.255/api/";
final serverHost = "${_host}api";
final signalRHost = "${_host}notificationhub";
Website _site = Website.CIA;
Map<String, String> headers() => <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
      "Authorization": "Bearer ${siteController.getToken()}",
      "Site": sl<SharedPreferences>().getInt("Website").toString(),
    };



Website getSite() => _site;
setSite(Website site) => _site=site;


/***********************************
 * Controllers
 ***********************************/

/*****************
 * Authentication
 *****************/
const authenticationController = "Authentication";
const patientInfoController= "PatientInfo";
const notificationController= "Notifications";
const medicalController= "Medical";
const userController= "User";
const settingsController= "Settings";
const stockController= "Stock";
const imageController= "Image";
const cashFlowController= "CashFlow";