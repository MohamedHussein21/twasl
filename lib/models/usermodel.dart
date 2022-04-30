class ChatUserModel {
  late String name;
  late String email;
  late String phone;
   late String uId;
  late String image;

  ChatUserModel({
    required this.email,required this.phone,required this.name,required this.uId,required this.image,
  });

  ChatUserModel.fromjson(Map<String,dynamic>?json){
    name =json!['name'];
    email =json['email'];
    phone =json['phone'];
    uId =json['uId'];
    image =json['image'];
  }

  Map<String,dynamic> toMap () {
    return
      {
        'name':name,
        'email':email,
        'phone':phone,
        'uId':uId,
        'image':image,

      };
  }
}
