class EventModel {
  int? id;
  String? guid;
  String? eventName;
  String? eventStartDate;
  String? eventEndDate;
  String? startTime;
  String? endTime;
  dynamic latitude;
  dynamic longitude;

  String? eventImageUrl;
  bool? isEnrolled;
  bool? canEnrolled;
  String? description;
  String? cityName;
  List<String>? departments;

  EventModel(
      {this.id,
      this.guid,
      this.eventName,
      this.eventStartDate,
      this.eventEndDate,
      this.startTime,
      this.endTime,
      this.latitude,
      this.longitude,
      this.eventImageUrl,
      this.isEnrolled,
      this.canEnrolled,
      this.description,
      this.cityName,
      this.departments});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    eventImageUrl = json['eventImageUrl'];
    isEnrolled = json['isEnrolled'];
    canEnrolled = json['canEnrolled'];

    eventName = json['eventName'];
    eventStartDate = json['eventStartDate'];
    eventEndDate = json['eventEndDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    cityName = json['cityName'];
    if (json['departments'] != null) {
      if (json['departments'] is List) {
        departments = (json['departments'] as List)
            .map((e) => e is String ? e : e.toString())
            .toList();
      } else if (json['departments'] is String) {
        departments = [json['departments']];
      } else {
        departments = [];
      }
    } else {
      departments = [];
    }
  }
}
