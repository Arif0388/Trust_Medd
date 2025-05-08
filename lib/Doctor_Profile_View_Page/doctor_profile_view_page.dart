
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust_medd/Appointment_Booking_Screen/appointment_booking_screen.dart';
import 'package:trust_medd/Models/doctor_models.dart';

class DoctorProfileViewPage extends StatelessWidget {
  const DoctorProfileViewPage({super.key, required this.doctorModel});
final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        body:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              InkWell(
                onTap:()=>Get.back(),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_circle_left_outlined,size:30,color:Colors.grey,),
                  ],
                ),
              ),
              Container(),
               CircleAvatar(
                 backgroundColor:Colors.black,
                maxRadius:90,
                backgroundImage:CachedNetworkImageProvider(doctorModel.image!),
              ),
              const SizedBox(height:10),
              Text(doctorModel.name!,style:Theme.of(context).textTheme.bodyLarge),
              Text(doctorModel.specialization!,style:Theme.of(context).textTheme.labelLarge),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:[
                  Text('${doctorModel.rating!}⭐',style:Theme.of(context).textTheme.labelLarge),
                  Text('${doctorModel.experience} years Experience',style:Theme.of(context).textTheme.labelLarge)
                ],
              ),
              const SizedBox(height:40),
              Row(
                children: [
                  Text('About',style:Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height:10,),
              Card(
                elevation:2,
                child: Container(
                  padding:const EdgeInsets.all(10),
                  width:Get.width,
                  height:Get.height/8,
                  color:Colors.white12,
                  child:Text(doctorModel.about!,maxLines:3,style:Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              const SizedBox(height:20),
              Row(
                children: [
                  Text('Available Time',style:Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height:20),
              Expanded(
                child: ListView.builder(
                  scrollDirection:Axis.horizontal,
                  shrinkWrap:true,
                    itemCount:doctorModel.availableSlots!.length,
                    itemBuilder:(context, index) {
                    var slot = doctorModel.availableSlots![index];
                      return Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children:slot.times!.map((time){
                          return    Card(
                            elevation:2,
                            child: Container(
                              width:80,
                              height:40,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  color:Colors.white
                              ),
                              child:Center(child: Text(time,style:Theme.of(context).textTheme.labelMedium)),
                            ),
                          );
                        }).toList(),
                      );
                    },
                ),
              ),
              const SizedBox(height:10),
              Row(
                children: [
                  Text('Available Date',style:Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height:20),
              Expanded(
                child: ListView.builder(
                  scrollDirection:Axis.horizontal,
                  shrinkWrap:true,
                  itemCount:doctorModel.availableSlots!.length,
                  itemBuilder:(context, index) {
                    var slot = doctorModel.availableSlots![index];
                    return Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation:2,
                          child: Container(
                            width:80,
                            height:40,
                            decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                                color:Colors.white
                            ),
                            child:Center(child: Text(slot.date!,style:Theme.of(context).textTheme.labelMedium)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height:40),
              InkWell(
                onTap:(){
                  Get.to(AppointmentBookingScreen(doctorModel:doctorModel),
                  transition:Transition.zoom
                  );
                },
                child: Card(
                  elevation:10,
                  child: Container(
                    width:Get.width/1.3,
                    height:50,
                   decoration:BoxDecoration(
                     borderRadius:BorderRadius.circular(10),
                     color:Colors.tealAccent,
                   ),
                    child:const Center(child: Text('Book Appointment')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
