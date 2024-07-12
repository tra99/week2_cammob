class TotalServices {
  final int supplierCount;
  final int buyerCount;
  final int farmerCount;
  final int challengeCount;
  final int transectCount;

  TotalServices({
    required this.supplierCount,
    required this.buyerCount,
    required this.farmerCount,
    required this.challengeCount,
    required this.transectCount,
  });

  factory TotalServices.fromJson(Map<String, dynamic> json) {
    return TotalServices(
      supplierCount: json['supplier_count'],
      buyerCount: json['buyer_count'],
      farmerCount: json['farmer_count'],
      challengeCount: json['challenge_count'],
      transectCount: json['transect_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_count': supplierCount,
      'buyer_count': buyerCount,
      'farmer_count': farmerCount,
      'challenge_count': challengeCount,
      'transect_count': transectCount,
    };
  }
}
