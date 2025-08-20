import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<MartyerModel> favoriteLsit = <MartyerModel>[].obs;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final db = FirebaseFirestore.instance;

  Future<void> addToFavorite(String id) async {
    await db
        .collection('favorites')
        .doc(uid)
        .collection('stories')
        .doc(id)
        .set({'addedAt': FieldValue.serverTimestamp()});
    await fetchFavorites();
  }

  Future<void> removeFromFavorite(String id) async {
    await db
        .collection('favorites')
        .doc(uid)
        .collection('stories')
        .doc(id)
        .delete();
    favoriteLsit.removeWhere((m) => m.id == id);
  }

  Future<void> fetchFavorites() async {
    final snapshot =
        await db.collection('favorites').doc(uid).collection('stories').get();

    final ids = snapshot.docs.map((doc) => doc.id).toList();

    if (ids.isEmpty) {
      favoriteLsit.clear();
      return;
    }

    final allStories = <MartyerModel>[];

    // تقسيم الـ IDs إلى chunks كل منها فيه 10 كحد أقصى
    final chunks = List.generate(
      (ids.length / 10).ceil(),
      (i) => ids.skip(i * 10).take(10).toList(),
    );

    for (var chunk in chunks) {
      final storiesSnapshot =
          await db.collection('stories').where("id", whereIn: chunk).get();

      final stories = storiesSnapshot.docs
          .map((doc) => MartyerModel.fromJson(doc.data()))
          .toList();

      allStories.addAll(stories);
    }

    favoriteLsit.value = allStories;
  }

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }
}
