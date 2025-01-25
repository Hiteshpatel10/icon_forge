class IconFilterModel {
  IconFilterModel({
      this.message, 
      this.result, 
      this.status,});

  IconFilterModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    status = json['status'];
  }
  String? message;
  List<Result>? result;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}

class Result {
  Result({
      this.key, 
      this.value,});

  Result.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'] != null ? json['value'].cast<String>() : [];
  }
  String? key;
  List<String>? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    return map;
  }

}