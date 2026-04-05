enum AllyStatus { online, busy, offline }

class AllySearchModel {
  final String name;
  final double rating;
  final List<String> languages;
  final String image;
  final AllyStatus status;

  const AllySearchModel({
    required this.name,
    required this.rating,
    required this.languages,
    required this.image,
    required this.status,
  });
}