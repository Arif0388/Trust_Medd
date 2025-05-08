import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppointmentPage extends StatelessWidget {
  const MyAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        title:Text('My Appointments',style:Theme.of(context).textTheme.headlineMedium),
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:Column(
            children: [
              const SizedBox(height:20),
              Row(
                children: [
                  Text('Upcoming',style:Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                    stream:db.collection('Appointments').doc(user!.uid).collection('appointments').snapshots(),
                    builder:(context, snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const CupertinoActivityIndicator();
                      }
                      if(snapshot.hasError){
                        return Text('Error :${snapshot.hasError}');
                      }
                      if(snapshot.data !=null){
                        return ListView.builder(
                          itemCount:snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data!.docs[index];
                            return  Card(
                              elevation:2,
                              child: Container(
                                padding:const EdgeInsets.all(8),
                                width:Get.width,
                                height:140,
                                color:Colors.white,
                                child:Column(
                                  children: [
                                    ListTile(
                                      leading:CircleAvatar(maxRadius:25,backgroundImage:CachedNetworkImageProvider(data['image'])),
                                      title:Text(data['doctorName'],style:Theme.of(context).textTheme.bodyMedium),
                                      // subtitle:Text(data['specialization']),
                                      trailing:Container(
                                          width:67,
                                          height:20,
                                          decoration:BoxDecoration(
                                            borderRadius:BorderRadius.circular(5),
                                            color:data['status']==true?Colors.greenAccent:Colors.cyanAccent,
                                          ),
                                          child:data['status']==true? Center(child: Text('Confirmed',style:Theme.of(context).textTheme.bodySmall)): Center(child: Text('Waiting',style:Theme.of(context).textTheme.bodySmall))
                                      ),
                                    ),
                                    const SizedBox(height:10),
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data['appointmentDate']),
                                        Text(data['appointmentTime'])
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
