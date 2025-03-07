import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.brown[100]),
            child: Center(
              child: Image.asset("assets/Isolation_Mode.svg", height: 50),
            ),
          ),
          const DrawerItem(title: "Explore"),
          const DrawerItem(title: "Trips"),
          const DrawerItem(title: "Connect"),
          const DrawerItem(title: "About"),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ActionButton(
                  title: "Sign In",
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                const SizedBox(height: 10),
                ActionButton(
                  title: "Register",
                  isPrimary: true,
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final bool isPrimary;
  final VoidCallback onTap; // Add onTap callback
  const ActionButton({required this.title, this.isPrimary = false, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Use onTap callback
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isPrimary ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isPrimary ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap; // Allows handling tap actions dynamically

  const DrawerItem({required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }
}
