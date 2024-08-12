class ProductModel {
  String? sId;
  String? category;
  String? title;
  String? description;
  int? prices;
  List<String>? images;
  String? createdOn;
  String? updatedOn;

  ProductModel(
      {this.sId,
      this.category,
      this.title,
      this.description,
      this.prices,
      this.images,
      this.createdOn,
      this.updatedOn});
 
  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    prices = json['prices'];
    images = json['Images'].cast<String>();
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['description'] = this.description;
    data['prices'] = this.prices;
    data['Images'] = this.images;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
