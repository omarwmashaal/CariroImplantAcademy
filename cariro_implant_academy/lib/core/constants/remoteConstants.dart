
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Colors.dart';
import '../../Models/Enum.dart';

const _host ="http://localhost:5170/";
//const _host = "http://54.166.50.255/api/";
final serverHost = "${_host}api";
final signalRHost = "${_host}notificationhub";
Website _site = Website.CIA;
Future<Map<String, String>> headers() async => <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
      "Authorization": "Bearer ${await getToken()}",
      "Site": await getSite().index.toString(),
    };

Future<String> getToken() async{
  var pref = await  SharedPreferences.getInstance();
  return Future.value(pref.getString("token")??"");
}

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