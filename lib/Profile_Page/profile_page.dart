import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trust_medd/AuthPage/welcome_page.dart';
import 'package:trust_medd/HomePage/Home_Page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    String image = 'https://media-hosting.imagekit.io/ed3b092ef0d4443b/1000373495.png?Expires=1840967558&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=eNCS4MyI06hTnV1qpRmDJp0w8jdGHLCLQlEwG8xoxR1xgg565sQ9YyLBMBElF00GqFerbESEfVJ0fDIM7Hh-LLcBfMRjsWc-BEwNjAJX-oPtPCvU2MunKd77AcgmvQA2VPGAn~KWbBqy6OyhunlWFFshrZRHrdVnEZ8oRK0QaZ5Y1EZDR~NpRKJVDol1LmuQh31UtBbqBLubGnDYAIBtsVbIIHWVV4TLhe0ge2qWIJqGRSD9jeiWfykCx2O~4bq5W25NNhrir6r6Zzdfe9RVp1oeg8wpuP~s15BLl5ay1JkmWzzVcZ8IhbwUPVplBncpbhO~TaR6fa2MP4dg-ZQqGg__';
    final auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children:[
            isEdit? Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap:()=>Get.back(),
                    child: const Icon(Icons.arrow_back)),
                Text('Edit Profile',style:Theme.of(context).textTheme.headlineSmall),
                InkWell(
                    onTap:(){
                     setState(() {
                       isEdit = false;
                     });
                    },
                    child: const Icon(Icons.check_circle)),
              ],
            ):
             Row(
               mainAxisAlignment:MainAxisAlignment.spaceBetween,
               children: [
                 InkWell(
                     onTap:()=>Get.back(),
                     child: const Icon(Icons.arrow_back)),
                 InkWell(
                     onTap:(){
                       setState(() {
                         isEdit = true;
                       });
                     },
                     child: const Icon(Icons.settings)),
               ],
             ),
              const SizedBox(height:10),
              isEdit? CircleAvatar(
                backgroundImage:CachedNetworkImageProvider(auth.currentUser!.photoURL==null?image:auth.currentUser!.photoURL!
                ),
                radius:60,
                child:const CircleAvatar(
                  radius:25,
                  child:Icon(Icons.add,color:Colors.white,),
                ),
              ) :
              CircleAvatar(
                 radius:60,
                 backgroundImage:CachedNetworkImageProvider(auth.currentUser!.photoURL==null?image:auth.currentUser!.photoURL!),
               ),
              isEdit? Text(''):Container(
               child:Column(
                 children: [
                   Text(auth.currentUser!.displayName!),
                   Text(auth.currentUser!.email!),
                 ],
               ),
             ),
              const SizedBox(height:20),
              isEdit? Container(
              child:Column(
                children: [
                  Row(
                    children: [
                      Text('Your Information',style:Theme.of(context).textTheme.labelLarge),
                    ],
                  ),
                  const SizedBox(height:10),
                  SizedBox(
                    width:Get.width/1.2,
                    height:Get.height/16,
                    child:TextFormField(
                      decoration:InputDecoration(
                        label:Text('Name',style:Theme.of(context).textTheme.labelLarge),
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(10),
                        ),
                        labelStyle:Theme.of(context).textTheme.labelSmall,
                        prefixIcon:const Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height:20),
                  SizedBox(
                    width:Get.width/1.2,
                    height:Get.height/16,
                    child:TextFormField(
                      decoration:InputDecoration(
                        label:Text('Available Timing',style:Theme.of(context).textTheme.labelLarge),
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(10),
                        ),
                        labelStyle:Theme.of(context).textTheme.labelSmall,
                        prefixIcon:const Icon(Icons.access_time_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height:20),
                  SizedBox(
                    width:Get.width/1.2,
                    height:Get.height/16,
                    child:TextFormField(
                      decoration:InputDecoration(
                        label:Text('Specialization',style:Theme.of(context).textTheme.labelLarge),
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(10),
                        ),
                        labelStyle:Theme.of(context).textTheme.labelSmall,
                        prefixIcon:const Icon(Icons.folder_special_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height:20),
                  SizedBox(
                    width:Get.width/1.2,
                    height:Get.height/16,
                    child:TextFormField(
                      decoration:InputDecoration(
                        label:Text('Blood Group',style:Theme.of(context).textTheme.labelLarge),
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(10),
                        ),
                        labelStyle:Theme.of(context).textTheme.labelSmall,
                        prefixIcon:const Icon(Icons.bloodtype),
                      ),
                    ),
                  ),
                  const SizedBox(height:20),
                  ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        padding:const EdgeInsets.only(left:30,right:30),
                        elevation:10
                      ),
                      onPressed:(){},
                      child:const Text('Save')
                  ),
                ],
              ),
            ) :
              Container(
                child:Column(
                  children: [
                    const SizedBox(height:5),
                    Row(
                      children: [
                        const SizedBox(width:10),
                        Text('PERSONAL INFORMATION',style:Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height:5),
                    Card(
                      elevation:2,
                      child: Container(
                        padding:const EdgeInsets.all(6),
                        decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                          color:Colors.white
                        ),
                        width:Get.width/1.1,
                        child:const Column(
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Gender'),
                              Text('Male'),
                            ],
                          ),
                            SizedBox(height:5),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date of Birth'),

                                Text('January 12, 1985'),
                              ],
                            ),
                            SizedBox(height:5),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Blood Group'),
                                Text('A+'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:20),
                    Row(
                      children: [
                        const SizedBox(width:10),
                        Text('MEDICAL HISTORY',style:Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height:5),
                    Card(
                      elevation:2,
                      child: Container(
                        padding:const EdgeInsets.all(6),
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color:Colors.white
                        ),
                        width:Get.width/1.1,
                        child:const Column(
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Diabetes'),
                                // Text('Male'),
                              ],
                            ),
                            SizedBox(height:5),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sugar'),
                                // Text('January 12, 1985'),
                              ],
                            ),
                            SizedBox(height:5),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Cancer'),
                                // Text('A+'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:20),
                    Row(
                      children: [
                        const SizedBox(width:10),
                        Text('HEALTH REPORTS',style:Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height:5),
                    Card(
                      elevation:2,
                      child: Container(
                        padding:const EdgeInsets.all(6),
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color:Colors.white
                        ),
                        width:Get.width/1.1,
                        child:const Column(
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('blood_test_reports.pdf'),
                                Icon(Icons.arrow_forward_outlined)
                                // Text('Male'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:20),
                    Row(
                      children: [
                        const SizedBox(width:10),
                        Text('SAVED DOCTORS',style:Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height:5),
                    Card(
                      elevation:2,
                      child: Container(
                        padding:const EdgeInsets.all(6),
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color:Colors.white
                        ),
                        width:Get.width/1.1,
                        child:const Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Dr.Arif Ansari'),
                                Text('Cardiologist'),
                                // Text('Male'),
                              ],
                            ),
                            Text('Cardiologist'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
