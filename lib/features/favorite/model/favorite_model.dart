enum FavoriteStatus { online, onACall, availableLater, offline }

class FavoriteModel {
  final String id;
  final String name;
  final String image;
  final FavoriteStatus status;
  final bool isVerified;
  final bool isFavorited;

  // shown when status == online
  final String? latestSessionType; // e.g. 'Chat'
  final String? latestSessionTime; // e.g. '12m'

  // shown when status != online
  final double? rating;
  final int? reviews;
  final int? hours;
  final String? estimatedWait; // e.g. '~8m'

  const FavoriteModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    this.isVerified = false,
    this.isFavorited = true,
    this.latestSessionType,
    this.latestSessionTime,
    this.rating,
    this.reviews,
    this.hours,
    this.estimatedWait,
  });

  FavoriteModel copyWith({bool? isFavorited}) {
    return FavoriteModel(
      id: id,
      name: name,
      image: image,
      status: status,
      isVerified: isVerified,
      isFavorited: isFavorited ?? this.isFavorited,
      latestSessionType: latestSessionType,
      latestSessionTime: latestSessionTime,
      rating: rating,
      reviews: reviews,
      hours: hours,
      estimatedWait: estimatedWait,
    );
  }
}