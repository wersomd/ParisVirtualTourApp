class WelcomeModel {
  final String title;
  final String subTitle;
  final String description;
  final String imageUrl;

  WelcomeModel({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.imageUrl,
  });
}

List<WelcomeModel> welcomeComponents = [
  WelcomeModel(
      title: "Путешествие",
      subTitle: "Дороги",
      description: "Путешествуйте по дорогам Франции.",
      imageUrl: "assets/images/welcome-2.jpg"),
  WelcomeModel(
      title: "Наслаждаться",
      subTitle: "Исторические места",
      description: "Насладиться французской архитектурой",
      imageUrl: "assets/images/welcome-1.png"),
  WelcomeModel(
      title: "Открывать",
      subTitle: "Францию",
      description: "Париж по всей красе",
      imageUrl: "assets/images/welcome-3.jpg"),
];
