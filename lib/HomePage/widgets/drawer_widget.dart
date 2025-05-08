import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trust_medd/All_Doctors/all_doctors.dart';
import '../../My_Appointment_Page/my_appointment_page.dart';
import '../../Profile_Page/profile_page.dart';

class drawerWidget extends StatelessWidget {
  const drawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String image = 'https://media-hosting.imagekit.io/ed3b092ef0d4443b/1000373495.png?Expires=1840967558&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=eNCS4MyI06hTnV1qpRmDJp0w8jdGHLCLQlEwG8xoxR1xgg565sQ9YyLBMBElF00GqFerbESEfVJ0fDIM7Hh-LLcBfMRjsWc-BEwNjAJX-oPtPCvU2MunKd77AcgmvQA2VPGAn~KWbBqy6OyhunlWFFshrZRHrdVnEZ8oRK0QaZ5Y1EZDR~NpRKJVDol1LmuQh31UtBbqBLubGnDYAIBtsVbIIHWVV4TLhe0ge2qWIJqGRSD9jeiWfykCx2O~4bq5W25NNhrir6r6Zzdfe9RVp1oeg8wpuP~s15BLl5ay1JkmWzzVcZ8IhbwUPVplBncpbhO~TaR6fa2MP4dg-ZQqGg__';
    final auth = FirebaseAuth.instance;
    return Column(
      children:[
        Container(
          height:Get.height/1.08,
          width:320,
          decoration:const BoxDecoration(
            borderRadius:BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10)),
            color:Color(0xffb4d8e5),
          ),
          child:Column(
            children: [
              DrawerHeader(
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage:CachedNetworkImageProvider(auth.currentUser!.photoURL==null?image:auth.currentUser!.photoURL!),
                            radius:50,
                          ),
                          Text(auth.currentUser!.displayName!,style:Theme.of(context).textTheme.labelLarge),
                          const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent),
                        ],
                      ),
                    ],
                  )
              ),
              ListTile(
                onTap:()=>Get.to(const MyAppointmentPage()),
                leading:const Icon(Icons.send_to_mobile_rounded,color:Colors.blue,),
                title:Text('My Appointments',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent),
              ),
              ListTile(
                onTap:()=>Get.to(const AllDoctors()),
                leading:const Icon(Icons.health_and_safety_rounded,color:Colors.orange),
                title:Text('Doctors',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent),
              ),
              ListTile(
                leading:const Icon(Icons.star,color:Colors.yellow),
                title:Text('Specialties',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent,),
              ),
              ListTile(
                leading:const Icon(Icons.account_balance_wallet_sharp,color:Colors.greenAccent),
                title:Text('My Prescriptions',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent),
              ),
              ListTile(
                leading:const Icon(Icons.notifications,color:Colors.yellow),
                title:Text('Notifications',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent,),
              ),
              ListTile(
                onTap:()=>Get.to(const ProfilePage()),
                leading:const Icon(Icons.person,color:Colors.teal),
                title:Text('My Profile',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent),
              ),
              ListTile(
                leading:const Icon(Icons.settings,color:Colors.red),
                title:Text('Settings',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent),
              ),
              ListTile(
                leading:const Icon(Icons.help_center_outlined,color:Colors.grey),
                title:Text('Help & Support',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent),
              ),
              ListTile(
                onTap:(){
                  auth.signOut();
                  GoogleSignIn googleSignin = GoogleSignIn();
                  googleSignin.signOut();
                },
                leading:const Icon(Icons.logout,color:Colors.redAccent),
                title:Text('Log Out',style:Theme.of(context).textTheme.labelLarge),
                trailing:const Icon(Icons.arrow_forward_sharp,color:Colors.deepOrangeAccent,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
