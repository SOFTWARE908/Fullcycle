class QRCodeModel {
  Data? data;
  int? status;
  String? message;

  QRCodeModel({this.data, this.status, this.message});

  QRCodeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? code;
  int? count;

  Data({this.code, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['count'] = count;
    return data;
  }
}
