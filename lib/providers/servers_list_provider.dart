import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/vpn.dart';

@immutable
abstract class ServerListingState{}

class InitialServerState extends ServerListingState{}

class LoadingServerState extends ServerListingState{}

class LoadedServerState extends ServerListingState{
  LoadedServerState({
    required this.vpns
  });
  final List<VPN> vpns;
}

class ErrorServerState extends ServerListingState{
  ErrorServerState({
    required this.message
  });
  final String message;
}

final serversListProvider = StateNotifierProvider<ServersListNotifier,ServerListingState>((ref) => ServersListNotifier());

class ServersListNotifier extends StateNotifier<ServerListingState>{

  ServersListNotifier(): super(InitialServerState());

  fetchList() async{
    final List<VPN> _serversList = [
      VPN(hostname: "ZONG", ip: "192.180.200.100", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.101", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.102", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.103", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.104", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.105", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.106", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.107", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.108", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.109", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.110", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.111", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.112", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
      VPN(hostname: "ZONG", ip: "192.180.200.113", ping: "90", speed: 41, countryLong: "Pakistan", countryShort: "pk"),
    ];

    try{
      state = LoadingServerState();
      //Api data
      final List<VPN> data = await Future.delayed( const Duration(seconds: 10),
              () => _serversList
      );

      state = LoadedServerState(vpns: data);
    }catch(e){
      state = ErrorServerState(message: e.toString());
    }

  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bp/s', "Kbp/s", "Mbp/s", "Gbp/s", "Tbp/s"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

}