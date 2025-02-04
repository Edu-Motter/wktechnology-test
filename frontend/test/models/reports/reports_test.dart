import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wktechnology/models/data/state_data.dart';
import 'package:wktechnology/models/reports/states_report.dart';

class MockBuilder extends Mock {
  Widget call(List<StateData> data, bool isEmpty);
}

void main() {
  late MockBuilder mockBuilder;
  late Future<List<StateData>> Function() mockFetch;

  final Widget reportView = Container();

  setUp(() {
    mockBuilder = MockBuilder();
    mockFetch = () async => [
          StateData(
            state: "SP",
            stateFullName: "São Paulo",
            numberOfCandidates: 0,
            numberOfValidDonors: 0,
          ),
          StateData(
            state: "RJ",
            stateFullName: "Rio de Janeiro",
            numberOfCandidates: 0,
            numberOfValidDonors: 0,
          ),
        ];

    registerFallbackValue(<StateData>[]);
    registerFallbackValue(reportView);
  });

  test('should initialize with empty data and default properties', () {
    final report = StatesReport(builder: mockBuilder.call, fetch: mockFetch);

    expect(report.data, isEmpty);
    expect(report.name, 'Estados');
    expect(report.icon, Icons.location_city);
    expect(report.isEmpty, isTrue);
  });

  test('should call builder with empty data when no states are loaded', () {
    final report = StatesReport(builder: mockBuilder.call, fetch: mockFetch);

    when(() => mockBuilder([], true)).thenReturn(reportView);

    final widget = report.view;

    expect(widget, isA<Widget>());
    expect(report.data, isEmpty);
    verify(() => mockBuilder([], true)).called(1);
  });

  test('should call builder with state data when loaded', () async {
    final report = StatesReport(builder: mockBuilder.call, fetch: mockFetch);

    final states = await mockFetch();

    when(() => mockBuilder(states, false)).thenReturn(reportView);

    final widget = report.builder(states, false);

    expect(widget, isA<Widget>());
    expect(states.length, 2);
    verify(() => mockBuilder(states, false)).called(1);
  });
}
