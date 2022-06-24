class HistoricalEventModel {
  String? id;
  String? routeId;
  String? closureUid;
  double? eventLong;
  double? eventLat;
  String? eventTitle;
  String? eventSubtitle;
  String? description;
  String? createdDate;
  String? updatedDate;

  HistoricalEventModel(
      {this.id,
      this.routeId,
      this.closureUid,
      this.eventLong,
      this.eventLat,
      this.eventTitle,
      this.eventSubtitle,
      this.description,
      this.createdDate,
      this.updatedDate});

  HistoricalEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['route_id'];
    closureUid = json['closure_uid'];
    eventLong = double.parse(json['event_long']);
    eventLat = double.parse(json['event_lat']);
    eventTitle = json['event_title'];
    eventSubtitle = json['event_subtitle'];
    description = json['description'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['route_id'] = routeId;
    data['closure_uid'] = closureUid;
    data['event_long'] = eventLong;
    data['event_lat'] = eventLat;
    data['event_title'] = eventTitle;
    data['event_subtitle'] = eventSubtitle;
    data['description'] = description;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    return data;
  }
}
