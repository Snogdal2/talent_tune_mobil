import 'package:flutter/material.dart';

import '../company/page_Container.dart';

void pushPageWithoutTransition(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, __) => pageContainer(widget),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}
