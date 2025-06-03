import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExploreScreen extends StatelessWidget {
  final DestinationService destinationService = DestinationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          "Explore",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<DestinationResponse>(
          future: destinationService.getDestinations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data!.destinations.isEmpty) {
              return const Center(child: Text('No destinations found'));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PlacesGrid(destinations: snapshot.data!.destinations),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Explore'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class PlacesGrid extends StatelessWidget {
  final List<Destination> destinations;

  const PlacesGrid({required this.destinations, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: destinations.map((destination) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CustomCard(
            imageUrl: destination.coverImage,
            name: destination.name,
            location: '${destination.city}, ${destination.country}',
            category: destination.type,
            rating: destination.averageRating.toString(),
            price: destination.priceRange,
          ),
        );
      }).toList(),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String category;
  final String rating;
  final String price;

  const CustomCard({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.category,
    required this.rating,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 180,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  size: 50, color: Colors.grey),
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        ),
                      ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  category,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 5),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < (double.tryParse(rating)?.round() ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.teal,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Price: $price',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Destination {
  final String destinationId;
  final String name;
  final String description;
  final String coverImage;
  final String type;
  final String country;
  final String city;
  final String priceRange;
  final bool isVerified;
  final bool isOpen24Hours;
  final String? openTime;
  final String? closeTime;
  final double averageRating;
  final int visitorsCount;
  final List<Location> locations;

  Destination({
    required this.destinationId,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.type,
    required this.country,
    required this.city,
    required this.priceRange,
    required this.isVerified,
    required this.isOpen24Hours,
    this.openTime,
    this.closeTime,
    required this.averageRating,
    required this.visitorsCount,
    required this.locations,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      destinationId: json['destinationId'],
      name: json['name'],
      description: json['description'],
      coverImage: json['coverImage'] ?? '',
      type: json['type'],
      country: json['country'],
      city: json['city'],
      priceRange: json['priceRange'],
      isVerified: json['isVerified'],
      isOpen24Hours: json['isOpen24Hours'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      visitorsCount: json['visitorsCount'] ?? 0,
      locations: (json['locations'] as List)
          .map((loc) => Location.fromJson(loc))
          .toList(),
    );
  }
}

class Location {
  final double longitude;
  final double latitude;
  final String address;

  Location({
    required this.longitude,
    required this.latitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longitude: json['longitude'],
      latitude: json['latitude'],
      address: json['address'],
    );
  }
}

class DestinationResponse {
  final int count;
  final List<Destination> destinations;

  DestinationResponse({
    required this.count,
    required this.destinations,
  });

  factory DestinationResponse.fromJson(Map<String, dynamic> json) {
    return DestinationResponse(
      count: json['count'],
      destinations: (json['destinations'] as List)
          .map((dest) => Destination.fromJson(dest))
          .toList(),
    );
  }
}

class DestinationService {
  static const String baseUrl = 'http://tajawul.runasp.net/api';

  Future<DestinationResponse> getDestinations() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/Destination?hour=0&minute=0&year=0&month=0&day=0&dayOfWeek=0'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      return DestinationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load destinations');
    }
  }
}
