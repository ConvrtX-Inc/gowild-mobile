import 'dart:convert';

Routes routeFromJson(String str) => Routes.fromJson(json.decode(str));

String routeToJson(Routes data) => json.encode(data.toJson());

class RouteList {
  RouteList({this.routeList = const []});

  final List<Routes> routeList;

  factory RouteList.fromJson(List<dynamic> json) {
    return RouteList(routeList: json.map((e) => Routes.fromJson(e)).toList());
  }
}

class Routes {
  Routes({
    this.userId,
    this.routeName,
    this.routePhoto,
    this.startPointLong,
    this.startPointLat,
    this.stopPointLong,
    this.stopPointLat,
    this.imgUrl,
    this.description,
    this.id =''
  });

  String id;
  String? userId;
  String? routeName;
  String? routePhoto;
  double? startPointLong;
  double? startPointLat;
  double? stopPointLong;
  double? stopPointLat;
  String? imgUrl;
  String? description;

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
        id: json["id"],
        userId: json["user_id"],
        routeName: json["route_name"],
        routePhoto: json["route_photo"],
        startPointLong: double.tryParse(json["start_point_long"]),
        startPointLat: double.tryParse(json["start_point_lat"]),
        stopPointLong: double.tryParse(json["stop_point_long"]),
        stopPointLat: double.tryParse(json["stop_point_lat"]),
        imgUrl: json["img_url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id" : id,
        "user_id": userId,
        "route_name": routeName,
        "route_photo": routePhoto,
        "start_point_long": startPointLong,
        "start_point_lat": startPointLat,
        "stop_point_long": stopPointLong,
        "stop_point_lat": stopPointLat,
        "img_url": imgUrl,
        "description": description,
      };
}
