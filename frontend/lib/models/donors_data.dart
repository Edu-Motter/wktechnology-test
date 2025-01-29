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

  factory DonorsData.empty() {
    return DonorsData(
      bloodType: '',
      numberOfDonors: 0,
      bloodTypeLabel: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodType': bloodType,
      'numberOfDonors': numberOfDonors,
      'bloodTypeLabel': bloodTypeLabel,
    };
  }

  @override
  String toString() {
    return 'BloodDonorData(bloodType: $bloodType, numberOfDonors: $numberOfDonors, bloodTypeLabel: $bloodTypeLabel)';
  }
}