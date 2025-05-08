
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar:AppBar(
      ),
      body:IconButton(
          onPressed:()async{
            var uuid  = const Uuid();
            final id = uuid.v4();
            await db.collection('Slides').doc().set(
              {
                "type": "doctor",
                "name": "Anjali Kumari",
                "specialization": "Dentist",
                "image":"https://media-hosting.imagekit.io/f1859f874a0840df/woman-doctor-wearing-lab-coat-with-stethoscope-isolated.jpg?Expires=1840767043&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=MeB8nxOiggucc5h6aUoEAB38PTKXjEaW94iLd9mo1~gNDAJi-g~Q3D~0W-LTb~ErN6ugoBGZ2mJJVgVnpdZGO56-s-Bfk2IDIo-QwnIo50q60Axep4wRIzCLcc4DK9Ngt1AT9OsuE8IVA~1970PBXBYgHx0mmdfOyCIfhQ343mOkVMtf8~x~jj1kvj62~m3RaZuadZzrrJXRi30XD0t3pnOe5HpU3ZWYzyjXW2HB5JLEcanEh~5GXav4n9y2B4JjMfe9R1mQXYrJuewNqh9zaR5~8sFcIqUALB7tvd0cVqX4UtWiaCQOVMKZXFBySnXBjcPg~DCKBYbUvhK1OaEFhg__"
              },
            );
      }, icon:const Icon(Icons.add)),
    );
  }
}
