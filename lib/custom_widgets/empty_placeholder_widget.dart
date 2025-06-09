import 'package:flutter/material.dart';
import 'package:trace_game/custom_widgets/primary_buttons.dart';
import 'package:trace_game/utils/string_hardcoded_ext.dart';

import '../app_config/app_size.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            PrimaryButton(
              //onPressed: () => context.goNamed(AppRoute.login.name),
              onPressed: () {},
              text: 'Go Home'.hardcoded,
            ),
          ],
        ),
      ),
    );
  }
}
