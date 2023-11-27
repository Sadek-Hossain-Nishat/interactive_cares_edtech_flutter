import 'package:flutter/material.dart';
import 'package:interactive_cares_app/domainlayer/commpon_appbar.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      children: [commonAppBar('Catergory')],
    ))));
  }
}
