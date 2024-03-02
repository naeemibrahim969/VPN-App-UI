import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/colors.dart';
import '../models/server_data.dart';
import '../providers/ip_detail_provider.dart';
import '../widgets/server_detail_card.dart';

class IpDetailsPage extends ConsumerWidget {
  const IpDetailsPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    Future.delayed(const Duration(seconds: 2), () => ref.read(ipDetailProvider.notifier).fetchDetails());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text('Server Details',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.offWhite)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),color: Colors.white70,
        ),
        shadowColor : Colors.white,
        backgroundColor: AppColors.primary,
      ),
      body:Consumer(
        builder: (context,ref,child){

          IpDataState state = ref.watch(ipDetailProvider);

          if(state is IPDataInitialState){
            return const Center(child: Text('Fetching Data... 🧐',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)));
          }

          if(state is IPDataLoadingState){
            return loading();
          }

          if(state is IPDataLoadedState){
            return buildListView(state,size);
          }

          if(state is IPDataErrorState){
            return const Center(child: Text('Fetching Data... 🧐',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)));
          }

          return const Center(child: Text('Fetching Data... 🧐',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)));
        } ,
      ),
      // body:buildListView(size),
    );
  }


  Widget loading(){
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitSpinningLines(
          color: Colors.green,
          size: 100.0,
        ),
        SizedBox(height: 40),
        Text('Loading VPNs... 🧐',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
      ],
    );
  }

  ListView buildListView(IPDataLoadedState state,Size size,) {
    return ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            left: size.width * .04,
            right: size.width * .04,
            top: size.height * .01,
            bottom: size.height * .1),
        children: [
          //ip
          ServerDetailCard(
              data: ServerData(
                  title: 'IP Address',
                  subtitle: state.ipDetails.query,
                  icon: Icon(CupertinoIcons.location_solid,
                      color: Colors.blue))),

          //isp
          ServerDetailCard(
              data: ServerData(
                  title: 'Internet Provider',
                  subtitle: state.ipDetails.isp,
                  icon: Icon(Icons.business, color: Colors.orange))),

          //location
          ServerDetailCard(
              data: ServerData(
                  title: 'Location',
                  subtitle: state.ipDetails.country.isEmpty
                      ? 'Fetching ...'
                      : '${state.ipDetails.city}, ${state.ipDetails.regionName}, ${state.ipDetails.country}',
                  icon: Icon(CupertinoIcons.location, color: Colors.pink))),

          //pin code
          ServerDetailCard(
              data: ServerData(
                  title: 'Pin-code',
                  subtitle: state.ipDetails.zip,
                  icon: Icon(CupertinoIcons.location_solid,
                      color: Colors.cyan))),

          //timezone
          ServerDetailCard(
              data: ServerData(
                  title: 'Timezone',
                  subtitle: state.ipDetails.timezone,
                  icon: Icon(CupertinoIcons.time, color: Colors.green))),
        ]);
  }
}
