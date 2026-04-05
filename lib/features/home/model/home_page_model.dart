class HomePageModel {
  final String name;
  final int age;
  final String image;
  final double rating;
  final int reviews;
  final int hours;
  final String bio;
  final String status;
  final bool isOnline;
  final bool isVerified;
  final bool canTalkNow;
  final String? estimatedTime;

  HomePageModel({
    required this.name,
    required this.age,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.hours,
    required this.bio,
    required this.status,
    required this.isOnline,
    required this.isVerified,
    required this.canTalkNow,
    this.estimatedTime,
  });
}