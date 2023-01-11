// To parse this JSON data, do
//
//     final errorLoginModel = errorLoginModelFromJson(jsonString);

import 'dart:convert';

ErrorLoginModel errorLoginModelFromJson(String str) => ErrorLoginModel.fromJson(json.decode(str));

String errorLoginModelToJson(ErrorLoginModel data) => json.encode(data.toJson());

class ErrorLoginModel {
    ErrorLoginModel({
        this.detail,
    });

    String detail;

    factory ErrorLoginModel.fromJson(Map<String, dynamic> json) => ErrorLoginModel(
        detail: json["detail"],
    );

    Map<String, dynamic> toJson() => {
        "detail": detail,
    };
}
