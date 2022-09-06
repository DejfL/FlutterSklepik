class Rating {
  final double rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> parsedJson) {
    return Rating(
      rate: double.parse(parsedJson['rate'].toString()),
      count: parsedJson['count'] as int,
    );
  }
}
