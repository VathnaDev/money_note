import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  void onSkip() {}

  void onGetStarted() {}

  void onContinue() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          children: [
            OnboardingItem(
              pageLabel: "1/3",
              buttonText: "Continue",
              onButtonTap: onContinue,
              onSkip: onSkip,
              title: "Easy to add new transaction",
              image: "assets/images/Illustration_1.svg",
              description:
                  "We always try to bring the best experience to users. Your transactions are recorded as quickly as possible. You will not have any difficulties when you first use MoNo.",
            ),
            OnboardingItem(
              pageLabel: "2/3",
              buttonText: "Continue",
              onSkip: onSkip,
              onButtonTap: onContinue,
              title: "Track income and expenses",
              image: "assets/images/Illustration_2.svg",
              description:
                  "Details tracking transactions visually with the adding images features bills.",
            ),
            OnboardingItem(
              pageLabel: "2/3",
              buttonText: "Get Started",
              onButtonTap: onContinue,
              title: "Comprehensive Report",
              image: "assets/images/Illustration_3.svg",
              description:
                  "Supports viewing your balance for monthly, income and expenses, debts, loans as well as reports with category.",
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    Key? key,
    required this.pageLabel,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonTap,
    this.onSkip,
  }) : super(key: key);

  final String pageLabel;
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonTap;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pageLabel),
                const Spacer(),
                if (onSkip != null)
                  OutlinedButton(
                    onPressed: () {
                      onSkip?.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Skip"),
                    ),
                  )
              ],
            ),
          ),
          SvgPicture.asset(image),
          Text(
            title,
            style: textTheme.headline2?.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              description,
              style: textTheme.bodyText1?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onButtonTap,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
