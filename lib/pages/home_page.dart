import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_ui/pages/server_listing_page.dart';
import 'package:vpn_ui/providers/home_provider.dart';
import '../constants/colors.dart';
import '../main.dart';
import '../widgets/count_down_timer.dart';
import 'ip_detail_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    if (MyApp.launch) {
      MyApp.launch = false;
    }
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar:buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 1),
            statusTimeWidget(),
            const SizedBox(height: 1),
            const SizedBox(height: 1),
            connectionButton(context),
            const SizedBox(height: 1),
            const SizedBox(height: 1),
            currentSpeedStatus(),
            const SizedBox(height: 1),
            GestureDetector(child: currentIPLocation(),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ServersPage()));
            },),
            const SizedBox(height: 1),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      // leading: const Icon(Icons.info_outline,color: Colors.white70,),
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
        GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const IpDetailsPage()));
            },
            child: Icon(Icons.info_outline,color: Colors.white70)
        ),
        const SizedBox(width:10),
        const SizedBox(width:10),
        const SizedBox(width:10),
      ],
    );
  }

  Widget currentSpeedStatus() {
    return Consumer(
      builder: (context,ref,child){
        var data = ref.watch(homeProvider);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_downward,color: Colors.lightBlue,),
            const SizedBox(width:5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Download',style: TextStyle(color: Colors.lightBlue),),
                Text("${data.downloadSpeed} kbps",style: TextStyle(fontSize:10,color: AppColors.offWhite),),
              ],
            ),
            const SizedBox(width:10),
            Container(height: 40,width: 2,color: AppColors.divider,),
            const SizedBox(width:5),
            const Icon(Icons.arrow_upward,color: AppColors.yellow,),
            const SizedBox(width:5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upload',style: TextStyle(color: AppColors.yellow),),
                Text("${data.uploadSpeed} kbps",style: TextStyle(fontSize:10,color: AppColors.offWhite),),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget statusTimeWidget() {

     return Consumer(
         builder: (context,ref,child){
           var data = ref.watch(homeProvider);
           return Column(
             children: [
               Text(data.currentStatus,style: TextStyle(color:AppColors.offWhite,fontSize: 20)),
               const CountDownTimer(startTimer: true),
             ],
           );
         }
     );

  }

  Widget currentIPLocation() {
    return Consumer(
        builder: (context,ref,child){
          var data = ref.watch(homeProvider);
          return Material(
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
                        backgroundImage: NetworkImage('https://flagpedia.net/data/flags/w1160/${data.selectedVPN.countryShort}.webp'),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.selectedVPN.countryLong,style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.offWhite),),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              const Text('Ping',style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                              const SizedBox(width: 10,),
                              const Text(':',style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                              const SizedBox(width: 10,),
                              Text("${data.selectedVPN.ping} ms",style: const TextStyle(color: AppColors.offWhite,fontSize: 10),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              const Text('Speed',style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                              const SizedBox(width: 10,),
                              const Text(':',style: TextStyle(color: AppColors.offWhite,fontSize: 10),),
                              const SizedBox(width: 10,),
                              Text('${data.selectedVPN.speed} Mbp/s',style: const TextStyle(color: AppColors.offWhite,fontSize: 10),),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,color: AppColors.offWhite,size: 20,)
                ],
              ),
            ),
          );
        }
    );
  }

  Widget connectionButton(BuildContext context) {
    return Consumer(
            builder: (context,ref,child){
              var data = ref.watch(homeProvider);
              return AvatarGlow(
                 glowColor: data.getButtonColor,
                 glowShape: BoxShape.circle,
                 animate: true,
                 curve: Curves.fastOutSlowIn,
                 child: MaterialButton(
                   onPressed: (){
                     // homeProvider.connectToVpn();
                   },
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
                   height: 160,
                   minWidth: 160,
                   color: data.getButtonColor,
                   child: Column(
                     children: [
                       const Icon(Icons.power_settings_new,color: AppColors.offWhite,size: 60),
                       Text(data.getButtonText,style: const TextStyle(color: AppColors.offWhite),)
                     ],
                   ),
                 ),
              );
        }
    );
  }
}
