export default class Delivery {
  constructor(id, uploadUser, restaurant, brand, dealer, address, city, postcode, initTime, finishTime, amount, customer, phone, latitude, longitude) {
    this.id = id;
    this.uploadUser = uploadUser;
    this.restaurant = restaurant;
    this.brand = brand;
    this.dealer = dealer;
    this.address = address;
    this.city = city;
    this.postcode = postcode;
    this.initTime = initTime;
    this.finishTime = finishTime;
    this.amount = amount;
    this.customer = customer;
    this.phone = phone;
    this.latitude = latitude;
    this.longitude = longitude;
  }
}
   