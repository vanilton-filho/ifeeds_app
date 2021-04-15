import 'package:cloud_firestore/cloud_firestore.dart';

class FormRating {
  String? campus;
  String? description;
  String? rating;
  num? stars;
  String? user;
  DateTime? creationDate;
  DateTime? updateDate;
  String? response;
  DocumentReference? reference;

  FormRating({this.campus, this.description, this.rating, this.stars, this.user, this.creationDate, this.updateDate, this.response, this.reference});

  FormRating.fromJson(Map<String, dynamic> json,  {required DocumentReference reference}) {
    campus = json['campus'];
    description = json['description'];
    rating = json['rating'];
    stars = json['stars'];
    user = json['user'];
    creationDate = DateTime.parse((json["creationDate"] as Timestamp).toDate().toString());
    updateDate = json["updateDate"] == null ? null : DateTime.parse((json["updateDate"] as Timestamp).toDate().toString());
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campus'] = this.campus;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['stars'] = this.stars;
    data['user'] = this.user;
    return data;
  }

  FormRating.fromSnapshot(DocumentSnapshot? snapshot)
      : this.fromJson(snapshot!.data()!, reference: snapshot.reference);
}