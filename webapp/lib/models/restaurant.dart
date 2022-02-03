class RestaurantBuffer {
  static RestaurantBuffer _instance = RestaurantBuffer._internal();
  List all = [];
  String predilected = "";

  factory RestaurantBuffer() {
    return _instance;
  }

  static RestaurantBuffer getInstance() {
    return _instance;
  }

  RestaurantBuffer._internal();

  RestaurantBuffer.fromJson(List json) {
    for (var item in json) {
      all.add(Restaurant(item['_id'], item['name'], item['address']));
    }
    _instance = this;
  }
}

class Restaurant {
  late String id;
  late String name;
  late String address;

  Restaurant(this.id, this.name, this.address);
}
