import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate{
final db = FirebaseFirestore.instance;
  List<String> a = [
    'arif','hussain','leyakat','shahid','aizaz','raja'
  ];
  List<String> recentSearch = [
    'arif','hussain','leyakat','shahid','aizaz','raja'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
     IconButton(onPressed:(){
       query = '';
     }, icon:const Icon(Icons.close))
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed:(){}, icon:const Icon(Icons.arrow_back_sharp));
  }

  @override
  Widget buildResults(BuildContext context) {
     if(query !=null){
       return StreamBuilder(
           stream:db.collection('Doctors').where('specialization',isEqualTo:query).snapshots(),
           builder:(context, snapshot) {
             if(snapshot.connectionState==ConnectionState.waiting){
               return const Center(
                 child:CupertinoActivityIndicator(),
               );
             }
             if(snapshot.data !=null){
               return ListView.builder(
                 itemCount:snapshot.data!.docs.length,
                 itemBuilder:(context, index) {
                   var data = snapshot.data!.docs[index];
                   return Center(child: Text(data['name']));
                 },
               );
             }
             return Container();
           },
       );
     }
     else if(query==''){
       return const Text('');
     }
     else{
       return const Text('No Data found');
     }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount:recentSearch.length,
        itemBuilder:(context, index) {
          return Text(recentSearch[index]);
        },
    );
  }

}