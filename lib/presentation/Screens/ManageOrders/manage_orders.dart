// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:digirental_shop_app/presentation/Screens/ManageOrders/pending_Orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../../configurations/Utils/Colors.dart';
import '../../../configurations/Utils/res.dart';
import 'active_orders.dart';
import 'cancelled_orders.dart';
import 'completed_orders.dart';

class ManageOrders extends StatelessWidget {
  const ManageOrders(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyAppColors.whitecolor,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text("Manage Orders",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.blackcolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20)),
                SvgPicture.asset(Res.notificationicon)
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: MyAppColors.Lightgrey,
            labelColor: MyAppColors.appColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: MyAppColors.appColor,
            tabs: [
              Tab(
                text: "Pending",
              ),
              Tab(
                text: "Active",
              ),
              Tab(text: "Completed"),
              Tab(
                text: "Cancelled",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PendingOrders(),
            ActiveOrders(),
            CompletedOrders(),
            CancelledOrders(),
          ],
        ),
      ),
    );
  }
}
