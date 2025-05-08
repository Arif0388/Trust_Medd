import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';

import '../AuthPage/signup_page.dart';
import '../Controller/auth_controller.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  AuthController authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(),
                    const SizedBox(height:50),
                    Expanded(
                        flex:1,
                        child:Column(children: [
                          Text('Reset Password',style:Theme.of(context).textTheme.bodyLarge),
                          Text('Enter your existing email to reset password',style:Theme.of(context).textTheme.bodySmall),
                        ],)
                    ),
                    Expanded(
                      flex:6,
                      child:Column(
                        children: [
                          Container(
                              width:290,
                              height:46,
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                              ),
                              child:Obx(() =>
                                  TextFormField(
                                    onChanged:(value){
                                      if(value.isEmpty){
                                        authController.isEmailCorrect.value = false;
                                      }else{
                                        if(value.endsWith('@gmail.com')){
                                          authController.isEmailCorrect.value = true;
                                        }else{
                                          authController.isEmailCorrect.value = false;
                                        }
                                      }
                                    },
                                    controller:emailController,
                                    style:Theme.of(context).textTheme.labelLarge,
                                    keyboardType:TextInputType.emailAddress,
                                    decoration:InputDecoration(
                                        labelStyle:Theme.of(context).textTheme.labelLarge,
                                        prefixIcon:const Icon(Icons.email,color:Colors.blueGrey,size:20),
                                        suffixIcon:authController.isEmailCorrect.value?const Icon(Icons.check_circle,color:Colors.greenAccent,size:20) : const Icon(Icons.check_circle,color:Colors.redAccent,size:20) ,
                                        labelText:'Email Address',
                                        border:OutlineInputBorder(
                                          borderRadius:BorderRadius.circular(5),
                                        )
                                    ),
                                  ))
                          ),
                          const SizedBox(height:40),
                         Obx(() =>
                             OutlinedButton(
                                 style:OutlinedButton.styleFrom(
                                   elevation:10,
                                   foregroundColor:Colors.greenAccent,
                                 ),
                                 autofocus:true,
                                 onPressed: (){
                                   if(emailController.text.isNotEmpty){
                                     authController.forgetPassword(emailController.text.trim());
                                   }else{
                                     print('Please fill all field');
                                  }
                                 }, child:authController.isLoading.value? const CupertinoActivityIndicator()  :const Text('Reset Password')
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
                                    , onPressed:(){}
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
                                    , onPressed:(){}
                                ),
                              ),
                            ],),
                          const SizedBox(height:20),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              Text('Dont You have an account?',style:Theme.of(context).textTheme.labelLarge),
                              InkWell(
                                  onTap:()=>Get.to(const SignupPage()),
                                  child: Text(' Sign up',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.blueAccent))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
