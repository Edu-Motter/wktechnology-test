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
      averageBMI: double.parse(json['averageBMI'] as String),
      ageRangeType: json['ageRangeType'] as String,
    );
  }

  factory BMIData.empty() {
    return BMIData(
      ageRange: '',
      averageBMI: 0.0,
      ageRangeType: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ageRange': ageRange,
      'averageBMI': averageBMI.toString(),
      'ageRangeType': ageRangeType,
    };
  }

  @override
  String toString() {
    return 'AverageBMIData(ageRange: $ageRange, averageBMI: $averageBMI, ageRangeType: $ageRangeType)';
  }
}