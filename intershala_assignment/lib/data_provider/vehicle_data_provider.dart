
import 'dart:convert';

import 'package:intershala_assignment/model/vehicle_info.dart';
import 'package:http/http.dart'  as http;

class VehicleDataProvider {
 // ignore: non_constant_identifier_names
 final String _base_url = "http://10.5.225.118:5000/api/VehicleInfo";

  Future<List<Vehicle>> getVehicleInformation() async {
    try {
       final response  =  await http.get(Uri.parse(_base_url),
     
      headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
        },);
            print("-_+P+_P+_+)");
        if(response.statusCode == 200){
          final extractedData = json.decode(response.body) as List;
          print("the value is ${extractedData.map((e) => Vehicle.fromJson(e)).toList()}");
          return extractedData.map((e) => Vehicle.fromJson(e)).toList();
        } else{
          // ignore: avoid_print
          print(response.body);
        throw Exception('Failed to Load Vehicle Data');
        }
      
    } catch (e) {
      // ignore: avoid_print
      print("Exception thrown $e");
      throw Exception(e);
      
    }
   


  }
}