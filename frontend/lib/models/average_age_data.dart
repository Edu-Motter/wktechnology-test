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
      averageAge: double.parse(json['averageAge'] as String),
      bloodTypeLabel: json['bloodTypeLabel'] as String,
    );
  }

  factory AverageAgeData.empty() {
    return AverageAgeData(
      bloodType: '',
      averageAge: 0.0,
      bloodTypeLabel: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodType': bloodType,
      'averageAge': averageAge.toString(),
      'bloodTypeLabel': bloodTypeLabel,
    };
  }

  @override
  String toString() {
    return 'AverageAge(bloodType: $bloodType, averageAge: $averageAge, bloodTypeLabel: $bloodTypeLabel)';
  }
}