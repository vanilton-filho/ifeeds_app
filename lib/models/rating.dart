import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  String? title;
  num? ratingAverage;
  String? img;
  int? category;
  DocumentReference? reference;

  Rating(
      {this.title,
      this.ratingAverage,
      this.img,
      this.category,
      this.reference});

  Rating.fromJson(Map<String, dynamic> json,
      {required DocumentReference reference}) {
    title = json['title'];
    ratingAverage = json['ratingAverage'];
    img = json['img'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['ratingAverage'] = this.ratingAverage;
    data['img'] = this.img;
    data['category'] = this.category;
    return data;
  }

  Rating.fromSnapshot(DocumentSnapshot? snapshot)
      : this.fromJson(snapshot!.data()!, reference: snapshot.reference);
}
