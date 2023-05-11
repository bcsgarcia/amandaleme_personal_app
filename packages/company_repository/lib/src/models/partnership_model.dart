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
      category: json['partnershipCategoryName'] as String,
      name: json['partnershipName'] as String,
      address: json['partnershipAddress'] as String,
      phone: json['partnershipContact'] as String,
      imageUrl: json['partnershipImageUrl'] as String,
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
