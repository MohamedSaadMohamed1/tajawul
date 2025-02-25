import 'package:flutter/material.dart';
import 'package:tajawul/custom_search_bar.dart';
import 'package:tajawul/nav_bar.dart';
import 'package:tajawul/popular_trips_section.dart';
import 'package:tajawul/top_picks.dart';
import 'package:tajawul/trip_ai_section.dart';

import 'custom_drawer.dart';

class TajawalHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(color: Color(0xff141111)), // Set background to white
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screenHeight *
                          .5, // Set a fixed height or use constraints
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/image.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight *
                          .5, // Same height as the image container
                      color: Colors.black.withOpacity(0.5), // Dark overlay
                    ),
                    Positioned(
                      child: Column(
                        children: [
                          const NavBar(),
                          SizedBox(height: screenHeight * 0.03),
                          CustomSearchBar(),
                          SizedBox(height: screenHeight * 0.08),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      PopularTripsSection(),
                      SizedBox(height: screenHeight * 0.02),
                      TripAISection(),
                      // AdditionalContent(),
                      TopPicks()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
