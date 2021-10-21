class User {
  static User _instance = User._internal();
  late String name;
  late String email;
  late String brand;
  late String restaurant;
  late bool privilege;
  late String token;

  factory User() {
    return _instance;
  }

  User._internal() {
    name = '';
    email = '';
    brand = '';
    restaurant = '';
    privilege = false;
    token = '';
  }

  static User getInstance() {
    return _instance;
  }

  static void fromJson(Map<String, dynamic> json) {
    User._setParameters(json['name'], json['email'], json['brand'],
        json['restaurant'], json['privilege'], json['token']);
  }

  User._setParameters(this.name, this.email, String? brand, String? restaurant,
      bool? privilege, this.token) {
    (brand == null) ? this.brand = brand! : brand = '';
    (restaurant == null) ? this.restaurant = restaurant! : restaurant = '';
    (privilege == null) ? this.privilege = privilege! : privilege = false;
    _instance = this;
  }
}
