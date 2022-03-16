import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/data/monthly_report.dart';
import 'package:money_note/src/providers/monthly_report_state.dart';
import 'package:money_note/src/providers/notes_state.dart';
import 'package:money_note/src/screens/note_detail/note_detail_screen.dart';
import 'package:money_note/src/utils/date_ext.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/currency_text.dart';
import 'package:money_note/src/widgets/date_picker.dart';
import 'package:money_note/src/widgets/note_list.dart';

class MonthlyReportView extends HookConsumerWidget {
  MonthlyReportView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var month = useState(DateTime.now());
    final report = ref.watch(monthlyReportStateProvider(month.value));

    void onNoteTap(note) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NoteDetailScreen(
            note: note,
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 410,
            floating: true,
            snap: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DatePicker(
                      initialDate: month.value,
                      displayFormat: MMMMyyyy,
                      incrementBy: const Duration(days: 31),
                      onDateChanged: (newDate) {
                        month.value = newDate;
                      },
                    ),
                    const SizedBox(height: 16),
                    BalanceInfo(report: report),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: Theme.of(context).backgroundColor,
                ),
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: "All"),
                    Tab(text: "Expense"),
                    Tab(text: "Income"),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          children: [
            NoteList(
              onNoteTap: onNoteTap,
              notes: report.notes,
            ),
            NoteList(
              onNoteTap: onNoteTap,
              notes: report.expenseNotes,
            ),
            NoteList(
              onNoteTap: onNoteTap,
              notes: report.incomeNotes,
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceInfo extends StatelessWidget {
  BalanceInfo({Key? key, required this.report}) : super(key: key);

  final MonthlyReport report;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: boxDecoration,
          child: Row(
            children: [
              const Text("Current balance"),
              Expanded(
                child: CurrencyText(value: report.currentBalance),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: boxDecoration,
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Income"),
                  Expanded(
                    child: CurrencyText(value: report.income),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Expense"),
                  Expanded(
                    child: CurrencyText(
                      value: report.expense * -1,
                      colorizeText: false,
                      textStyle: const TextStyle(color: colorExpense),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: boxDecoration,
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Expense/Income"),
                  Expanded(
                    child: CurrencyText(
                      value: report.expenseIncome,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Previous Balance"),
                  Expanded(
                    child: CurrencyText(
                      value: report.previousBalance,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
