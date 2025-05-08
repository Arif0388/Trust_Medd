class CategoryModel {
  final String categoryId;
  final String categoryImage;
  final String categoryName;
  final String categorySpecialist;

  // Constructor
  CategoryModel({
    required this.categoryId,
    required this.categoryImage,
    required this.categoryName,
    required this.categorySpecialist,
  });

  factory CategoryModel.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return CategoryModel(
      categoryId: firestoreDoc['categoryId'] ?? '',
      categoryImage: firestoreDoc['categoryImage'] ?? '',
      categoryName: firestoreDoc['categoryName'] ?? '',
      categorySpecialist: firestoreDoc['categorySpecialist'] ?? '',
    );
  }

  // Method to convert Category object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImage': categoryImage,
      'categoryName': categoryName,
      'categorySpecialist': categorySpecialist,
    };
  }
}
