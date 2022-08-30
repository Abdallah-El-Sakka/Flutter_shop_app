class ShoppingModel
{
  late bool status;
  String? message;
  UserData? data;

  ShoppingModel.fromJson(dynamic json)
  {
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    message = json['message'];
  }

}

class UserData
{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? token;
  int? points;
  int? credit;

  // UserData({
  //   this.name,
  //   this.email,
  //   this.token,
  //   this.phone,
  //   this.id,
  //   this.credit,
  //   this.image,
  //   this.points
  // });

  //named constructor
  UserData.fromJson(dynamic json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
  }

}