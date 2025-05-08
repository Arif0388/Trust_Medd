import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SliderController extends GetxController{
  final db = FirebaseFirestore.instance;
  RxList<Map<String,dynamic>> allSlides  =<Map<String,dynamic>>[].obs;
  RxInt Value = 0.obs;
  RxBool isFavourite = false.obs;
@override
  void onInit(){
    super.onInit();
    allSlide();
}

  Future<void> allSlide()async{
  var snapshot = await db.collection('Slides').get();
   for(var allData in snapshot.docs){
     allSlides.add(allData.data());
     print('All Dat :${allData.data()}');
    }
  }



}