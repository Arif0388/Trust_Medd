
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trust_medd/AuthPage/signup_page.dart';
import 'package:trust_medd/Controller/slider_controller.dart';

import '../Config/images.dart';
import '../Controller/auth_controller.dart';
import '../HomePage/Home_Page.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    SliderController sliderController = Get.put(SliderController());
    return Column(
      children: [
        Expanded(
            child:PageView(
              children: [
                Container(
                  width:Get.width,
                  color:Colors.blueAccent,
                  child:Stack(
                    children: [
                      SizedBox(
                        width:Get.width,
                        height:Get.height,
                        child:Image.asset(ImageAssets.slide1,fit:BoxFit.cover,),
                      ),
                      Positioned(
                          bottom:2,
                          left:10,
                          child: OutlinedButton(
                              onPressed:()=>Get.offAll(HomePage()),
                              child:const Text('Skip',style:TextStyle(color:Colors.black))
                          )),
                    ],
                  ),
                ),
                Container(
                  width:Get.width,
                  color:Colors.blueAccent,
                  child: SizedBox(
                        width:Get.width,
                        height:Get.height,
                        child:Image.asset(ImageAssets.slide4,fit:BoxFit.cover,),
                      ),
                ),
                Container(
                  width:Get.width,
                  color:Colors.blueAccent,
                  child: SizedBox(
                    width:Get.width,
                    height:Get.height,
                    child:Image.asset(ImageAssets.slide3,fit:BoxFit.cover,),
                  ),
                ),
              ],
              onPageChanged:(value) {
                sliderController.Value.value = value;
              },
            )
        ),
        const SizedBox(height:5),
        Obx(() =>  Container(
          padding:const EdgeInsets.all(3),
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(10),
            color:Colors.cyan,
          ),
          child: SmoothPageIndicator(
            controller:PageController(
              initialPage:sliderController.Value.value,
            ),
            count:3,
            effect:const WormEffect(
              type:WormType.underground,
              activeDotColor:Colors.greenAccent,
              dotColor:Colors.white54,
              dotHeight:8,
              paintStyle:PaintingStyle.stroke,
            ),
          ),
        ),),
        Expanded(
          child:Container(
            width:Get.width,
            color:Colors.white,
            child:Column(
              children: [
                const SizedBox(height:15),
                Text('    Doctors at \n your Doorstep',style:Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height:20),
                Material(
                  child: InkWell(
                    onTap:()=>Get.to(const SignupPage()),
                    child: Container(
                      width:Get.width/1.2,
                      height:65,
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00C6FB), Color(0xFF005BEA)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child:Center(child: Text('Sign Up',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.white))),
                    ),
                  ),
                ),
                const SizedBox(height:20),
                SizedBox(
              width:Get.width/1.2,
              height:65,
              child: OutlinedButton(
                onPressed:()=>Get.to(const LoginPage()),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF00C6FB), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                ), child:Text('Login',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color:const Color(0xFF00C6FB),)),
              ),
            ),
                const SizedBox(height:20),
                Text('Login with a social account',style:Theme.of(context).textTheme.labelLarge),
                const SizedBox(height:20),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width:120,
                      child: SignInButton(
                          shape:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(10)
                          ),
                          text:'Facebook',
                          Buttons.Facebook
                          , onPressed:(){

                             }
                      ),
                    ),
                    SizedBox(
                      width:120,
                      child: SignInButton(
                          shape:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(10)
                          ),
                          text:'Google',
                          Buttons.Google
                          , onPressed:(){
                                   authController.signInWithGoogle();
                                }
                      ),
                    ),
                  ],),
                const SizedBox(height:20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
