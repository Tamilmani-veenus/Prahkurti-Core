// To parse this JSON data, do
//
//     final getHomeMenuListResponse = getHomeMenuListResponseFromJson(jsonString);

import 'dart:convert';

GetHomeMenuListResponse getHomeMenuListResponseFromJson(String str) => GetHomeMenuListResponse.fromJson(json.decode(str));

String getHomeMenuListResponseToJson(GetHomeMenuListResponse data) => json.encode(data.toJson());

class GetHomeMenuListResponse {
  bool? success;
  String? message;
  List<Result>? result;

  GetHomeMenuListResponse({
    this.success,
    this.message,
    this.result,
  });

  factory GetHomeMenuListResponse.fromJson(Map<String, dynamic> json) => GetHomeMenuListResponse(
    success: json["success"],
    message: json["message"],
    result: json["result"]==null?[]:List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result":result==null?[]: List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? moduleName;
  List<Menu>? menu;

  Result({
    this.moduleName,
    this.menu,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    moduleName: json["moduleName"],
    menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "moduleName": moduleName,
    "menu": menu==null?[]:List<dynamic>.from(menu!.map((x) => x.toJson())),
  };
}

class Menu {
  String? menuName;
  int? menuId;

  Menu({
    this.menuName,
    this.menuId,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menuName: json["menuName"],
    menuId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "menuName": menuName,
    "id": menuId,
  };
}
