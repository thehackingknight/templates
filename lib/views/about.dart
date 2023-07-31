import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/widgets/common.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize(context).width -  bottomBarH,
      padding: const EdgeInsets.all(8),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Text("About us"),
        ],
      ),
    );
  }
}
