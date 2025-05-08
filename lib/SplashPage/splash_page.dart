import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust_medd/HomePage/Tab_Bar_View.dart';

import '../AuthPage/welcome_page.dart';
import '../Config/images.dart';
import '../HomePage/Home_Page.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    Future.delayed(const Duration(seconds:3),(){
      if(auth.currentUser!=null){
        Get.offAll(const Tabbarview());
      }else{
        Get.offAll(const WelcomePage());
      }
    });

    return Scaffold(
      backgroundColor:const Color(0xffb4d8e5),
      body:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Container(),
          CircleAvatar(
            radius:50,
            backgroundColor:Colors.black26,
            backgroundImage:AssetImage(ImageAssets.appLogo,),
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Text('Trust',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.pinkAccent)),
              const SizedBox(width:10),
              Text('Med',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.cyan)),
            ],
          ),
        ],
      ),
    );
  }
}
