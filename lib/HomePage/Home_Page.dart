import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trust_medd/Appointment_Booking_Screen/appointment_booking_screen.dart';
import 'package:trust_medd/Controller/slider_controller.dart';
import 'package:trust_medd/Doctor_Profile_View_Page/doctor_profile_view_page.dart';
import 'package:trust_medd/Doctors_Page/doctors_page.dart';
import 'package:trust_medd/HomePage/widgets/drawer_widget.dart';
import 'package:trust_medd/Models/category_model.dart';
import 'package:trust_medd/Models/doctor_models.dart';
import 'package:trust_medd/My_Appointment_Page/my_appointment_page.dart';
import 'package:trust_medd/Profile_Page/profile_page.dart';

import '../Config/images.dart';
import '../Controller/auth_controller.dart';
import '../Controller/search_controller.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String image = 'https://media-hosting.imagekit.io/ed3b092ef0d4443b/1000373495.png?Expires=1840967558&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=eNCS4MyI06hTnV1qpRmDJp0w8jdGHLCLQlEwG8xoxR1xgg565sQ9YyLBMBElF00GqFerbESEfVJ0fDIM7Hh-LLcBfMRjsWc-BEwNjAJX-oPtPCvU2MunKd77AcgmvQA2VPGAn~KWbBqy6OyhunlWFFshrZRHrdVnEZ8oRK0QaZ5Y1EZDR~NpRKJVDol1LmuQh31UtBbqBLubGnDYAIBtsVbIIHWVV4TLhe0ge2qWIJqGRSD9jeiWfykCx2O~4bq5W25NNhrir6r6Zzdfe9RVp1oeg8wpuP~s15BLl5ay1JkmWzzVcZ8IhbwUPVplBncpbhO~TaR6fa2MP4dg-ZQqGg__';
    AuthController authController = Get.put(AuthController());
    SliderController sliderController = Get.put(SliderController());
    final auth  = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    return Scaffold(
      key:_scaffoldKey,
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          decoration: const BoxDecoration(
            color: Color(0xFFE6F2FF), //
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap:(){
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: const Icon(Icons.menu, size: 28)),
                  const SizedBox(width: 10),
                  Text(
                   auth.currentUser!.displayName!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Text('Patna',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 10),
                  const Icon(Icons.notifications_none),
                  const SizedBox(width: 10),
                    CircleAvatar(
                    backgroundImage:CachedNetworkImageProvider(auth.currentUser!.photoURL==null?image: auth.currentUser!.photoURL! ),
                    radius: 18,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.mic),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        drawer:const drawerWidget(),
      body:Column(
        children: [
          const SizedBox(height:7),
          Obx(() =>
                 CarouselSlider(
                   items:sliderController.allSlides.map((e){
                     switch(e['type']){
                       case 'sale':
                         return Container(
                           margin:const EdgeInsets.all(5),
                           width:Get.width/1.1,
                           height:20,
                           decoration:BoxDecoration(
                             borderRadius:BorderRadius.circular(10),
                             border:const Border(
                               top:BorderSide(
                                   color:Colors.black
                               ),
                               left:BorderSide(
                                   color:Colors.black
                               ),
                               right:BorderSide(
                                   color:Colors.black
                               ),
                               bottom:BorderSide(
                                   color:Colors.black
                               ),
                             ),
                             image:DecorationImage(image:CachedNetworkImageProvider(e['image']),fit:BoxFit.cover),
                           ),
                           child:Column(
                             mainAxisAlignment:MainAxisAlignment.center,
                             children: [
                               Text('${e['offer']}% OFF',style:Theme.of(context).textTheme.headlineLarge?.copyWith(color:Colors.orangeAccent)),
                               Text('ON FIRST APPOINTMENT',style:Theme.of(context).textTheme.headlineMedium),
                               const SizedBox(height:10),
                               Container(
                                 width:120,
                                 height:50,
                                 decoration:BoxDecoration(
                                   borderRadius:BorderRadius.circular(10),
                                   color:Colors.orange,
                                 ),
                                 child:const Center(child: Text('Book Now')),
                               ),
                             ],
                           ),
                         );
                       case 'doctor':
                         return Container(
                           margin:const EdgeInsets.all(5),
                           width:Get.width/1.1,
                           height:20,
                           decoration:BoxDecoration(
                               borderRadius:BorderRadius.circular(10),
                               color:Colors.white,
                               border:const Border(
                                 top:BorderSide(
                                     color:Colors.black
                                 ),
                                 left:BorderSide(
                                     color:Colors.black
                                 ),
                                 right:BorderSide(
                                     color:Colors.black
                                 ),
                                 bottom:BorderSide(
                                     color:Colors.black
                                 ),
                               ),
                             image:DecorationImage(
                               image:CachedNetworkImageProvider(e['image']),
                               fit:BoxFit.cover,
                             ),
                           ),
                           child:Column(
                             mainAxisAlignment:MainAxisAlignment.center,
                             children: [
                               const SizedBox(height:30),
                               SizedBox(
                                 width:160,
                                 child:Column(
                                   children: [
                                     Text('Anjali Kumari',style:Theme.of(context).textTheme.headlineLarge),
                                     Text(
                                       'Dentist',
                                       style: Theme.of(context).textTheme.bodyMedium,
                                       textAlign: TextAlign.center,
                                     ),
                                     const SizedBox(height:10),
                                     Container(
                                       width:120,
                                       height:50,
                                       decoration:BoxDecoration(
                                         borderRadius:BorderRadius.circular(10),
                                         color:Colors.orange,
                                       ),
                                       child:const Center(child: Text('Book Now')),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         );
                       case 'health':
                         return Container(
                           margin:const EdgeInsets.all(5),
                           width:Get.width/1.1,
                           height:20,
                           decoration:BoxDecoration(
                               borderRadius:BorderRadius.circular(10),
                               color:Colors.white,
                               border:const Border(
                                 top:BorderSide(
                                     color:Colors.black
                                 ),
                                 left:BorderSide(
                                     color:Colors.black
                                 ),
                                 right:BorderSide(
                                     color:Colors.black
                                 ),
                                 bottom:BorderSide(
                                     color:Colors.black
                                 ),
                               ),
                             image:DecorationImage(
                               image:CachedNetworkImageProvider(e['image']),
                               fit:BoxFit.cover,
                             ),
                           ),
                           child:Column(
                             crossAxisAlignment:CrossAxisAlignment.start,
                             children: [
                              Container(
                                  margin:const EdgeInsets.only(left:20),
                                  child: Text('Stay\nHydrated\nThis\nSummer',style:Theme.of(context).textTheme.bodyLarge?.copyWith(color:Colors.white))),
                               Container(
                                 margin:const EdgeInsets.only(left:10,top:10),
                                 width:120,
                                 height:50,
                                 decoration:BoxDecoration(
                                   borderRadius:BorderRadius.circular(10),
                                   color:Colors.orange
                                 ),
                                 child:Center(child: Text('DRINK\nWATER',style:Theme.of(context).textTheme.labelLarge?.copyWith(color:Colors.white))),
                               ),
                             ],
                           ),
                         );
                       default:
                         return const Center(child: Text("Unknown type"));
                     }
                   }).toList(),
                   options:CarouselOptions(
                     scrollDirection:Axis.horizontal,
                     autoPlay:false,
                     viewportFraction:10,
                     animateToClosest:true,
                     pageSnapping:true,
                     onPageChanged:(index, reason){
                     sliderController.Value.value = index;
                     },
                   ),
                 )),
          const SizedBox(height:10),
          Obx(() =>  Container(
            padding:const EdgeInsets.all(6),
            width:80,
            height:20,
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(10),
              color:Colors.blue
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
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Row(
                   children: [
                     Text('Category',style:Theme.of(context).textTheme.labelLarge),
                   ],
                 ),
                 FutureBuilder(
                     future:db.collection('Categories').get(),
                     builder:(context, snapshot) {
                       if(snapshot.connectionState==ConnectionState.waiting){
                         return const CupertinoActivityIndicator();
                       }
                       if(snapshot.hasError){
                         return Text('Error :${snapshot.hasError}');
                       }

                       if(snapshot.data !=null){
                         return Padding(
                           padding: const EdgeInsets.all(5),
                           child: SizedBox(
                             height:110,
                             child: ListView.builder(
                                 scrollDirection:Axis.horizontal,
                                 shrinkWrap:true,
                                 physics:const ScrollPhysics(),
                                 itemCount:snapshot.data!.docs.length,
                                 itemBuilder:(context,index){
                                   var data = snapshot.data!.docs[index];
                                   CategoryModel categorymodel = CategoryModel(
                                       categoryId:data['categoryId'],
                                       categoryImage:data['categoryImage'],
                                       categoryName:data['categoryName'],
                                       categorySpecialist:data['categorySpecialist']
                                   );
                                   return InkWell(
                                     onTap:(){
                                       Get.to(DoctorsPage(categoryModel:categorymodel));
                                     },
                                     child: Container(
                                       padding:const EdgeInsets.all(4),
                                       margin:const EdgeInsets.all(5),
                                       width:100,
                                       height:50,
                                       decoration:BoxDecoration(
                                         borderRadius:BorderRadius.circular(10),
                                         color:const Color(0xffb4d8e5),
                                       ),
                                       child:Column(
                                         children: [
                                           Image.network(categorymodel.categoryImage,height:70,),
                                           Text(categorymodel.categoryName,style:Theme.of(context).textTheme.labelLarge)
                                         ],
                                       ),
                                     ),
                                   );
                                 }
                             ),
                           ),
                         );
                       }
                       return Container();
                     },
                 ),
                 Row(
                   children: [
                     Text('Top Doctors',style:Theme.of(context).textTheme.labelLarge),
                   ],
                 ),
                 StreamBuilder(
                     stream:db.collection('Doctors').snapshots(),
                     builder:(context, snapshot) {
                       if(snapshot.connectionState ==ConnectionState.waiting){
                         return const CupertinoActivityIndicator();
                       }

                       if(snapshot.hasError){
                         return Text('Error :${snapshot.hasError}');
                       }

                       if(snapshot.data!=null){
                         return Padding(
                           padding: const EdgeInsets.all(5),
                           child: SizedBox(
                             height:250,
                             child: ListView.builder(
                                 scrollDirection:Axis.horizontal,
                                 shrinkWrap:true,
                                 physics:const ScrollPhysics(),
                                 itemCount:snapshot.data!.docs.length,
                                 itemBuilder:(context,index){
                                   var data = snapshot.data!.docs[index];
                                   // Convert availableSlots to List<AvailableSlot>
                                   List<AvailableSlot> availableSlots = (data['availableSlots'] as List<dynamic>)
                                       .map((slot) => AvailableSlot.fromMap(slot as Map<String, dynamic>))
                                       .toList();
                                   DoctorModel doctors  = DoctorModel(
                                     id:data.id,
                                     name:data['name'],
                                     specialization:data['specialization'],
                                     rating:data['rating'],
                                     fees:data['fees'],
                                     image:data['image'],
                                     about:data['about'],
                                     favourite:data['favourite'],
                                     experience:data['experience'],
                                     availableSlots:availableSlots,
                                   );
                                   return InkWell(
                                     onTap:(){
                                       Get.to(
                                           DoctorProfileViewPage(doctorModel:doctors,),
                                         transition:Transition.zoom
                                       );
                                      },
                                     child: Container(
                                       padding:const EdgeInsets.all(4.2),
                                       margin:const EdgeInsets.all(5),
                                       width:220.6,
                                       decoration:BoxDecoration(
                                         borderRadius:BorderRadius.circular(10),
                                         color:const Color(0xffb4d8e5),
                                       ),
                                       child:Column(
                                         children: [
                                               Stack(
                                                 children: [
                                                   SizedBox(
                                                       width:208,
                                                       height:130,
                                                       child: ClipRRect(
                                                           borderRadius:BorderRadius.circular(10),
                                                           child:CachedNetworkImage(imageUrl:doctors.image!,fit:BoxFit.cover)
                                                       )
                                                   ),
                                                   InkWell(
                                                       onTap:()async{
                                                         await db.collection('Doctors').doc(doctors.id).update({
                                                           "favourite":true,
                                                         });
                                                       },
                                                       child:Icon(Icons.favorite,color:doctors.favourite==true?Colors.pink:Colors.black)
                                                   )

                                                 ],
                                           ),
                                           Row(
                                             children: [
                                               AutoSizeText('Name : ',style:Theme.of(context).textTheme.labelLarge),
                                               AutoSizeText(doctors.name!,style:Theme.of(context).textTheme.labelLarge),
                                             ],
                                           ),
                                           Expanded(
                                             child: Row(
                                               children: [
                                                 AutoSizeText('Specialist : ',style:Theme.of(context).textTheme.labelLarge),
                                                 AutoSizeText(doctors.specialization!,style:Theme.of(context).textTheme.labelLarge,overflow:TextOverflow.fade,),
                                               ],
                                             ),
                                           ),
                                           Row(
                                             children: [
                                               Text('Rating : ',style:Theme.of(context).textTheme.labelLarge),
                                               Text('${doctors.rating} ⭐',style:Theme.of(context).textTheme.labelLarge),
                                               const SizedBox(width:10),
                                               Text('Fees : ${doctors.fees}',style:Theme.of(context).textTheme.labelLarge),
                                             ],
                                           ),
                                           InkWell(
                                             onTap:(){
                                               Get.to(AppointmentBookingScreen(doctorModel:doctors));
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
                                         ],
                                       ),
                                     ),
                                   );
                                 }
                             ),
                           ),
                         );
                       }
                       return Container();
                     },
                 ),
               ],
             ),
           ),
         )
        ],
      )
    );
  }
}

