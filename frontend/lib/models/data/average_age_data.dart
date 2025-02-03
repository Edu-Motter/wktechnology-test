class AverageAgeData {
  String bloodType;
  double averageAge;
  String bloodTypeLabel;

  AverageAgeData({
    required this.bloodType,
    required this.averageAge,
    required this.bloodTypeLabel,
  });

  factory AverageAgeData.fromJson(Map<String, dynamic> json) {
    return AverageAgeData(
      bloodType: json['bloodType'] as String,
      averageAge: json['averageAge'] as double,
      bloodTypeLabel: json['bloodTypeLabel'] as String,
    );
  }
}
