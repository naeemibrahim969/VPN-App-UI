import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vpn_ui/providers/home_provider.dart';
import 'package:vpn_ui/providers/servers_list_provider.dart';
import '../constants/colors.dart';

class ServersPage extends StatelessWidget {
  const ServersPage({super.key});

  @override
  Widget build(BuildContext context) {

    // If need in start use ConsumerWidget and get WidgetRef => ref to call method
    // Future.delayed(const Duration(seconds: 2), () => ref.read(serversListProvider.notifier).fetchList());

    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar:AppBar(
          title: const Text("Servers List",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.offWhite)
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),color: Colors.white70,
          ),
          shadowColor : Colors.white,
          backgroundColor: AppColors.primary,
          bottom: PreferredSize(
            preferredSize:const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: Colors.white12,
            ),
          ),
          actions:  [
            Consumer(builder: (context,ref,child){
              return GestureDetector(
                onTap:(){
                    ref.read(serversListProvider.notifier).fetchList();
                  },
                  child:const Icon(Icons.refresh,color: Colors.white70));
            }),
            const SizedBox(width:10),
          ],
        ),
        body: Consumer(
          builder: (context,ref,child){
            ServerListingState state = ref.watch(serversListProvider);

            if(state is InitialServerState){
              return noVPNFound();
            }

            if(state is LoadingServerState){
              return loading();
            }

            if(state is LoadedServerState){
              return buildListView(state,ref);
            }

            if(state is ErrorServerState){
              return noVPNFound();
            }

            return noVPNFound();
          } ,
        )
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

  Widget noVPNFound(){
    return const Center(
        child:Text('No Server Found... 🙁',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))
    );
  }

  ListView buildListView(LoadedServerState state,WidgetRef ref) {
    return ListView.builder(
        itemCount: state.vpns.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: GestureDetector(
              onTap: (){
                ref.read(homeProvider).selectedVPN = state.vpns[index];
                Navigator.of(context).pop();
              },
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white12,width: 2)
                ),
                color: AppColors.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://flagpedia.net/data/flags/w1160/${state.vpns[index].countryShort.toLowerCase()}.webp'),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.vpns[index].countryLong,style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.offWhite),),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Ping",style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                                  SizedBox(width: 10,),
                                  Text(':',style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                                  SizedBox(width: 10,),
                                  Text(state.vpns[index].ping + " ms",style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Speed",style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                                  SizedBox(width: 10,),
                                  Text(':',style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                                  SizedBox(width: 10,),
                                  Text(ref.read(serversListProvider.notifier).formatBytes(state.vpns[index].speed, 1),style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }


}
