import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:trust_medd/AuthPage/signup_page.dart';

import '../Controller/auth_controller.dart';
import '../Forget_Password_Page/forget_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                          Text('Login Existing Account',style:Theme.of(context).textTheme.bodyLarge),
                          Text('Enter your existing details to login account',style:Theme.of(context).textTheme.bodySmall),
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
                          Container(
                              width:290,
                              height:46,
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                              ),
                              child: Obx(() =>
                                  TextFormField(
                                    controller:passwordController,
                                    style:Theme.of(context).textTheme.labelLarge,
                                    keyboardType:TextInputType.visiblePassword,
                                    obscureText:authController.isVisible.value,
                                    decoration:InputDecoration(
                                        labelStyle:Theme.of(context).textTheme.labelLarge,
                                        prefixIcon:const Icon(Icons.lock,color:Colors.blueGrey,size:20),
                                        suffixIcon: authController.isVisible.value?InkWell(
                                            onTap:(){
                                              authController.isVisible.value = false;
                                            },
                                            child: const Icon(Icons.visibility_off,color:Colors.blueGrey,size:20))
                                            : InkWell(
                                            onTap:(){
                                              authController.isVisible.value = true;
                                            },
                                            child: const Icon(Icons.remove_red_eye_outlined,color:Colors.blueGrey,size:20)) ,
                                        labelText:'Password',
                                        border:OutlineInputBorder(
                                          borderRadius:BorderRadius.circular(5),
                                        )
                                    ),
                                  )
                              )
                          ),
                          const SizedBox(height:10),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap:()=>Get.to(const ForgetPasswordPage()),
                                  child: Text('Forget Password',style:Theme.of(context).textTheme.bodyMedium)),
                            ],
                          ),
                          const SizedBox(height:35),
                       Obx(() =>
                           OutlinedButton(
                               style:OutlinedButton.styleFrom(
                                 elevation:10,
                                 foregroundColor:Colors.greenAccent,
                               ),
                               autofocus:true,
                               onPressed: (){
                                 if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                                   authController.login(emailController.text.trim(), passwordController.text.trim());
                                 }else{
                                   Fluttertoast.showToast(
                                     msg: "Please Fill All Field",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     backgroundColor: Colors.black87,
                                     textColor: Colors.white,
                                     fontSize: 16.0,
                                   );
                                 }
                               }, child:authController.isLoading.value? const CupertinoActivityIndicator()  :const Text('Login')
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
                                    , onPressed:(){
                                     authController.signInWithGoogle();
                                     }
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
