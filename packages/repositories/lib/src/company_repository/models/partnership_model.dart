class PartnershipModel {
  final String category;
  final String name;
  final String address;
  final String phone;
  final String imageUrl;

  PartnershipModel({
    required this.category,
    required this.name,
    required this.address,
    required this.phone,
    required this.imageUrl,
  });

  factory PartnershipModel.fromJson(Map json) {
    return PartnershipModel(
      category: json['partnershipCategoryName'],
      name: json['partnershipName'],
      address: json['partnershipAddress'],
      phone: json['partnershipContact'],
      imageUrl: json['partnershipImageUrl'],
    );
  }

  Map toMap() {
    return {
      'category': category,
      'name': name,
      'address': address,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }
}
