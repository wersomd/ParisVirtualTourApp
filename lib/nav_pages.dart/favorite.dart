import 'package:flutter/material.dart';

import '../widgets/reuseable_text.dart';

class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 200.0,
            color: Colors.deepPurpleAccent,
          ),
          AppText(
            text: "Любимое",
            size: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
