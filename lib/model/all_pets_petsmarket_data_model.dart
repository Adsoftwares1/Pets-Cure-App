class PetsMarketModel {
  int? id;
  String? petName;
  String? petImage;
  String? petStatus;
  String? petDescription;
  int? petPrice;
  int? userId;
  String? userImage;
  String? userName;

  PetsMarketModel(
      {this.id,
      this.petName,
      this.petImage,
      this.petStatus,
      this.petDescription,
      this.petPrice,
      this.userId,
      this.userImage,
      this.userName});

  PetsMarketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petName = json['pet_name'];
    petImage = json['pet_image'];
    petStatus = json['pet_status'];
    petDescription = json['pet_description'];
    petPrice = json['pet_price'];
    userId = json['user_id'];
    userImage = json['user_image'];
    userName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pet_name'] = this.petName;
    data['pet_image'] = this.petImage;
    data['pet_status'] = this.petStatus;
    data['pet_description'] = this.petDescription;
    data['pet_price'] = this.petPrice;
    data['user_id'] = this.userId;
    data['user_image'] = this.userImage;
    data['name'] = this.userName;

    return data;
  }
}
