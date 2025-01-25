class IconsModel {
  IconsModel({
      this.message, 
      this.result, 
      this.status,});

  IconsModel.fromJson(dynamic json) {
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
      this.id, 
      this.name, 
      this.category, 
      this.style, 
      this.path, 
      this.tags, 
      this.format, 
      this.source, 
      this.createdAt, 
      this.updatedAt,});

  Result.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    style = json['style'];
    path = json['path'];
    tags = json['tags'];
    format = json['format'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? name;
  String? category;
  String? style;
  String? path;
  String? tags;
  String? format;
  String? source;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['style'] = style;
    map['path'] = path;
    map['tags'] = tags;
    map['format'] = format;
    map['source'] = source;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}