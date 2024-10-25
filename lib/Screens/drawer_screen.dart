import 'package:flutter/material.dart';
import 'package:hms/Screens/Login_screen.dart';
import 'package:hms/Screens/change_room_page.dart';
import 'package:hms/Screens/complaint_screen.dart';
import 'package:hms/Screens/contact_Screen.dart';
import 'package:hms/Screens/exitpass_screen.dart';
import 'package:hms/Screens/fee_details_screen.dart';
import 'package:hms/Screens/home_screen.dart';
import 'package:hms/Screens/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final String firstName; // Declare the firstName variable

  const CustomDrawer(
      {super.key, required this.firstName}); // Add firstName in the constructor

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF33665A), // Green background for the drawer
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(firstName), // Use firstName variable here
              accountEmail: const Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey.shade800,
                ),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF33665A), // Header color
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Dashboard',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Dashboard screen directly
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              firstName: firstName,
                            )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title:
                  const Text('Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Profile screen directly
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              firstName: firstName,
                            )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.white),
              title: const Text('Menu', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Menu screen directly
                // Navigator.push(context, MaterialPageRoute(builder: (context) => me()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem, color: Colors.white),
              title:
                  const Text('Complain', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Complain screen directly
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ComplaintMenuPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money_outlined, color: Colors.white),
              title: const Text('Fees Details',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Request & Replies screen directly
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FeeDetails()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.white),
              title: const Text('Request for change room',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Request & Replies screen directly
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ChangeRoomPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.white),
              title: const Text('Request for exit pass',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Request & Replies screen directly
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ExitPassPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.white),
              title:
                  const Text('Contact', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to the Contact screen directly
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactPage()));
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Perform logout action and navigate to the login screen directly
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// this is with the simple white background and divider in between
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         accountName: Text('Username'),
      //         accountEmail: Text('user@example.com'),
      //         currentAccountPicture: CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Icon(
      //             Icons.person,
      //             size: 50,
      //             color: Colors.grey.shade800,
      //           ),
      //         ),
      //         decoration: BoxDecoration(
      //           color: Color(0xFF33665A),
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text('Dashboard'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       Divider(
      //         color: Color(0xFF33665A), // Green divider color
      //         thickness: 1, // Thickness of the divider
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.person),
      //         title: Text('Profile'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       Divider(
      //         color: Color(0xFF33665A),
      //         thickness: 1,
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.menu_book),
      //         title: Text('Menu'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       Divider(
      //         color: Color(0xFF33665A),
      //         thickness: 1,
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.report_problem),
      //         title: Text('Complain'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       Divider(
      //         color: Color(0xFF33665A),
      //         thickness: 1,
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.chat),
      //         title: Text('Request & Replies'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       Divider(
      //         color: Color(0xFF33665A),
      //         thickness: 1,
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.contact_mail),
      //         title: Text('Contact'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       Spacer(),
      //       Divider(
      //         color: Color(0xFF33665A),
      //         thickness: 1,
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.logout),
      //         title: Text('Logout'),
      //         onTap: () {
      //           // Add logout logic
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      // // this is with the simple white background
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         accountName: Text('Username'),
      //         accountEmail: Text('user@example.com'),
      //         currentAccountPicture: CircleAvatar(
      //           backgroundColor: Colors.white,
      //           child: Icon(
      //             Icons.person,
      //             size: 50,
      //             color: Colors.grey.shade800,
      //           ),
      //         ),
      //         decoration: BoxDecoration(
      //           color: Color(0xFF33665A),
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text('Dashboard'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.person),
      //         title: Text('Profile'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.menu_book),
      //         title: Text('Menu'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.report_problem),
      //         title: Text('Complain'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.chat),
      //         title: Text('Request & Replies'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.contact_mail),
      //         title: Text('Contact'),
      //         onTap: () {
      //           // Add navigation or other logic
      //         },
      //       ),
      //       Spacer(),
      //       ListTile(
      //         leading: Icon(Icons.logout),
      //         title: Text('Logout'),
      //         onTap: () {
      //           // Add logout logic
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      // // with the green backgroud
      // drawer: Drawer(
      //   child: Container(
      //     color: const Color(0xFF33665A), // Green background for the drawer
      //     child: Column(
      //       children: [
      //         UserAccountsDrawerHeader(
      //           accountName: Text('Username'),
      //           accountEmail: Text('user@example.com'),
      //           currentAccountPicture: CircleAvatar(
      //             backgroundColor: Colors.white,
      //             child: Icon(
      //               Icons.person,
      //               size: 50,
      //               color: Colors.grey.shade800,
      //             ),
      //           ),
      //           decoration: BoxDecoration(
      //             color: Color(0xFF33665A), // Header color
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.home, color: Colors.white),
      //           title: Text('Dashboard', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.person, color: Colors.white),
      //           title: Text('Profile', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.menu_book, color: Colors.white),
      //           title: Text('Menu', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.report_problem, color: Colors.white),
      //           title: Text('Complain', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.chat, color: Colors.white),
      //           title: Text('Request & Replies',
      //               style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.contact_mail, color: Colors.white),
      //           title: Text('Contact', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         Spacer(),
      //         ListTile(
      //           leading: Icon(Icons.logout, color: Colors.white),
      //           title: Text('Logout', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add logout logic
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      //   // divider with green background in this drawer
      // drawer: Drawer(
      //   child: Container(
      //     color: const Color(0xFF33665A), // Green background for the drawer
      //     child: Column(
      //       children: [
      //         UserAccountsDrawerHeader(
      //           accountName: Text('Username'),
      //           accountEmail: Text('user@example.com'),
      //           currentAccountPicture: CircleAvatar(
      //             backgroundColor: Colors.white,
      //             child: Icon(
      //               Icons.person,
      //               size: 50,
      //               color: Colors.grey.shade800,
      //             ),
      //           ),
      //           decoration: BoxDecoration(
      //             color: Color(0xFF33665A), // Header color
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.home, color: Colors.white),
      //           title: Text('Dashboard', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         Divider(color: Colors.white), // Divider between items
      //         ListTile(
      //           leading: Icon(Icons.person, color: Colors.white),
      //           title: Text('Profile', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         Divider(color: Colors.white), // Divider between items
      //         ListTile(
      //           leading: Icon(Icons.menu_book, color: Colors.white),
      //           title: Text('Menu', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         Divider(color: Colors.white), // Divider between items
      //         ListTile(
      //           leading: Icon(Icons.report_problem, color: Colors.white),
      //           title: Text('Complain', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         Divider(color: Colors.white), // Divider between items
      //         ListTile(
      //           leading: Icon(Icons.chat, color: Colors.white),
      //           title: Text('Request & Replies',
      //               style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         Divider(color: Colors.white), // Divider between items
      //         ListTile(
      //           leading: Icon(Icons.contact_mail, color: Colors.white),
      //           title: Text('Contact', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add navigation or other logic
      //           },
      //         ),
      //         Spacer(),
      //         Divider(color: Colors.white), // Divider before logout
      //         ListTile(
      //           leading: Icon(Icons.logout, color: Colors.white),
      //           title: Text('Logout', style: TextStyle(color: Colors.white)),
      //           onTap: () {
      //             // Add logout logic
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),