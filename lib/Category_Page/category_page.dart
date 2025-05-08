import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Doctors_Page/doctors_page.dart';
import '../Models/category_model.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar:AppBar(
        backgroundColor:const Color(0xffb4d8e5),
        title:Text('Category',style:Theme.of(context).textTheme.headlineMedium),
      ),
      body:Column(
        children: [
          Expanded(
            child: FutureBuilder(
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
                      width:Get.width,
                      child: GridView.builder(
                        shrinkWrap:true,
                         gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
                          scrollDirection:Axis.vertical,
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
                              onTap:()=>Get.to(DoctorsPage(categoryModel:categorymodel)),
                              child: Container(
                                padding:const EdgeInsets.all(15),
                                margin:const EdgeInsets.all(5),
                                width:200,
                                height:50,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  color:const Color(0xffb4d8e5),
                                ),
                                child:Column(
                                  children: [
                                    Image.network(categorymodel.categoryImage,height:70,),
                                    const SizedBox(height:10),
                                    Text(categorymodel.categoryName,style:Theme.of(context).textTheme.labelLarge),
                                    const SizedBox(height:8),
                                    AutoSizeText('Specialist : ${categorymodel.categorySpecialist}',style:Theme.of(context).textTheme.labelLarge,overflow:TextOverflow.clip),
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
          ),
        ],
      ),
    );
  }
}
