class UserModel{
  String id;
  String name;
  int age;
  String email;

  UserModel({this.id="", required this.name, required this.age,required this.email});

  UserModel.fromJson(Map<String, dynamic>json):this(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age']
  );

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "name":name,
      "email":email,
      "age":age,
    };
  }

}