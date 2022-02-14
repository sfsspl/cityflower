import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';

class PromotionDataModel extends PromotionEntity {
  int id;
  int isSpecialPromotion;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String imageUrl;
  Image image;

  PromotionDataModel(
      {int id,
      String name,
      String message,
      this.isSpecialPromotion,
      String liveFrom,
      String liveUpto,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.imageUrl,
      this.image})
      : super(
            name: name,
            message: message,
            imageUrl: imageUrl,
            liveFrom: liveFrom,
            liveUpto: liveUpto);

  factory PromotionDataModel.fromJson(Map<String, dynamic> json) {
    return PromotionDataModel(
      id: json['id'],
      name: json['name'],
      message: json['message'],
      isSpecialPromotion: json['is_special_promotion'],
      liveFrom: json['live_from'],
      liveUpto: json['live_upto'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      imageUrl: json['image_url'],
      image: json['image'] != null ? new Image.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['message'] = this.message;
    data['is_special_promotion'] = this.isSpecialPromotion;
    data['live_from'] = this.liveFrom;
    data['live_upto'] = this.liveUpto;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['image_url'] = this.imageUrl;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    return data;
  }
}

class Image {
  int id;
  String filename;
  String path;
  int sizeInBytes;
  String modelType;
  int modelId;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String url;

  Image(
      {this.id,
      this.filename,
      this.path,
      this.sizeInBytes,
      this.modelType,
      this.modelId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.url});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filename = json['filename'];
    path = json['path'];
    sizeInBytes = json['size_in_bytes'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? "";
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    data['path'] = this.path;
    data['size_in_bytes'] = this.sizeInBytes;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['url'] = this.url;
    return data;
  }
}
