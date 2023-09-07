import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';

  Future<void> addFakeDataToFirebase(numProducts) async {
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Faker faker = Faker();

// Generate fake data
    for (int i = 0; i < numProducts; i++) {
final Map<String, dynamic> fakeData = {
  "id": faker.guid.guid(),
  "name": faker.food.dish(),
  "image": faker.image.image(),

};

try {
// Add the fake data to Firebase
await firestore.collection('catagories').add(fakeData);
print('Fake data added to Firebase successfully!');
} catch (e) {
print('Error adding fake data to Firebase: $e');
}}
}

