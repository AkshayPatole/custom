// To parse this JSON data, do
//
//     final getAllPostsModel = getAllPostsModelFromJson(jsonString);

import 'dart:convert';

List<GetAllPostsModel> getAllPostsModelFromJson(String str) => List<GetAllPostsModel>.from(json.decode(str).map((x) => GetAllPostsModel.fromJson(x)));

String getAllPostsModelToJson(List<GetAllPostsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllPostsModel {
    final int userId;
    final int id;
    final String title;
    final String body;

    GetAllPostsModel({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    factory GetAllPostsModel.fromJson(Map<String, dynamic> json) => GetAllPostsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
