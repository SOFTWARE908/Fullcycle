class ZoneModel {
  int? value;
  String? text;

  ZoneModel({this.value, this.text});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZoneModel &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  ZoneModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
