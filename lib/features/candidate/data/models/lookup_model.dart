import 'lookup_item.dart';

class LookupModel {
  LookUpData? lookUpData;

  int? status;
  String? message;

  LookupModel({this.lookUpData, this.status, this.message});

  LookupModel.fromJson(Map<String, dynamic> json) {
    lookUpData =
        json['data'] != null ? LookUpData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lookUpData != null) {
      data['data'] = lookUpData!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class LookUpData {
  List<LookUpItem>? cities;
  List<LookUpItem>? nationalities;
  List<LookUpItem>? departments;
  List<LookUpItem>? tshirtSizes;
  List<LookUpItem>? educationLevels;
  List<LookUpItem>? languages;
  List<LookUpItem>? genders;

  LookUpData(
      {this.cities,
      this.nationalities,
      this.departments,
      this.tshirtSizes,
      this.educationLevels,
      this.languages,
      this.genders});

  LookUpData.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <LookUpItem>[];
      json['cities'].forEach((v) {
        cities!.add(LookUpItem.fromJson(v));
      });
    }
    if (json['nationalities'] != null) {
      nationalities = <LookUpItem>[];
      json['nationalities'].forEach((v) {
        nationalities!.add(LookUpItem.fromJson(v));
      });
    }
    if (json['departments'] != null) {
      departments = <LookUpItem>[];
      json['departments'].forEach((v) {
        departments!.add(LookUpItem.fromJson(v));
      });
    }
    if (json['tshirtSizes'] != null) {
      tshirtSizes = <LookUpItem>[];
      json['tshirtSizes'].forEach((v) {
        tshirtSizes!.add(LookUpItem.fromJson(v));
      });
    }
    if (json['educationLevels'] != null) {
      educationLevels = <LookUpItem>[];
      json['educationLevels'].forEach((v) {
        educationLevels!.add(LookUpItem.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <LookUpItem>[];
      json['languages'].forEach((v) {
        languages!.add(LookUpItem.fromJson(v));
      });
    }
    if (json['genders'] != null) {
      genders = <LookUpItem>[];
      json['genders'].forEach((v) {
        genders!.add(LookUpItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    if (nationalities != null) {
      data['nationalities'] = nationalities!.map((v) => v.toJson()).toList();
    }
    if (departments != null) {
      data['departments'] = departments!.map((v) => v.toJson()).toList();
    }
    if (tshirtSizes != null) {
      data['tshirtSizes'] = tshirtSizes!.map((v) => v.toJson()).toList();
    }
    if (educationLevels != null) {
      data['educationLevels'] =
          educationLevels!.map((v) => v.toJson()).toList();
    }
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    if (genders != null) {
      data['genders'] = genders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
