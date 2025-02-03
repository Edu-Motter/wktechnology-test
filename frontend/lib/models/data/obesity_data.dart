class ObesityData {
  final String gender;
  final double obesityRate;

  ObesityData({
    required this.gender,
    required this.obesityRate,
  });

  factory ObesityData.fromJson(Map<String, dynamic> json) {
    return ObesityData(
      gender: json['gender'] as String,
      obesityRate: json['obesityRate'] as double,
    );
  }
}
