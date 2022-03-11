import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/screens/home/report/mothly_report/mothly_report_view.dart';
import 'package:money_note/src/widgets/date_picker.dart';

class ReportScreen extends HookConsumerWidget {
  const ReportScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          )
        ],
      ),
      body:  MonthlyReportView(),
    );
  }
}
