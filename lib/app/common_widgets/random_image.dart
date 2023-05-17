import 'dart:math';

String getRandomImagePath() {
  int totalImages = 15;
  Random random = Random();
  int randomIndex = random.nextInt(totalImages) + 1;
  String imagePath = 'assets/images/gyms/image_gym_$randomIndex.png';
  return imagePath;
}
