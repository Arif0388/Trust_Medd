import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trust_medd/Models/doctor_models.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key,required this.doctorModel});
 final DoctorModel? doctorModel;
  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {

  DateTime dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  final auth  = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                maxRadius:90,
                backgroundImage:CachedNetworkImageProvider(widget.doctorModel!.image!),
              ),
              const SizedBox(height:10),
              Text(widget.doctorModel!.name!,style:Theme.of(context).textTheme.bodyLarge),
              Text(widget.doctorModel!.specialization!,style:Theme.of(context).textTheme.labelLarge),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:[
                  Text('${widget.doctorModel!.rating}⭐',style:Theme.of(context).textTheme.labelLarge),
                  Text('${widget.doctorModel!.experience} years Experience',style:Theme.of(context).textTheme.labelLarge)
                ],
              ),
              const SizedBox(height:40),
              Row(
                children: [
                  Text('Select Date',style:Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height:10,),
              InkWell(
                onTap:()async{
                  var date = await showDatePicker(
                      context: context,
                      firstDate:DateTime(2000),
                      lastDate:DateTime(2026),
                  );
                   if(date !=null){
                     setState(() {
                      dateTime = date;
                    });
                   }else{
                     print('Null date');
                  }
                },
                child: Card(
                  elevation:5,
                  child: Container(
                    padding:const EdgeInsets.all(10),
                    width:Get.width/3,
                    height:Get.height/8.5,
                    color:Colors.white12,
                    child:Image.asset('assets/Images/calender.png'),
                  ),
                ),
              ),
              Text('Date: ${DateFormat('yyyy-MM-dd').format(dateTime)}'),
              const SizedBox(height:20),
              Row(
                children: [
                  Text('Select Time',style:Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height:20),
              InkWell(
                onTap:()async{
                  var time = await showTimePicker(
                      context: context,
                      initialTime:TimeOfDay.now(),
                  );
                 setState(() {
                   timeOfDay = time!;
                 });
                },
                child: Card(
                  elevation:5,
                  child: Container(
                    width:Get.width/3,
                    height:Get.height/8.5,
                    decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color:Colors.white
                    ),
                    child:Image.asset('assets/Images/time.png',fit:BoxFit.fitHeight,)
                    ),
                  ),
              ),
               Text('Time : ${formatTime(timeOfDay)}'),
              const SizedBox(height:40),
              InkWell(
                onTap:()async{
                 try{
                   EasyLoading.show();
                   await FirebaseFirestore.instance.collection('Appointments').doc(auth!.uid).collection('appointments').doc().set({
                     'appointmentDate':DateFormat('yyyy-MM-dd').format(dateTime),
                     'appointmentTime':formatTime(timeOfDay),
                     'createdAt':FieldValue.serverTimestamp(),
                     'doctorId':widget.doctorModel!.id,
                     'doctorName':widget.doctorModel!.name,
                     'userId':auth!.uid,
                     'image':widget.doctorModel!.image,
                     'status':false
                   });
                   EasyLoading.dismiss();
                   Fluttertoast.showToast(
                     msg: "Appointment Successful",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.CENTER,
                     backgroundColor: Colors.black87,
                     textColor: Colors.white,
                     fontSize: 16.0,
                   );
                 }catch(e){
                   Fluttertoast.showToast(
                     msg: "$e",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.CENTER,
                     backgroundColor: Colors.black87,
                     textColor: Colors.white,
                     fontSize: 16.0,
                   );
                   EasyLoading.dismiss();
                 }
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
                    child:const Center(child: Text('Confirm')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 String formatTime(TimeOfDay time) {
   final now  = DateTime.now();
   final formattedTime = DateTime(now.year,now.month,now.day,time.hour,time.minute);
  return DateFormat('hh:mm a').format(formattedTime);
  }

}
