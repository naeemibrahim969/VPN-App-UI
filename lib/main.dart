import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vpn_ui/pages/home_page.dart';

import 'constants/colors.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static bool launch = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: launch? FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (_,timer) => timer.connectionState == ConnectionState.done
            ? const HomePage()
            : appSplashScreen(context),
      ): const HomePage(),
    );
  }
}


Widget appSplashScreen(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    height: size.height,
    width: size.width,
    color: AppColors.primary,
    child: const Center(
      child: Icon(Icons.vpn_key_outlined,size: 200,color: Colors.white,),
    ),
  );
}