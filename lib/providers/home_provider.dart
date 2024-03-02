import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/colors.dart';
import '../models/vpn.dart';


final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) => HomeProvider());

class HomeProvider with ChangeNotifier{

  String _currentStatus = "disconnected";
  String get currentStatus => _currentStatus;


  String _downloadSpeed = "542";
  String get downloadSpeed => _downloadSpeed;


  String _uploadSpeed = "213";
  String get uploadSpeed => _uploadSpeed;

  VPN _selectedVPN = VPN(hostname: "Host", ip: "12", ping: "22", speed: 132, countryLong: "Pakistan", countryShort: "pk");
  VPN get selectedVPN => _selectedVPN;


  set currentStatus(String value){
    _currentStatus = value;
    notifyListeners();
  }

  set selectedVPN(VPN value) {
    _selectedVPN = value;
    notifyListeners();
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bp/s', "Kbp/s", "Mbp/s", "Gbp/s", "Tbp/s"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  // vpn buttons color
  Color get getButtonColor {
    switch (_currentStatus) {
      case "disconnected":
        return AppColors.blue;

      case "connected":
        return AppColors.offGreen;

      default:
        return AppColors.orange;
    }
  }

  String get getButtonText {
    switch (_currentStatus) {
      case 'disconnected':
        return 'Tap to Connect';

      case 'connected':
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}