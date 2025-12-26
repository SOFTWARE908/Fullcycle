class CandidateModel {
  CandidateData? data;
  int? status;
  String? message;

  CandidateModel({this.data, this.status, this.message});

  CandidateModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CandidateData.fromJson(json['data']) : null;
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

class CandidateData {
  String? fullNameAr;
  String? fullNameEn;
  String? identity;
  String? email;
  String? mobileNumber;
  int? departmentId;
  int? educationId;
  int? languageId;
  String? dateOfBirth;
  int? cityId;
  int? genderId;
  int? nationalityId;
  int? height;
  int? weight;
  int? tShirtSize;

  CandidateData(
      {this.fullNameAr,
      this.fullNameEn,
      this.identity,
      this.email,
      this.mobileNumber,
      this.departmentId,
      this.educationId,
      this.languageId,
      this.dateOfBirth,
      this.cityId,
      this.genderId,
      this.nationalityId,
      this.height,
      this.weight,
      this.tShirtSize});

  CandidateData.fromJson(Map<String, dynamic> json) {
    fullNameAr = json['fullNameAr'];
    fullNameEn = json['fullNameEn'];
    identity = json['identity'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    departmentId = json['departmentId'];
    educationId = json['educationId'];
    languageId = json['languageId'];
    dateOfBirth = json['dateOfBirth'];
    cityId = json['cityId'];
    genderId = json['genderId'];
    nationalityId = json['nationalityId'];
    height = json['height'];
    weight = json['weight'];
    tShirtSize = json['t_ShirtSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullNameAr'] = fullNameAr;
    data['fullNameEn'] = fullNameEn;
    data['identity'] = identity;
    data['email'] = email;
    data['mobileNumber'] = mobileNumber;
    data['departmentId'] = departmentId;
    data['educationId'] = educationId;
    data['languageId'] = languageId;
    data['dateOfBirth'] = dateOfBirth;
    data['cityId'] = cityId;
    data['genderId'] = genderId;
    data['nationalityId'] = nationalityId;
    data['height'] = height;
    data['weight'] = weight;
    data['t_ShirtSize'] = tShirtSize;
    return data;
  }
}
