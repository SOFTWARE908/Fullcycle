class UserBankDataModel {
  int? bankId;
  String? bankName;
  String? iBan;
  String? delegateId;
  String? delegateName;

  UserBankDataModel(
      {this.bankId,
      this.bankName,
      this.iBan,
      this.delegateId,
      this.delegateName});

  UserBankDataModel.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    bankName = json['bankName'];
    iBan = json['iBan'];
    delegateId = json['delegateId'];
    delegateName = json['delegateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankId'] = bankId;
    data['bankName'] = bankName;
    data['iBan'] = iBan;
    data['delegateId'] = delegateId;
    data['delegateName'] = delegateName;
    return data;
  }
}
