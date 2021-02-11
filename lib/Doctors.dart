


class Doctors {
  String id;
  String name;
  String clas;
  String spi;
  String address;
  String phone;
  String area;
  String imageUrl;

  Doctors(
      {this.id,
        this.name,
        this.clas,
        this.spi,
        this.address,
        this.phone,
        this.area,
        this.imageUrl});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    clas = json['class'] as String;
    spi = json['spi'] as String;
    address = json['address'] as String;
    phone = json['phone'] as String;
    area = json['area'] as String;
    imageUrl = json['image_url'] as String;
  }

  Map<String, Doctors> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['class'] = this.clas;
    data['spi'] = this.spi;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['area'] = this.area;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
