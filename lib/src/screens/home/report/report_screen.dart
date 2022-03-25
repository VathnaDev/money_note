import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/screens/home/report/category_report/category_report_view.dart';
import 'package:money_note/src/screens/home/report/mothly_report/monthly_report_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportScreen extends HookConsumerWidget {
  ReportScreen({
    Key? key,
  }) : super(key: key);

  final views = [
    MonthlyReportView(),
    CategoryReportView(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var filter = useState(0);

    void onFilter(int index) {
      filter.value = index;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          filter.value == 0
              ? AppLocalizations.of(context)!.montlyReport
              : AppLocalizations.of(context)!.categoryReport,
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.filter_alt_outlined),
            onSelected: (value) {
              onFilter(value);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.event, color: Theme.of(context).primaryColor),
                      SizedBox(width: 16),
                      Text(AppLocalizations.of(context)!.montly),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.category,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 16),
                      Text(AppLocalizations.of(context)!.category),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: filter.value,
        children: views,
      ),
    );
  }
}
