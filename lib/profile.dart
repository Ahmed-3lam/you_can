// import 'package:flutter/material.dart';
//
// class Profile extends StatelessWidget {
//   const Profile({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         child: AppBar(
//           backgroundColor: Colors.white,
//           title: Text(
//             "Profile",
//             style: TextStyle(
//               fontSize: 35.0,
//               fontWeight: FontWeight.w500,
//               color: Colors.black,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         preferredSize: Size.fromHeight(80),
//       ),
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           SizedBox(
//             height: 30,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Stack(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     backgroundImage: AssetImage("images/profile.jpg"),
//                     radius: 70,
//                   ),
//                   PositionedDirectional(
//                     bottom: 15,
//                     end: 15,
//                     child: Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.camera_alt,
//                         size: 20,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//             child: Text(
//               "User 1",
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           Text("bio information"),
//           SizedBox(
//             height: 30,
//           ),
//           InkWell(
//             onTap: () {},
//             child: Card(
//               shadowColor: Colors.black,
//               elevation: 10,
//               margin: EdgeInsets.all(20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.greenAccent,
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       "Edit Profile",
//                       style: TextStyle(
//                           fontSize: 30.0, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       size: 30,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {},
//             child: Card(
//               shadowColor: Colors.black,
//               elevation: 10,
//               margin: EdgeInsets.all(20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.greenAccent,
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       "My Feed",
//                       style: TextStyle(
//                           fontSize: 30.0, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       size: 30,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {},
//             child: Card(
//               shadowColor: Colors.black,
//               elevation: 10,
//               margin: EdgeInsets.all(20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.greenAccent,
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       "My Saved",
//                       style: TextStyle(
//                           fontSize: 30.0, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       size: 30,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {},
//             child: Card(
//               shadowColor: Colors.black,
//               elevation: 10,
//               margin: EdgeInsets.all(20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               color: Colors.greenAccent,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       "Log Out",
//                       style: TextStyle(
//                           fontSize: 30.0, fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
