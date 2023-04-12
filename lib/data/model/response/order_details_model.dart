// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<OrderDetailsModel> welcomeFromJson(String str) =>
    List<OrderDetailsModel>.from(
        json.decode(str).map((x) => OrderDetailsModel.fromJson(x)));

String welcomeToJson(List<OrderDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsModel {
  OrderDetailsModel({
    this.id,
    this.orderId,
    this.productId,
    this.sellerId,
    this.productDetails,
    this.qty,
    this.price,
    this.tax,
    this.discount,
    this.deliveryStatus,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.shippingMethodId,
    this.variant,
    this.variation,
    this.discountType,
    this.isStockDecreased,
    this.sellerAmount,
    this.commissionOn,
    this.adminCommission,
    this.shipping,
  });

  int? id;
  int? orderId;
  int? productId;
  int? sellerId;
  ProductDetails? productDetails;
  int? qty;
  int? price;
  int? tax;
  int? discount;
  String? deliveryStatus;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? shippingMethodId;
  dynamic variant;
  String? variation;
  String? discountType;
  String? isStockDecreased;
  String? sellerAmount;
  String? commissionOn;
  String? adminCommission;
  Shipping? shipping;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        sellerId: json["seller_id"],
        productDetails: ProductDetails.fromJson(json["product_details"]),
        qty: json["qty"],
        price: json["price"],
        tax: json["tax"],
        discount: json["discount"],
        deliveryStatus: json["delivery_status"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shippingMethodId: json["shipping_method_id"],
        variant: json["variant"],
        variation: json["variation"],
        discountType: json["discount_type"],
        isStockDecreased: json["is_stock_decreased"],
        sellerAmount: json["seller_amount"],
        commissionOn: json["commission_on"],
        adminCommission: json["admin_commission"],
        shipping: json["shipping"] != null
            ? Shipping.fromJson(json["shipping"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "seller_id": sellerId,
        "product_details": productDetails!.toJson(),
        "qty": qty,
        "price": price,
        "tax": tax,
        "discount": discount,
        "delivery_status": deliveryStatus,
        "payment_status": paymentStatus,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "shipping_method_id": shippingMethodId,
        "variant": variant,
        "variation": variation,
        "discount_type": discountType,
        "is_stock_decreased": isStockDecreased,
        "seller_amount": sellerAmount,
        "commission_on": commissionOn,
        "admin_commission": adminCommission,
        "shipping": shipping!.toJson(),
      };
}

class ProductDetails {
  ProductDetails({
    this.id,
    this.addedBy,
    this.userId,
    this.name,
    this.slug,
    this.categoryIds,
    this.category,
    this.brandId,
    this.unit,
    this.minQty,
    this.refundable,
    this.images,
    this.thumbnail,
    this.featured,
    this.flashDeal,
    this.videoProvider,
    this.videoUrl,
    this.colors,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.variation,
    this.published,
    this.unitPrice,
    this.purchasePrice,
    this.tax,
    this.taxType,
    this.discount,
    this.discountType,
    this.currentStock,
    this.details,
    this.freeShipping,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.featuredStatus,
    this.commission,
  });

  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  List<CategoryId>? categoryIds;
  int? category;
  int? brandId;
  String? unit;
  int? minQty;
  int? refundable;
  List<String>? images;
  String? thumbnail;
  dynamic featured;
  dynamic flashDeal;
  dynamic videoProvider;
  dynamic videoUrl;
  List<dynamic>? colors;
  String? variantProduct;
  dynamic attributes;
  List<dynamic>? choiceOptions;
  List<dynamic>? variation;
  int? published;
  int? unitPrice;
  int? purchasePrice;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  int? currentStock;
  dynamic details;
  int? freeShipping;
  dynamic attachment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  int? featuredStatus;
  String? commission;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromJson(x))),
        category: json["category"],
        brandId: json["brand_id"],
        unit: json["unit"],
        minQty: json["min_qty"],
        refundable: json["refundable"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
        featured: json["featured"],
        flashDeal: json["flash_deal"],
        videoProvider: json["video_provider"],
        videoUrl: json["video_url"],
        colors: List<dynamic>.from(json["colors"].map((x) => x)),
        variantProduct: json["variant_product"].toString(),
        attributes: json["attributes"],
        choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
        variation: List<dynamic>.from(json["variation"].map((x) => x)),
        published: json["published"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock: json["current_stock"],
        details: json["details"],
        freeShipping: json["free_shipping"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        featuredStatus: json["featured_status"],
        commission: json["commission"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "added_by": addedBy,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "category_ids": List<dynamic>.from(categoryIds!.map((x) => x.toJson())),
        "category": category,
        "brand_id": brandId,
        "unit": unit,
        "min_qty": minQty,
        "refundable": refundable,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": thumbnail,
        "featured": featured,
        "flash_deal": flashDeal,
        "video_provider": videoProvider,
        "video_url": videoUrl,
        "colors": List<dynamic>.from(colors!.map((x) => x)),
        "variant_product": variantProduct,
        "attributes": attributes,
        "choice_options": List<dynamic>.from(choiceOptions!.map((x) => x)),
        "variation": List<dynamic>.from(variation!.map((x) => x)),
        "published": published,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "tax": tax,
        "tax_type": taxType,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock,
        "details": details,
        "free_shipping": freeShipping,
        "attachment": attachment,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "status": status,
        "featured_status": featuredStatus,
        "commission": commission,
      };
}

class CategoryId {
  CategoryId({
    this.id,
    this.position,
  });

  String? id;
  int? position;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
}

class Shipping {
  Shipping({
    this.id,
    this.creatorId,
    this.creatorType,
    this.category,
    this.title,
    this.cost,
    this.duration,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? creatorId;
  String? creatorType;
  String? category;
  String? title;
  int? cost;
  String? duration;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        id: json["id"],
        creatorId: json["creator_id"],
        creatorType: json["creator_type"],
        category: json["category"],
        title: json["title"],
        cost: json["cost"],
        duration: json["duration"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "creator_id": creatorId,
        "creator_type": creatorType,
        "category": category,
        "title": title,
        "cost": cost,
        "duration": duration,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
