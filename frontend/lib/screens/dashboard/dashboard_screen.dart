import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

import '../../models/reports/report.dart';
import '../../repository/reports_repository_impl.dart';
import '../widgets/report_chip.dart';
import '../widgets/ui.dart';
import 'dashboard_viewmodel.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => model.executeRefresh());
    });
    super.initState();
  }

  Future<void> _pickAndUploadFile(BuildContext context) async {
    final result = model.getJsonAndUpload();
    result.fold(
      (success) => UIHelper.showSuccess(context, message: success),
      (error) => UIHelper.showError(
        context,
        message: 'Fail: $error',
      ),
    );
  }

  void updateReportSelected({required Report report}) {
    model.updateSelectedReport(report);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double defaultPadding = 16;

    final title = Row(
      children: [
        SizedBox(height: 8),
        Text(
          'WK technology',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor),
        ),
        Spacer(),
        Icon(
          Icons.water_drop_outlined,
          color: theme.primaryColor,
          size: 32,
        ),
      ],
    );

    final reportSelection = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Divider(
          height: 4,
          color: theme.primaryColor.withValues(alpha: .5),
          thickness: 0.5,
          endIndent: defaultPadding,
          indent: defaultPadding,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultPadding),
              for (int i = 0; i < model.reports.length; i++)
                Padding(
                  padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
                  child: ReportChip(
                    icon: model.reports[i].icon,
                    text: model.reports[i].name,
                    isSelected: model.isThisReportSelected(i),
                    onSelect: () {
                      model.updateSelectedReport(model.reports[i]);
                    },
                  ),
                ),
              SizedBox(width: defaultPadding),
            ],
          ),
        ),
        SizedBox(height: defaultPadding),
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
          preferredSize: Size(size.width, 64),
          child: reportSelection,
        ),
      ),
      floatingActionButton: AddCandidatesButton(
        onPressed: () => _pickAndUploadFile(context),
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

  final Report? report;
  final bool fetchingData;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (fetchingData || report == null) {
      return Container(
        color: Colors.white,
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

    if (report != null) {
      return report!.view;
    } else {
      return Container(color: Colors.grey);
    }
  }
}

class AddCandidatesButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddCandidatesButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.upload),
      label: const Text("Adicionar Candidatos"),
    );
  }
}
