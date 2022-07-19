// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'package:badges/badges.dart';
// import 'package:digirental_shop_app/UI/Screens/single_chat.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// import '../../Utils/Colors.dart';
// import '../../Utils/res.dart';
// import 'ChatSection/messages.dart';
// import 'ChatSection/recent_chat_list.dart';
//
// class Messages extends StatelessWidget {
//   const Messages(
//       {Key? key,
//       menuScreenContext,
//       bool? hideStatus,
//       Null Function()? onScreenHideButtonPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Get.to(RecentChatList());
//                       // Get.to(MessagesView(
//                       //   receiverID: 'Grx6y5zG7znW3kQk3pib',
//                       //   myID: 'IhvZWWIZAmobtNYxxNZl',
//                       //   name: 'sohaib',
//                       // ));
//                     },
//                     child: Text("Messages with Customers",
//                         style: GoogleFonts.roboto(
//                             // fontFamily: 'Gilroy',
//                             fontWeight: FontWeight.w700,
//                             fontSize: 20)),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 height: 50,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: MyAppColors.bgtextfieldcolor,
//                     borderRadius: BorderRadius.circular(13)),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.only(left: 25, top: 15),
//                       hintText: "Search for chat",
//                       hintStyle: GoogleFonts.roboto(
//                           // fontFamily: 'Gilroy',
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(13.0),
//                         child: SvgPicture.asset(
//                           Res.searchicon,
//                           height: 2,
//                           width: 2,
//                         ),
//                       ),
//                       border: InputBorder.none),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             ListView.builder(
//                 shrinkWrap: true,
//                 // scrollDirection: Axis.horizontal,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 9,
//                 itemBuilder: (_, i) {
//                   return Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     child: Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Get.to(SingleChat());
//                           },
//                           child: Container(
//                             height: 50,
//                             width: double.infinity,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CircleAvatar(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: SvgPicture.asset(Res.personicon),
//                                       ),
//                                       backgroundColor: MyAppColors.Lightgrey,
//                                       radius: 28,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Pavel Woods",
//                                             style: GoogleFonts.roboto(
//                                                 // fontFamily: 'Gilroy',
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 15)),
//                                         SizedBox(
//                                           height: 7,
//                                         ),
//                                         Text("See you tomorrow",
//                                             style: GoogleFonts.roboto(
//                                                 // fontFamily: 'Gilroy',
//                                                 color: MyAppColors.Lightgrey,
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 14)),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: Text("16:48",
//                                           style: GoogleFonts.roboto(
//                                               // fontFamily: 'Gilroy',
//                                               color: MyAppColors.appColor,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 15)),
//                                     ),
//                                     SizedBox(
//                                       height: 3,
//                                     ),
//                                     Badge(
//                                       badgeContent: Text("4",
//                                           style: GoogleFonts.roboto(
//                                               // fontFamily: 'Gilroy',
//                                               color: MyAppColors.whitecolor,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 12)),
//                                       badgeColor: MyAppColors.appColor,
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Divider(
//                             height: 3,
//                             color: MyAppColors.Lightgrey,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                       ],
//                     ),
//                   );
//                 })
//           ],
//         ),
//       )),
//     );
//   }
// }
