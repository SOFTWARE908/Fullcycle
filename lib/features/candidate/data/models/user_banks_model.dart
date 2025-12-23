import 'package:equatable/equatable.dart';

class UserBanksModel {
  List<BankInfoModel>? data;
  int? status;
  String? message;

  UserBanksModel({this.data, this.status, this.message});

  UserBanksModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BankInfoModel>[];
      json['data'].forEach((v) {
        data!.add(BankInfoModel.fromJson(v));
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

class BankInfoModel extends Equatable {
  int? value;
  String? text;

  BankInfoModel({this.value, this.text});

  BankInfoModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [value, text];
}
