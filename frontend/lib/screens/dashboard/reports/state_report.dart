import 'package:flutter/material.dart';
import 'package:wktechnology/models/state_data.dart';

class StateReportView extends StatelessWidget {
  const StateReportView({super.key, required this.data});

  final List<StateData> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Candaditos por estado'),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final state = data[index];
              return Card(
                child: Row(
                  children: [
                    Icon(Icons.male, color: Colors.lightBlueAccent[300]),
                    Text('State: ${state.stateFullName}'),
                    Text('count: ${state.numberOfCandidates}'),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
