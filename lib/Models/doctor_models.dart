// doctor_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableSlot {
  String? date;
  List<String>? times;

  AvailableSlot({this.date, this.times});

  factory AvailableSlot.fromMap(Map<String, dynamic> map) {
    return AvailableSlot(
      date: map['date'],
      times: List<String>.from(map['times']),
    );
  }
}

class DoctorModel {
  String? id;
  String? name;
  String? specialization;
  String? experience;
  String? fees;
  String? rating;
  String? about;
  String? image;
  bool? favourite;
  List<AvailableSlot>? availableSlots;
  DateTime? createdAt;

  DoctorModel({
    this.id,
    this.name,
    this.specialization,
    this.experience,
    this.fees,
    this.rating,
    this.about,
    this.image,
    this.availableSlots,
    this.createdAt,
    this.favourite
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map, String docId) {
    return DoctorModel(
      id: docId,
      name: map['name'],
      specialization: map['specialization'],
      experience: map['experience'].toString(),
      fees: map['fees'].toString(),
      rating: map['rating'].toString(),
      about: map['about'],
      image: map['photoUrl'],
      favourite: map['favourite'],
      availableSlots: (map['availableSlots'] as List<dynamic>?)
          ?.map((e) => AvailableSlot.fromMap(e as Map<String, dynamic>))
          .toList() ??
          [],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
