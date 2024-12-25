class ProductAPi {
  String? id;
  String? productName;
  String? productCode;
  String? image;
  String? unitPrice;
  String? quantity;
  String? totalPrice;
  String? createdDate;

  ProductAPi({
    this.id,
    this.productName,
    this.productCode,
    this.image =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc5Kd3sfydyPwXIn4yH1Sr8l-ZS4bX5Fnq0g&s',
    this.unitPrice,
    this.quantity,
    this.totalPrice,
    this.createdDate,
  });
}
