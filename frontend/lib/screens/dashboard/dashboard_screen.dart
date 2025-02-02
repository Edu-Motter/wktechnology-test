import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wktechnology/repository/reports_repository.dart';
import 'package:wktechnology/screens/dashboard/dashboard_viewmodel.dart';
import 'package:wktechnology/screens/widgets/ui.dart';

import '../../models/report.dart';
import '../widgets/report_chip.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardViewModel model = DashboardViewModel(
    reportsRepository: ReportsRepositoryMock(),
  );

  @override
  void initState() {
    model.addListener(() => setState(() {}));
    super.initState();
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  int? _selectedIndex;

  Future<void> _pickAndUploadFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        String fileName = file.path.split("/").last;

        if (!fileName.contains('.json')) {
          if (context.mounted) {
            UIHelper.showError(
              context,
              message: 'Somente arquivos JSON podem ser enviados',
            );
          }
        }

        if (fileName.contains('.json')) {
          if (context.mounted) {
            UIHelper.showMessage(
              context,
              message: 'O arquivo: $fileName está sendo enviado, aguarde',
            );
          }

          Uint8List bytes = file.readAsBytesSync();

          // Create FormData with the bytes
          FormData formData = FormData.fromMap({
            'file': MultipartFile.fromBytes(
              bytes,
              filename: result.files.single.name,
            ),
          });

          // Make the POST request
          final response = await _dio.post(
            '/api/uploadJson',
            data: formData,
            onSendProgress: (sent, total) {
              debugPrint(
                  'Upload Progress: ${(sent / total * 100).toStringAsFixed(2)}%');
            },
          );

          if (response.statusCode == 200) {
            if (context.mounted) {
              UIHelper.showSuccess(
                context,
                message: 'Enviado com sucesso ($fileName)',
              );
            }
          }
        }
      } else {
        debugPrint('No file selected');
      }
    } catch (e) {
      debugPrint('Error uploading file: $e');
      if (context.mounted) {
        UIHelper.showError(
          context,
          message: 'Error uploading file: ${e.toString()}',
        );
      }
    }
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
      ),
    );
  }
}

class ReportRender extends StatelessWidget {
  const ReportRender(
      {super.key, required this.report, required this.fetchingData});

  final Report report;
  final bool fetchingData;

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

    if (report is DonorsReport) {
      return Container(color: Colors.blue);
    }

    if (report is BMIReport) {
      return Container(color: Colors.purpleAccent);
    }

    if (report is ObesityReport) {
      return Container(color: Colors.green);
    }

    if (report is StatesReport) {
      return Container(color: Colors.red);
    }

    if (report is AverageAgeReport) {
      return Container(color: Colors.yellow);
    }

    return Container(color: Colors.grey);
  }
}
