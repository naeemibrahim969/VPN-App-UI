import 'dart:convert';
import 'package:http/http.dart';
import '../models/ip_details.dart';

class APIs{

  static Future<Object> getIPDetails() async {
    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      return IPDetails.fromJson(data);
    } catch (e) {
      return e.toString();
    }
  }


  Future<IPDetails> getIPDetail() async {
    var ipDetails = IPDetails.fromJson({});
    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      ipDetails = IPDetails.fromJson(data);
    } catch (e) {
      print(e.toString());
    }

    return ipDetails;
  }
}