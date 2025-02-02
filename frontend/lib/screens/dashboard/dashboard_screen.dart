import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wktechnology/screens/dashboard/reports/average_age_report.dart';
import 'package:wktechnology/screens/dashboard/reports/bmi_report.dart';

import '../../models/obesity_data.dart';
import '../../models/report.dart';
import '../../models/state_data.dart';
import '../../repository/reports_repository.dart';
import '../widgets/report_chip.dart';
import '../widgets/ui.dart';
import 'dashboard_viewmodel.dart';
import 'reports/donors_report.dart';
import 'reports/obesity_report.dart';
import 'reports/state_report.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardViewModel model = DashboardViewModel(
    reportsRepository: ReportsRepositoryImpl(),
  );

  @override
  void initState() {
    model.addListener(() => setState(() {}));
    super.initState();
  }

  Future<void> _pickAndUploadFile(BuildContext context) async {
    final result = model.getJsonAndUpload();
    result.fold(
      (success) => UIHelper.showSuccess(context, message: success),
      (error) => UIHelper.showError(
        context,
        message: 'ERROR: $error',
      ),
    );
  }

  void updateReportSelection({required Report report}) {
    model.updateSelectedReport(report);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double widthPadding = 16;

    final title = Row(
      children: [
        Text('WK technology', style: TextStyle(color: theme.primaryColor)),
        Spacer(),
        Icon(Icons.water_drop_outlined, color: theme.primaryColor),
      ],
    );

    final reportSelection = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 4),
        Divider(
            height: 4,
            color: theme.primaryColor.withValues(alpha: .5),
            thickness: 0.5,
            endIndent: 16,
            indent: 16),
        SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: widthPadding),
            child: Text(
              'Selecione um relatório:',
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.primaryColor.withValues(alpha: .75)),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            SizedBox(width: widthPadding),
            for (int i = 0; i < model.reports.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ReportChip(
                  icon: model.reports[i].getType().icon,
                  text: model.reports[i].getType().label,
                  isSelected: model.isThisReportSelected(model.reports[i]),
                  onSelect: () => updateReportSelection(
                    report: model.reports[i],
                  ),
                ),
              ),
            SizedBox(width: widthPadding),
          ]),
        ),
        SizedBox(height: 16)
      ],
    );

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: theme.colorScheme.inversePrimary.withValues(
          alpha: .5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(size.width, 72),
          child: reportSelection,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: false,
        onPressed: () => _pickAndUploadFile(context),
        child: Icon(Icons.upload),
      ),
      body: ReportRender(
        report: model.selectedReport,
        fetchingData: model.fetchingData,
        errorMessage: model.errorMessage,
      ),
    );
  }
}

class ReportRender extends StatelessWidget {
  const ReportRender({
    super.key,
    required this.report,
    required this.fetchingData,
    required this.errorMessage,
  });

  final Report report;
  final bool fetchingData;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (fetchingData) {
      return Container(
        color: Colors.grey,
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Falha ao carregar relatório'),
                Text(errorMessage!),
              ],
            ),
          ),
        ),
      );
    }

    if (report is DonorsReport) {
      return DonorsReportView(data: report.getData());
    }

    if (report is BMIReport) {
      return BMIReportView(data: report.getData());
    }

    if (report is ObesityReport) {
      return ObesityReportView(data: report.getData());
    }

    if (report is StatesReport) {
      return StateReportView(data: report.getData());
    }

    if (report is AverageAgeReport) {
      return AverageAgeReportView(data: report.getData());
    }

    return Container(color: Colors.grey);
  }
}
