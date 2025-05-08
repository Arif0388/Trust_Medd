import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Controller/auth_controller.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonedController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
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
                          Text('Create New Account',style:Theme.of(context).textTheme.bodyLarge),
                          Text('Enter your details to create account',style:Theme.of(context).textTheme.bodySmall),
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
                              child: TextFormField(
                                controller:nameController,
                                style:Theme.of(context).textTheme.labelLarge,
                                keyboardType:TextInputType.name,
                                decoration:InputDecoration(
                                    labelStyle:Theme.of(context).textTheme.labelLarge,
                                    prefixIcon:const Icon(Icons.person,color:Colors.blueGrey,size:20),
                                    labelText:'Name',
                                    border:OutlineInputBorder(
                                      borderRadius:BorderRadius.circular(5),
                                    )
                                ),
                              )
                          ),
                          const SizedBox(height:40),
                          Container(
                              width:290,
                              height:46,
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller:phonedController,
                                style:Theme.of(context).textTheme.labelLarge,
                                keyboardType:TextInputType.name,
                                decoration:InputDecoration(
                                    labelStyle:Theme.of(context).textTheme.labelLarge,
                                    prefixIcon:const Icon(Icons.phone,color:Colors.blueGrey,size:20),
                                    labelText:'Phone',
                                    border:OutlineInputBorder(
                                      borderRadius:BorderRadius.circular(5),
                                    )
                                ),
                              )
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
                          const SizedBox(height:35),
                         Obx(() =>
                             OutlinedButton(
                                 style:OutlinedButton.styleFrom(
                                   elevation:10,
                                   foregroundColor:Colors.greenAccent,
                                 ),
                                 autofocus:true,
                                 onPressed: () {
                                   if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                                     authController.signup(emailController.text.trim(),passwordController.text.trim(),nameController.text.trim(),phonedController.text.trim());
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
                                 }, child: authController.isLoading.value? const CupertinoActivityIndicator() : const Text('Sign Up')
                             ),),
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
                              Text('Already You have an account?',style:Theme.of(context).textTheme.labelLarge),
                              InkWell(
                                  onTap:()=>Get.to(const LoginPage()),
                                  child: Text(' Sign in',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.blueAccent))),
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
