
class OutletListEntity{
  int id;
  String name;
  double lat;
  double lng;
  String streetAddress;
  String city;
  int countryId;
  String postalCode;
  String address;
  String imageUrl;

  OutletListEntity(
      {this.id,
        this.name,
        this.lat,
        this.lng,
        this.streetAddress,
        this.city,
        this.countryId,
        this.postalCode,
        this.address,
        this.imageUrl});

  @override
  String toString() {
    return 'OutletListEntity{name: $name, city: $city}';
  }
}