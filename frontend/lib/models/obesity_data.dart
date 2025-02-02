class ObesityData {
  final double maleObesityRate;
  final double femaleObesityRate;

  ObesityData({
    required this.maleObesityRate,
    required this.femaleObesityRate,
  });

  factory ObesityData.fromJson(Map<String, dynamic> json) {
    return ObesityData(
      maleObesityRate: json['maleObesityRate'] as double,
      femaleObesityRate: json['femaleObesityRate'] as double,
    );
  }

  factory ObesityData.empty() {
    return ObesityData(
      maleObesityRate: 0,
      femaleObesityRate: 0,
    );
  }
}
