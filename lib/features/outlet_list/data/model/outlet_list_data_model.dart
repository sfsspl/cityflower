import 'package:city_flower/features/outlet_list/domain/entity/outlet_list_entity.dart';

class OutletListDataModel extends OutletListEntity {
  String createdAt;
  String updatedAt;
  String deletedAt;
  String details;
  Country country;
  Image image;

  OutletListDataModel(
      {int id,
      String name,
      double lat,
      double lng,
      String streetAddress,
      String city,
      int countryId,
      String postalCode,
      this.details,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      String address,
      String imageUrl,
      this.country,
      this.image})
      : super(
            id: id,
            name: name,
            lat: lat,
            lng: lng,
            streetAddress: streetAddress,
            city: city,
            countryId: countryId,
            postalCode: postalCode,
            address: address,
            imageUrl: imageUrl);

  factory OutletListDataModel.fromJson(Map<String, dynamic> json) {
    return OutletListDataModel(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
      streetAddress: json['street_address'],
      city: json['city'],
      countryId: json['country_id'],
      postalCode: json['postal_code'],
      details: json['details'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      address: json['address'],
      imageUrl: json['image_url'],
      country: json['country'] != null
          ? new Country.fromJson(json['country'])
          : null,
      image: json['image'] != null ? new Image.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['street_address'] = this.streetAddress;
    data['city'] = this.city;
    data['country_id'] = this.countryId;
    data['postal_code'] = this.postalCode;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['address'] = this.address;
    data['image_url'] = this.imageUrl;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    return data;
  }
}

class Country {
  int id;
  String iso;
  String name;
  String nicename;
  String iso3;
  String numcode;
  String phonecode;
  String deletedAt;

  Country(
      {this.id,
      this.iso,
      this.name,
      this.nicename,
      this.iso3,
      this.numcode,
      this.phonecode,
      this.deletedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    phonecode = json['phonecode'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso'] = this.iso;
    data['name'] = this.name;
    data['nicename'] = this.nicename;
    data['iso3'] = this.iso3;
    data['numcode'] = this.numcode;
    data['phonecode'] = this.phonecode;
    data['deleted_at'] = this.deletedAt;
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
  Null deletedAt;
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
    deletedAt = json['deleted_at'];
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
