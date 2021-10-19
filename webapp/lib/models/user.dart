class User {
  User _instance = 
}

class UserBase {
  final String name;
  final String email;
  final String brand;
  final String restaurant;
  final bool privilege;
  final String token;

  UserBase(this.name, this.email, this.brand, this.restaurant, this.privilege,
      this.token);

  factory UserBase.fromJson(Map<String, dynamic> json) {
    return UserBase(json['name'], json['email'], json['brand'],
        json['restaurant'], json['privilege'], json['token']);
  }
}
