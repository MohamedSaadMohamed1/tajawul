import 'package:flutter/material.dart';
import 'package:tajawul/custom_drawer.dart';
import 'package:tajawul/nav_bar.dart';

class DestinationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(), // Add the drawer here
      body: LayoutBuilder(
        builder: (context, constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.6,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Column(
                          children: [
                            const NavBar(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Text(
                              "Verified Destination",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: width * 0.04,
                              ),
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              "Destination Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.08,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellow, size: width * 0.05),
                                Text(
                                  " 5,324 Reviews",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: width * 0.04),
                                ),
                                Spacer(),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border,
                                      size: width * 0.05),
                                  label: Text("Save",
                                      style: TextStyle(fontSize: width * 0.04)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.03),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TourismScreenContent(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TourismScreenContent extends StatelessWidget {
  final List<String> categories = [
    ' Mid-range',
    'Nature & Adventure',
    'Family',
    'Friends',
    'History & Culture',
    'Seasonal Tourism'
  ];

  final List<String> images = [
    'assets/image.png',
    'assets/image.png',
    'assets/image.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0,
            children: categories
                .map((category) => Chip(label: Text(category)))
                .toList(),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 250,
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.asset(images[index], fit: BoxFit.cover);
              },
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoBox(title: '89K', subtitle: 'Followers'),
              InfoBox(title: '30K', subtitle: 'Visitors'),
              InfoBox(title: '250', subtitle: 'Events'),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Destination Description fgldfjkg dflkgjdf lkjg lkjdfg vb '
            'mnkbn ck fldkjmgm odkfgn ofdm dfkndklrbg... ',
            style: TextStyle(color: Colors.grey[700]),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Review'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Upload a Photo'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Edit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String subtitle;

  InfoBox({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
