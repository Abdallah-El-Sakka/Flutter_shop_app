class HomeModel
{

  bool? status;
  HomeDataModel? data;
  String? message;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
    message = json['message'];
  }

}

class HomeDataModel
{

  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  String? ad;

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach(
            (element)
        {
          banners.add(BannersModel.fromJson(element));
        });

    json['products'].forEach(
            (element)
        {
          products.add(ProductsModel.fromJson(element));
        });
  }
}

class BannersModel
{

  int? id;
  String? image;
  Null category;
  Null product;

  BannersModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class ProductsModel
{

  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favourites;
  bool? in_cart;

  ProductsModel.fromJson(dynamic json)
  {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favourites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}