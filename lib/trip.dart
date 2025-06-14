enum PriceLevel { low, midRange, luxury }

class Trip {
  final String title;
  final String duration;
  final String countryType;
  final PriceLevel priceLevel;
  final String imageUrl;

  Trip({
    required this.title,
    required this.duration,
    required this.countryType,
    required this.priceLevel,
    required this.imageUrl,
  });
}
