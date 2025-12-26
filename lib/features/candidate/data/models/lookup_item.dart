import 'package:equatable/equatable.dart';

class LookUpItem extends Equatable {
  int? value;
  String? text;

  LookUpItem({this.value, this.text});

  LookUpItem.fromJson(Map<String, dynamic> json) {
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
  List<Object?> get props => [value, text];
}
