import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  File? _image;

  Future<void> uploadProfilePhoto() async {}

  Future<void> saveProfilePhoto() async {
    final picker = ImagePicker();

    // Выбор изображения из галереи
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Получение папки для сохранения изображения
      final appDir = await getApplicationDocumentsDirectory();

      // Генерация уникального имени файла
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Создание пути к файлу
      final filePath = '${appDir.path}/$fileName.jpg';

      // Сохранение изображения по пути filePath
      await pickedFile.saveTo(filePath);

      // Вывод пути сохраненного файла
      print('Saved profile photo: $filePath');
    }
  }

  Future<void> signOut() async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();

    navigator.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  void login() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white54,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 65,
                  backgroundImage: _image == null
                      ? const AssetImage("assets/images/profile.png")
                      : AssetImage("$_image"),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        onPressed: () {
                          user == null ? login() : uploadProfilePhoto();
                        },
                        icon: (user == null && _image == null)
                            ? const Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black,
                                size: 32,
                              )
                            : const Icon(
                                Icons.create_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user == null
                      ? 'Вы не вошли'
                      : "${user?.email!.split('@')[0]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user == null ? 'address@gmail.com' : '${user?.email}',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              color: Colors.white70,
              margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(
                onPressed: () => user == null ? login() : signOut(),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black54,
                  ),
                  title: Text(
                    user == null ? 'Войти' : 'Выйти',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
