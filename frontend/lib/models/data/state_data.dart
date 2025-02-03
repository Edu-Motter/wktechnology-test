class StateData {
  final String state;
  final String stateFullName;
  final int numberOfCandidates;
  final int numberOfValidDonors;

  StateData({
    required this.state,
    required this.stateFullName,
    required this.numberOfCandidates,
    required this.numberOfValidDonors,
  });

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      state: json['state'] as String,
      stateFullName: json['stateFullName'] as String,
      numberOfCandidates: json['numberOfCandidates'] as int,
      numberOfValidDonors: json['numberOfValidDonors'] as int,
    );
  }
}