class PriceSpaceModel {
  PriceSpaceModel(this.price, this.discount, this.assessment);

  double price;
  double discount;
  double assessment;

  double getTotal() => (price + discount) - assessment;
}
