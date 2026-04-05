enum AllyOnlineStatus { online, busy, offline }

class RatingBreakdown {
  final int fiveStar;
  final int fourStar;
  final int threeStar;
  final int twoStar;
  final int oneStar;

  const RatingBreakdown({
    required this.fiveStar,
    required this.fourStar,
    required this.threeStar,
    required this.twoStar,
    required this.oneStar,
  });

  int get total => fiveStar + fourStar + threeStar + twoStar + oneStar;
}

class ReviewModel {
  final String id;
  final int stars;
  final String text;
  final String timeLabel;

  const ReviewModel({
    required this.id,
    required this.stars,
    required this.text,
    required this.timeLabel,
  });
}

class SessionRate {
  final String label;      // Chat / Voice Call / Video Call
  final String rate;       // ₹8/m

  const SessionRate({required this.label, required this.rate});
}

class ViewProfileModel {
  final String id;
  final String name;
  final String imageUrl;
  final bool isVerified;
  final AllyOnlineStatus status;
  final String handle;     // @aliya9
  final String gender;
  final String age;        // 20 Years
  final double rating;
  final int totalHours;
  final int reviewCount;
  final String bio;
  final List<String> languages;
  final List<SessionRate> sessionRates;
  final RatingBreakdown ratingBreakdown;
  final List<ReviewModel> reviews;

  const ViewProfileModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isVerified = false,
    this.status = AllyOnlineStatus.online,
    required this.handle,
    required this.gender,
    required this.age,
    required this.rating,
    required this.totalHours,
    required this.reviewCount,
    required this.bio,
    required this.languages,
    required this.sessionRates,
    required this.ratingBreakdown,
    required this.reviews,
  });
}