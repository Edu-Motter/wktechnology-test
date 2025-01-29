class StateData {
  final String state;
  final String stateFullName;
  final int numberOfCandidates;

  StateData({
    required this.state,
    required this.stateFullName,
    required this.numberOfCandidates,
  });

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      state: json['state'] as String,
      stateFullName: json['stateFullName'] as String,
      numberOfCandidates: json['numberOfCandidates'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'stateFullName': stateFullName,
      'numberOfCandidates': numberOfCandidates,
    };
  }

  factory StateData.empty() {
    return StateData(
      state: 'empty',
      stateFullName: 'empty',
      numberOfCandidates: 0,
    );
  }

  @override
  String toString() {
    return 'StateData(state: $state, stateFullName: $stateFullName, numberOfCandidates: $numberOfCandidates)';
  }
}