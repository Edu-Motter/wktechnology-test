class DonorsData {
  final String bloodType;
  final int numberOfDonors;
  final String bloodTypeLabel;

  DonorsData({
    required this.bloodType,
    required this.numberOfDonors,
    required this.bloodTypeLabel,
  });

  factory DonorsData.fromJson(Map<String, dynamic> json) {
    return DonorsData(
      bloodType: json['bloodType'] as String,
      numberOfDonors: json['numberOfDonors'] as int,
      bloodTypeLabel: json['bloodTypeLabel'] as String,
    );
  }
}