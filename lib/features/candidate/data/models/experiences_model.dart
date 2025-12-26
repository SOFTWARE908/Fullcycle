class ExperiencesModel {
  List<ExperienceItem>? data;
  int? status;
  String? message;

  ExperiencesModel({this.data, this.status, this.message});

  ExperiencesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ExperienceItem>[];
      json['data'].forEach((v) {
        data!.add(ExperienceItem.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class ExperienceItem {
  int? id;
  String? description;
  String? companyName;
  String? position;
  int? years;
  int? candidateId;

  ExperienceItem(
      {this.id,
      this.description,
      this.companyName,
      this.position,
      this.years,
      this.candidateId});

  ExperienceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    companyName = json['companyName'];
    position = json['position'];
    years = json['years'];
    candidateId = json['candidateId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['companyName'] = companyName;
    data['position'] = position;
    data['years'] = years;
    data['candidateId'] = candidateId;
    return data;
  }
}
