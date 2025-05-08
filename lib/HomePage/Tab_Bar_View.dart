
import 'package:flutter/material.dart';
import 'package:trust_medd/HomePage/Home_Page.dart';
import 'package:trust_medd/My_Appointment_Page/my_appointment_page.dart';

import '../Category_Page/category_page.dart';
import '../Profile_Page/profile_page.dart';

class Tabbarview extends StatefulWidget {
  const Tabbarview({super.key});

  @override
  State<Tabbarview> createState() => _TabbarviewState();
}

class _TabbarviewState extends State<Tabbarview> {
  int selectedIndex = 0;
  List screenList = [
    HomePage(),
    const MyAppointmentPage(),
    const ProfilePage(),
    const CategoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        backgroundColor: const Color(0xFFE6F2FF),
          fixedColor:Colors.greenAccent,
          unselectedItemColor:Colors.red,
          type:BottomNavigationBarType.fixed,
          items:const [
            BottomNavigationBarItem(icon:Icon(Icons.home,color:Colors.black,),label:'Home',),
            BottomNavigationBarItem(icon:Icon(Icons.health_and_safety_rounded,color:Colors.black,),label:'My Appointment'),
            BottomNavigationBarItem(icon:Icon(Icons.person,color:Colors.black,),label:'Profile'),
            BottomNavigationBarItem(icon:Icon(Icons.category_outlined,color:Colors.black,),label:'category'),
          ],
        currentIndex:selectedIndex,
        onTap:(value){
            setState(() {
              selectedIndex = value;
            });
        },
      ),
      body:screenList.elementAt(selectedIndex),
    );
  }
}