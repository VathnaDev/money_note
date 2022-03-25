import 'package:flutter/material.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/widgets/input_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.secondary,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.expense),
              Tab(text: AppLocalizations.of(context)!.income),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InputView(inputType: InputType.expense),
            InputView(inputType: InputType.income),
          ],
        ),
      ),
    );
  }
}
