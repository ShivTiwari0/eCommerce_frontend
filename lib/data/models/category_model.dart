class CategoryModel {
  String? sId;
  String? title;
  String? description;
  String? createdOn;
  String? updatedOn;

  CategoryModel(
      {this.sId, this.title, this.description, this.createdOn, this.updatedOn});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
