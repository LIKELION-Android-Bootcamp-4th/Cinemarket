class DetailShippingInfo {
  final String recipient;
  final String address;
  final String phone;
  final String zipCode;
  final String deliveryOption;
  final bool freeShippingApplied;
  final String shippingCostRatio;

  DetailShippingInfo({
    required this.recipient,
    required this.address,
    required this.phone,
    required this.zipCode,
    required this.deliveryOption,
    required this.freeShippingApplied,
    required this.shippingCostRatio,
  });

  factory DetailShippingInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return DetailShippingInfo(
        recipient: '',
        address: '',
        phone: '',
        zipCode: '',
        deliveryOption: '',
        freeShippingApplied: false,
        shippingCostRatio: '',
      );
    }
    return DetailShippingInfo(
      recipient: json['recipient'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      zipCode: json['zipCode'] ?? '',
      deliveryOption: json['deliveryOption'] ?? '',
      freeShippingApplied: json['freeShippingApplied'] ?? false,
      shippingCostRatio: json['shippingCostRatio'] ?? '',
    );
  }
}