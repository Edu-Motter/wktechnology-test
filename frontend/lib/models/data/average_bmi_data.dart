class BMIData {
  final String ageRange;
  final double averageBMI;
  final String ageRangeType;

  BMIData({
    required this.ageRange,
    required this.averageBMI,
    required this.ageRangeType,
  });

  factory BMIData.fromJson(Map<String, dynamic> json) {
    return BMIData(
      ageRange: json['ageRange'] as String,
      averageBMI: json['averageBMI'] as double,
      ageRangeType: json['ageRangeType'] as String,
    );
  }
}