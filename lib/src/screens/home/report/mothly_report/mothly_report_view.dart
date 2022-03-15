import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/riverpod/notes_state.dart';
import 'package:money_note/src/screens/note_detail/note_detail_screen.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:money_note/src/widgets/date_picker.dart';
import 'package:money_note/src/widgets/note_list.dart';

class MonthlyReportView extends HookConsumerWidget {
  MonthlyReportView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DatePicker(initialDate: DateTime.now()),
                    const SizedBox(height: 16),
                    BalanceInfo(),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: Theme.of(context).backgroundColor,
                ),
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
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
              notes: ref.watch(notesStateProvider(null)),
            ),
            NoteList(
              onNoteTap: onNoteTap,
              notes: ref.watch(
                notesStateProvider(NoteFilter(type: InputType.expense.name)),
              ),
            ),
            NoteList(
              onNoteTap: onNoteTap,
              notes: ref.watch(
                notesStateProvider(NoteFilter(type: InputType.income.name)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceInfo extends StatelessWidget {
  BalanceInfo({Key? key}) : super(key: key);

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
                child: Text(
                  "\$100,000,000",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
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
                  const Expanded(
                    child: Text("\$100,000,000", textAlign: TextAlign.right),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  const Text("Expense"),
                  const Expanded(
                    child: Text("-\$100,000,000", textAlign: TextAlign.right),
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
                  const Expanded(
                    child: Text("\$100,000,000", textAlign: TextAlign.right),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  const Text("Previous Balance"),
                  const Expanded(
                    child: Text("-\$100,000,000", textAlign: TextAlign.right),
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
