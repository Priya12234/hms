import 'package:flutter/material.dart';
import 'package:hms/Screens/change_room_page.dart';
import 'package:hms/Screens/drawer_screen.dart';

// Custom AppBar widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onProfilePressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 16,
        right: 16,
      ), // Padding for status bar and content
      decoration: const BoxDecoration(
        color: Color(0xFF33665A), // Background color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and profile button in the header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Open the Drawer
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: onProfilePressed,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Title with "Room Details"
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

void main() {
  runApp(const RoomDetailsPage());
}

class RoomDetailsPage extends StatelessWidget {
  const RoomDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Room Details'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationBar(
          firstName: "your firstname"), // Custom drawer with navigation

      appBar: CustomAppBar(
        title: widget.title,
        onProfilePressed: () {
          // Handle profile button press here
        },
      ),

      body: Column(
        children: [
          // Room details section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: List.generate(10, (index) {
                    return Column(
                      children: [
                        RoomCard(
                          roomNumber: '${101 + index}',
                          building: 'A',
                          capacity: 4,
                          vacancy: (index % 2 == 0) ? 1 : 0,
                          type: 'Ac',
                          status:
                              (index % 2 == 0) ? 'Available' : 'Not Available',
                          onTap: () {
                            if ((index % 2 == 0)) {
                              // Only navigate if status is 'Available'
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeRoomPage(),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final String roomNumber;
  final String building;
  final int capacity;
  final int vacancy;
  final String type;
  final String status;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.roomNumber,
    required this.building,
    required this.capacity,
    required this.vacancy,
    required this.type,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: status == 'Available' ? onTap : null,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column for Bed Image and Room Number
              Column(
                children: [
                  Image.asset(
                    'assets/images/bed.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    roomNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Column for Room Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Building: $building'),
                  Text('Capacity: $capacity'),
                  Text('Vacancy: $vacancy'),
                  Text('Type: $type'),
                ],
              ),
              // Column for Status and Action
              Column(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: status == 'Available' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (status == 'Available') ...[
                    TextButton(
                      onPressed: onTap,
                      child: const Text('Change Room'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
