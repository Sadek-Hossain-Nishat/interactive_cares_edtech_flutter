import 'package:flutter/material.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      children: [commonAppBar('Dashboard')],
    ))));
  }
}
