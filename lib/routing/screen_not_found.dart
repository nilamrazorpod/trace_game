import 'package:flutter/material.dart';
import 'package:trace_game/utils/string_hardcoded_ext.dart';

import '../custom_widgets/empty_placeholder_widget.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(message: '404 - Page not found!'.hardcoded),
    );
  }
}
