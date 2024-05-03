class products {
  String? cartId;
  String id;
  String? title;
  String? tprice;
  String? img;
  String? color;
  String? vendorId;
  String? sellerName;
  String? qty;

  products(
      {required this.id,
        this.cartId,
        this.title,
        this.tprice,
        this.img,
        this.color,
        this.vendorId,
        this.sellerName,
        this.qty});
}