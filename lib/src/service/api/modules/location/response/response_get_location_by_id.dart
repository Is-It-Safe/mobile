import 'response_review.dart';

class LocationByID {
  int? id;
  String? name;
  String? endereco;
  String? type;
  String? imgUrl;
  String? averageGrade;
  List<Reviews>? reviews;

  LocationByID(
      {this.id,
      this.name,
      this.endereco,
      this.type,
      this.imgUrl,
      this.averageGrade,
      this.reviews});

  LocationByID.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endereco = json['endereco'];
    type = json['type'];
    imgUrl = json['imgUrl'];
    averageGrade = json['averageGrade'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['endereco'] = this.endereco;
    data['type'] = this.type;
    data['imgUrl'] = this.imgUrl;
    data['averageGrade'] = this.averageGrade;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

