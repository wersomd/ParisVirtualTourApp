import 'package:flutter/material.dart';

import '../widgets/reuseable_text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 200.0,
            color: Colors.deepPurpleAccent,
          ),
          AppText(
            text: "Профиль",
            size: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
