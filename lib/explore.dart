import 'package:flutter/material.dart';
import 'package:tajawul/custom_drawer.dart';

class ExploreScreen extends StatelessWidget {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PlacesGrid(),
          ),
        ),
      ),
    );
  }
}

class PlacesGrid extends StatelessWidget {
  final List<Map<String, String>> places = [
    {
      "imageUrl": "assets/image.png",
      "name": "Space",
      "location": "Alexandria, Egypt",
      "category": "Gym",
      "rating": "4.0",
      "price": "Low"
    },
    {
      "imageUrl": "assets/image.png",
      "name": "Manial Palace Museum",
      "location": "Cairo, Egypt",
      "category": "Museum",
      "rating": "4.7",
      "price": "Medium"
    },
    {
      "imageUrl": "assets/image.png",
      "name": "Nikki Beach Resort & Spa Dubai",
      "location": "Dubai, United Arab Emirates",
      "category": "Hotel",
      "rating": "5.0",
      "price": "High"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: places.map((place) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: CustomCard(
            imageUrl: place["imageUrl"]!,
            name: place["name"]!,
            location: place["location"]!,
            category: place["category"]!,
            rating: place["rating"]!,
            price: place["price"]!,
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
  });

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
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
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
                ),
              ),

              // Favorite Icon in top right
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
                    onPressed: () {
                      // Add favorite logic
                    },
                  ),
                ),
              ),

              // Location Tag in bottom left
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

          // Text Information
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
