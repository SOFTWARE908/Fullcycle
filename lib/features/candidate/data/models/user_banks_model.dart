import 'lookup_item.dart';

class UserBanksModel {
  List<LookUpItem>? data;
  int? status;
  String? message;

  UserBanksModel({this.data, this.status, this.message});

  UserBanksModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LookUpItem>[];
      json['data'].forEach((v) {
        data!.add(LookUpItem.fromJson(v));
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
