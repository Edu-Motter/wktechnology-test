import 'package:flutter_test/flutter_test.dart';
import 'package:wktechnology/models/data/donors_data.dart';

void main() {
  group('DonorsData Model', () {
    test('should create a valid instance with given parameters', () {
      final donorsData = DonorsData(
        bloodType: 'A+',
        numberOfDonors: 100,
        bloodTypeLabel: 'A_POSITIVE',
      );

      expect(donorsData.bloodType, 'A+');
      expect(donorsData.numberOfDonors, 100);
      expect(donorsData.bloodTypeLabel, 'A_POSITIVE');
    });

    test('should create a valid instance from JSON', () {
      final json = {
        'bloodType': 'O-',
        'numberOfDonors': 200,
        'bloodTypeLabel': 'O_NEGATIVE',
      };

      expect(json['numberOfDonors'], isA<int>());

      final donorsData = DonorsData.fromJson(json);

      expect(donorsData.bloodType, 'O-');
      expect(donorsData.numberOfDonors, 200);
      expect(donorsData.bloodTypeLabel, 'O_NEGATIVE');
    });

    test('should throw an error if JSON is missing required fields', () {
      final invalidJson = {
        'bloodType': 'B+',
        'bloodTypeLabel': 'B_POSITIVE',
        // 'numberOfDonors' is missing
      };

      expect(() => DonorsData.fromJson(invalidJson), throwsA(isA<TypeError>()));
    });
  });
}
