class ShippingInfo {
  final String recipient;
  final String address;
  final String phone;
  final String zipCode;
  final String deliveryOption;

  ShippingInfo({
    required this.recipient,
    required this.address,
    required this.phone,
    required this.zipCode,
    required this.deliveryOption,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ShippingInfo(
        recipient: '',
        address: '',
        phone: '',
        zipCode: '',
        deliveryOption: '',
      );
    }
    return ShippingInfo(
      recipient: json['recipient'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      zipCode: json['zipCode'] ?? '',
      deliveryOption: json['deliveryOption'] ?? '',
    );
  }
}