// Кастомный AppBar с Bottom
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBarWithBottom extends StatelessWidget
    implements PreferredSizeWidget {
  final User? currentUser;
  final GlobalKey<ScaffoldState> scaffoldKey;

  // ignore: use_key_in_widget_constructors
  const CustomAppBarWithBottom({
    required this.currentUser,
    required this.scaffoldKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 110);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Europe Virtual Tour',
          style:
              TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 0.53),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(
            Icons.subject,
            color: Colors.white,
            size: 32,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Обработка нажатия на иконку уведомлений
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 20),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person_outline_rounded),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser != null
                          ? 'Привет ${currentUser!.displayName}'
                          : 'Привет',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      currentUser != null
                          ? currentUser!.email ?? 'Войдите чтобы увидеть тур'
                          : 'Войдите чтобы увидеть тур',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      currentUser?.phoneNumber ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Стандартный AppBar без Bottom
AppBar defaultAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.indigo,
    centerTitle: true,
    title: const Text(
      'Europe Virtual Tour',
      style: TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 0.53),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.subject,
        color: Colors.white,
        size: 32,
      ),
    ),
    actions: [
      InkWell(
        onTap: () {
          // Обработка нажатия на иконку уведомлений
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.notifications,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
