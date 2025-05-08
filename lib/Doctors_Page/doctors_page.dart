import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust_medd/Appointment_Booking_Screen/appointment_booking_screen.dart';
import 'package:trust_medd/Models/category_model.dart';
import 'package:trust_medd/Models/doctor_models.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key, required this.categoryModel});
final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar:AppBar(
        title:Text('${categoryModel.categorySpecialist} Doctors',style:Theme.of(context).textTheme.bodyLarge),
      ),
      body:Padding(padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(),
            Expanded(
              child: StreamBuilder(
                  stream:db.collection('Doctors').where('specialization',isEqualTo:categoryModel.categorySpecialist).snapshots(),
                  builder:(context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const CupertinoActivityIndicator();
                    }
                    if(snapshot.hasError){
                      return Text('Error :${snapshot.hasError}');
                    }
                    if(snapshot.data !=null){
                      return ListView.builder(
                        itemCount:snapshot.data!.docs.length,
                        itemBuilder:(context, index) {
                          var data = snapshot.data!.docs[index];
                          DoctorModel doctormodel = DoctorModel(
                            name:data['name'],
                            image:data['image'],
                            rating:data['rating'],
                            fees:data['fees'],
                            specialization:data['specialization'],
                            experience:data['experience']
                          );
                          return Card(
                            elevation:2.5,
                            child: Container(
                              width:Get.width,
                              height:150,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  color:Colors.white
                              ),
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width:130,
                                    height:130,
                                    decoration:BoxDecoration(
                                      borderRadius:BorderRadius.circular(10),
                                      border:const Border(
                                        top:BorderSide(
                                          color:Colors.greenAccent,
                                          width:2
                                        ),
                                        left:BorderSide(
                                            color:Colors.greenAccent,
                                          width:2
                                        ),
                                        right:BorderSide(
                                            color:Colors.greenAccent,
                                          width:2
                                        ),
                                        bottom:BorderSide(
                                            color:Colors.greenAccent,
                                          width:2
                                        ),
                                      ),
                                    ),
                                    child:CachedNetworkImage(fit:BoxFit.cover,imageUrl:doctormodel.image!),
                                  ),
                                  const SizedBox(width:10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:10),
                                      child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                                          children: [
                                             AutoSizeText('Name : ${doctormodel.name}',),
                                             AutoSizeText('Specialist : ${doctormodel.specialization}',overflow:TextOverflow.ellipsis,),
                                             AutoSizeText('Rating : ${doctormodel.rating}⭐'),
                                             Row(
                                               children: [
                                                 Text('Fees : ${doctormodel.fees} ₹'),
                                                 const SizedBox(width:20),
                                                 Text('Exp : ${doctormodel.experience} years'),
                                               ],
                                             ),
                                            InkWell(
                                              onTap:(){
                                                Get.to(AppointmentBookingScreen(doctorModel:doctormodel));
                                            },
                                              child: Card(
                                                elevation:2,
                                                child: Container(
                                                  width:100,
                                                  height:30,
                                                  decoration:BoxDecoration(borderRadius:BorderRadius.circular(8),
                                                    color: Colors.greenAccent,
                                                  ),
                                                  child:Center(child:Text('Book Now',style:Theme.of(context).textTheme.labelMedium)),
                                                ),
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    else{
                      return Container();
                    }
                  },
              ),
            )
          ],
        ),
      ),
    );
  }
}
