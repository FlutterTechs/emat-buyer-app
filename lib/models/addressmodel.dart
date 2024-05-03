class UserAddress {
  String? address;
  String? city;
  String? contactNumber;
  String? country;
  String? landmark;
  String? name;
  String? pincode;
  String? state;
  String? shipmentType;

  UserAddress(
      {this.address,
        this.city,
        this.contactNumber,
        this.country,
        this.landmark,
        this.name,
        this.pincode,
        this.state,
        this.shipmentType});

  UserAddress.fromJson(Map<dynamic, dynamic> json) {
    address = json['address'];
    city = json['city'];
    contactNumber = json['contact_number'];
    country = json['country'];
    landmark = json['landmark'];
    name = json['name'];
    pincode = json['pincode'];
    state = json['state'];
    shipmentType = json['shipment_type'];
  }

  Map toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Address'] = this.address;
    data['city'] = this.city;
    data['contact_number'] = this.contactNumber;
    data['country'] = this.country;
    data['landmark'] = this.landmark;
    data['name'] = this.name;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['shipment_type'] = this.shipmentType;
    return data;
  }
}