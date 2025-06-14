import 'package:flutter/material.dart';
import 'package:tajawul/trip.dart';
import 'package:tajawul/trip_cardex.dart';

import 'custom_drawer.dart';

class ExploreTripsPage extends StatelessWidget {
  const ExploreTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = [
      Trip(
          title: "Aaa",
          duration: "8+ days (Long)",
          countryType: "Same Country",
          priceLevel: PriceLevel.low,
          imageUrl: ""),
      Trip(
          title: "Test Maybe",
          duration: "8+ days (Long)",
          countryType: "Same Country",
          priceLevel: PriceLevel.midRange,
          imageUrl: ""),
      Trip(
          title: "Cccccc",
          duration: "8+ days (Long)",
          countryType: "Different Countries",
          priceLevel: PriceLevel.luxury,
          imageUrl: ""),
    ];

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Explore Trips'),
        backgroundColor: Color(0xff825b4e),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: trips.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return TripCard(trip: trips[index]);
        },
      ),
    );
  }
}
