class ChangeFavourite
{
  bool? status;
  String? message;

  ChangeFavourite.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }

}