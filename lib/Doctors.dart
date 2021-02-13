


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
class SamStock {
  String id;
  String name;
  String userId;
  String quantity;
  String note;

  SamStock({this.id, this.name, this.userId, this.quantity, this.note});

  SamStock.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    userId = json['user_id'] as String;
    quantity = json['quantity'] as String;
    note = json['note'] as String;
  }

  Map<String, SamStock> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['note'] = this.note;
    return data;
  }
}