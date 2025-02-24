
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
                const ActionButton(title: "Sign In"),
                const SizedBox(height: 10),
                const ActionButton(title: "Register", isPrimary: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
