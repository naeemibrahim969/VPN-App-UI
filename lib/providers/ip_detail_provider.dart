import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_ui/apis/apis.dart';
import 'package:vpn_ui/models/ip_details.dart';

@immutable
abstract class IpDataState{}
class IPDataInitialState extends IpDataState{}
class IPDataLoadingState extends IpDataState{}

class IPDataLoadedState extends IpDataState{
  IPDataLoadedState({
    required this.ipDetails
  });
  final IPDetails ipDetails;
}

class IPDataErrorState extends IpDataState{
  IPDataErrorState({
    required this.message
  });
  final String message;
}

final ipDetailProvider = StateNotifierProvider.autoDispose<IpDetailNotifier,IpDataState>((ref) => IpDetailNotifier());

class IpDetailNotifier extends StateNotifier<IpDataState> {

  IpDetailNotifier() : super(IPDataInitialState());
  final APIs _apis = APIs();

  fetchDetails() async {
    try {
      state = IPDataLoadingState();
      final data = await _apis.getIPDetail();
      state = IPDataLoadedState(ipDetails: data);
    } catch (e) {
      state = IPDataErrorState(message: e.toString());
    }
  }
}
