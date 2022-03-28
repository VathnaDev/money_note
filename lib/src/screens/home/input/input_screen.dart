import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/input_type.dart';
import 'package:money_note/src/widgets/input_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputScreen extends HookConsumerWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(child: Text(AppLocalizations.of(context)!.expense)),
            Tab(child: Text(AppLocalizations.of(context)!.income)),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          InputView(inputType: InputType.expense),
          InputView(inputType: InputType.income),
        ],
      ),
    );
  }
}
