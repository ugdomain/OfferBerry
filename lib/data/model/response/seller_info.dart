class SellerModel {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? password;
  String? status;
  int? category;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? bankName;
  String? branch;
  String? accountNo;
  String? holderName;
  String? authToken;
  String? cmFirebaseToken;
  int? commission;
  String? stripeId;
  String? cardBrand;
  String? cardLastFour;
  String? trialEndsAt;
  Wallet? wallet;

  SellerModel(
      {this.id,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.password,
      this.status,
      this.category,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.bankName,
      this.branch,
      this.accountNo,
      this.holderName,
      this.authToken,
      this.cmFirebaseToken,
      this.commission,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt,
      this.wallet});

  SellerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    category = int.parse(json['category']);
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    authToken = json['auth_token'];
    cmFirebaseToken = json['cm_firebase_token'];
    commission = int.parse(json['commission']);
    stripeId = json['stripe_id'];
    cardBrand = json['card_brand'];
    cardLastFour = json['card_last_four'];
    trialEndsAt = json['trial_ends_at'];
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['image'] = this.image!;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['category'] = this.category;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bank_name'] = this.bankName;
    data['branch'] = this.branch;
    data['account_no'] = this.accountNo;
    data['holder_name'] = this.holderName;
    data['auth_token'] = this.authToken;
    data['cm_firebase_token'] = this.cmFirebaseToken;
    data['commission'] = this.commission;
    data['stripe_id'] = this.stripeId;
    data['card_brand'] = this.cardBrand;
    data['card_last_four'] = this.cardLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    return data;
  }
}

class Wallet {
  int? id;
  dynamic sellerId;
  dynamic balance;
  int? withdrawn;
  String? createdAt;
  String? updatedAt;

  Wallet(
      {this.id,
      this.sellerId,
      this.balance,
      this.withdrawn,
      this.createdAt,
      this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    balance = json['balance'];
    withdrawn = json['withdrawn'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['balance'] = this.balance;
    data['withdrawn'] = this.withdrawn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
