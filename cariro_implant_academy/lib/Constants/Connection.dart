
import 'package:flutter/foundation.dart';
import 'dart:io';

__host(){
  try{
  print( File("host.txt").readAsStringSync());
  return File("host.txt").readAsStringSync();
  }
  catch(e){

  }
  //return "http://54.224.105.207/api/";
  //return "http://localhost:5000/";
  if(kReleaseMode)
   return "http://54.224.105.207/api/";
  else
    return "http://localhost:5000/";
}

//final _host = "http://54.224.105.207/api/";
//final _host = "http://localhost:5000/";
//final _host = "http://localhost:5170/";
final _host ="http://192.168.94.180/api/";
//final _host =__host();
final serverHost = "${_host}api";
final signalRHost = "${_host}notificationhub";