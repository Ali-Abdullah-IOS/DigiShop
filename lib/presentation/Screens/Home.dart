// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';


import '../../Infrastructure/Models/order_model.dart';
import '../../Infrastructure/Models/product_Model.dart';
import '../../Infrastructure/Models/user_model.dart';
import '../../Infrastructure/Services/order_services.dart';
import '../../Infrastructure/Services/product_services.dart';
import '../../Infrastructure/Services/user_services.dart';
import '../../configurations/Utils/Colors.dart';
import '../../configurations/Utils/res.dart';
import 'AuthSection/my_profile.dart';

class Home extends StatefulWidget {
  const Home(
      {Key? key,
      menuScreenContext,
      bool? hideStatus,
      Null Function()? onScreenHideButtonPressed})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Color leftBarColor = Colors.green;

  final Color rightBarColor = Color(0xffF89673);
  final double width = 10;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  OrderServices orderServices = OrderServices();
  ProductServices productServices = ProductServices();
  UserServices userServices = UserServices();

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) _initFcm();
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  Future<void> _initFcm() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseMessaging.instance.subscribeToTopic('USERS');
    FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance.collection('deviceTokens').doc(uid).set(
        {
          'deviceTokens': token,
        },
      );
    });
  }

  String updateShopStatus(num orderLength, num totalEarning) {
    String level = 'New Shop';

    if ((orderLength >= 10 && orderLength < 20) &&
        (totalEarning >= 400 && totalEarning < 800)) {
      userServices
          .updateShopStatustoLeveOne(FirebaseAuth.instance.currentUser!.uid);
      return 'Level one Shop';
    } else if ((orderLength >= 20 && orderLength < 30) &&
        (totalEarning >= 800 && totalEarning < 1200)) {
      userServices
          .updateShopStatustoLevelTwo(FirebaseAuth.instance.currentUser!.uid);
      return 'Level two Shop';
    } else if ((orderLength >= 30) && (totalEarning >= 1200)) {
      userServices
          .updateShopStatustoTopRated(FirebaseAuth.instance.currentUser!.uid);
      return 'Top Rated Shop';
    } else {
      userServices
          .updateShopStatustoNewShop(FirebaseAuth.instance.currentUser!.uid);
      return level;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: userServices
            .fetchUserRecord(FirebaseAuth.instance.currentUser!.uid),
        initialData: UserModel(),
        builder: (context, child) {
          UserModel model = context.watch<UserModel>();

          return (Scaffold(
              backgroundColor: MyAppColors.blackcolor,
              appBar: AppBar(
                elevation: 0,
                leadingWidth: 0,
                backgroundColor: MyAppColors.whitecolor,
                centerTitle: false,
                title: Text(
                  model.fullName.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 8, top: 5),
                    child: InkWell(
                      onTap: () {
                        Get.to(MyProfileScreen());
                      },
                      child: Container(
                        child: Stack(
                          children: [
                            model.userImage == null
                                ? CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(Res.personicon),
                                  )
                                : CachedNetworkImage(
                                    height: 45,
                                    width: 45,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          width: 45.0,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                    imageUrl: model.userImage.toString(),
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            SpinKitWave(
                                                color: MyAppColors.appColor,
                                                size: 30,
                                                type: SpinKitWaveType.start),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: StreamProvider.value(
                    value: orderServices.streamMyCompletedOrders(
                        FirebaseAuth.instance.currentUser!.uid),
                    initialData: [OrderModel()],
                    builder: (context, child) {
                      List<OrderModel> _orderList =
                          context.watch<List<OrderModel>>();
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            // height: Get.height * .45,
                            width: double.infinity,
                            color: Colors.black,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),

                                rowTxt(
                                  leftTxt: 'Shop level',
                                  rightTxt: updateShopStatus(
                                    _orderList.length,
                                    model.totalEarning!.toDouble(),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                ExpansionTile(
                                  trailing: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: MyAppColors.whitecolor,
                                  ),
                                  title: const Text(
                                    'Reach Your next level',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.white),
                                  ),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    rowTxt(
                                        leftTxt: 'Order',
                                        leftTxtSize: 16,
                                        rightTxt: _orderList.length.toString() +
                                            ' / 10',
                                        rightTxtClr: MyAppColors.appColor),
                                    SizedBox(
                                        width: Get.width * .56,
                                        child: const Text(
                                          'Recievce and complete at least 10 orders (all time)',
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        )),
                                    const SizedBox(height: 5),
                                    const Divider(color: Colors.grey),
                                    rowTxt(
                                        leftTxt: 'Earnings',
                                        leftTxtSize: 15,
                                        rightTxt: "\$" +
                                            model.totalEarning.toString() +
                                            "  / \$400",
                                        rightTxtClr: MyAppColors.appColor),
                                    SizedBox(
                                        width: Get.width * .56,
                                        child: const Text(
                                          'Earn at least \$400 from completed orders (all time)',
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        )),
                                    const SizedBox(height: 10),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Last 7 days',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 170,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: BarChart(
                                      BarChartData(
                                        maxY: 35,
                                        barTouchData: BarTouchData(
                                            touchTooltipData:
                                                BarTouchTooltipData(
                                              tooltipBgColor: Colors.grey,
                                              getTooltipItem:
                                                  (_a, _b, _c, _d) => null,
                                            ),
                                            touchCallback:
                                                (FlTouchEvent event, response) {
                                              if (response == null ||
                                                  response.spot == null) {
                                                setState(() {
                                                  touchedGroupIndex = -1;
                                                  showingBarGroups =
                                                      List.of(rawBarGroups);
                                                });
                                                return;
                                              }

                                              touchedGroupIndex = response
                                                  .spot!.touchedBarGroupIndex;

                                              setState(() {
                                                if (!event
                                                    .isInterestedForInteractions) {
                                                  touchedGroupIndex = -1;
                                                  showingBarGroups =
                                                      List.of(rawBarGroups);
                                                  return;
                                                }
                                                showingBarGroups =
                                                    List.of(rawBarGroups);
                                                if (touchedGroupIndex != -1) {
                                                  var sum = 0.0;
                                                  for (var rod
                                                      in showingBarGroups[
                                                              touchedGroupIndex]
                                                          .barRods) {
                                                    sum += rod.y;
                                                  }
                                                  final avg = sum /
                                                      showingBarGroups[
                                                              touchedGroupIndex]
                                                          .barRods
                                                          .length;

                                                  showingBarGroups[
                                                          touchedGroupIndex] =
                                                      showingBarGroups[
                                                              touchedGroupIndex]
                                                          .copyWith(
                                                    barRods: showingBarGroups[
                                                            touchedGroupIndex]
                                                        .barRods
                                                        .map((rod) {
                                                      return rod.copyWith(
                                                          y: avg);
                                                    }).toList(),
                                                  );
                                                }
                                              });
                                            }),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          rightTitles:
                                              SideTitles(showTitles: false),
                                          topTitles:
                                              SideTitles(showTitles: false),
                                          bottomTitles: SideTitles(
                                            showTitles: true,
                                            getTextStyles: (context, value) =>
                                                const TextStyle(
                                                    color: Colors.white54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                            margin: 10,
                                            getTitles: (double value) {
                                              switch (value.toInt()) {
                                                case 0:
                                                  return 'Mn';

                                                case 1:
                                                  return 'Te';
                                                case 2:
                                                  return 'Wd';
                                                case 3:
                                                  return 'Tu';
                                                case 4:
                                                  return 'Fr';
                                                case 5:
                                                  return 'St';
                                                case 6:
                                                  return 'Sn';
                                                default:
                                                  return '';
                                              }
                                            },
                                          ),
                                          leftTitles: SideTitles(
                                            showTitles: true,
                                            getTextStyles: (context, value) =>
                                                const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                            margin: 8,
                                            reservedSize: 28,
                                            interval: 1,
                                            getTitles: (value) {
                                              if (value == 0) {
                                                return '1K';
                                              } else if (value == 10) {
                                                return '2K';
                                              } else if (value == 10) {
                                                return '3K';
                                              } else if (value == 10) {
                                                return '4K';
                                              } else if (value == 19) {
                                                return '5K';
                                              } else {
                                                return '';
                                              }
                                            },
                                          ),
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        barGroups: showingBarGroups,
                                        gridData: FlGridData(show: false),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamProvider.value(
                                        value: userServices.fetchUserRecord(
                                            FirebaseAuth
                                                .instance.currentUser!.uid),
                                        initialData: UserModel(),
                                        builder: (context, child) {
                                          UserModel model =
                                              context.watch<UserModel>();
                                          return Container(
                                            height: 100,
                                            width: 100,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Balance',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    model.totalBalance
                                                            .toString() +
                                                        ' \$',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                    StreamProvider.value(
                                        value: orderServices
                                            .streamMyCompletedOrders(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid),
                                        initialData: [OrderModel()],
                                        builder: (context, child) {
                                          List<OrderModel> _orderList =
                                              context.watch<List<OrderModel>>();

                                          return Container(
                                            height: 100,
                                            width: 100,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Orders',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    'Completed',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _orderList.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                    StreamProvider.value(
                                        value: orderServices
                                            .streamMyProcessedOrders(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid),
                                        initialData: [OrderModel()],
                                        builder: (context, child) {
                                          List<OrderModel> _orderList =
                                              context.watch<List<OrderModel>>();

                                          return Container(
                                            height: 100,
                                            width: 100,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Orders',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    'Active',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _orderList.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamProvider.value(
                                        value: orderServices
                                            .streamMyCancelledOrders(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid),
                                        initialData: [OrderModel()],
                                        builder: (context, child) {
                                          List<OrderModel> _orderList =
                                              context.watch<List<OrderModel>>();

                                          return Container(
                                            height: 100,
                                            width: 100,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Orders',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    'Cancelled',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _orderList.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                    StreamProvider.value(
                                        value: productServices
                                            .streamOnlyProducts(FirebaseAuth
                                                .instance.currentUser!.uid),
                                        initialData: [ProductModel()],
                                        builder: (context, child) {
                                          List<ProductModel> _productList =
                                              context
                                                  .watch<List<ProductModel>>();
                                          return Container(

                                            height: 100,
                                            width: 100,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Products',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    'Avaliable',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _productList.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                    StreamProvider.value(
                                        value: orderServices
                                            .streamMyPendingOrders(FirebaseAuth
                                                .instance.currentUser!.uid),
                                        initialData: [OrderModel()],
                                        builder: (context, child) {
                                          List<OrderModel> _orderList =
                                              context.watch<List<OrderModel>>();

                                          return Container(
                                            height: 100,
                                            width: 100,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Orders',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    'Pending',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    _orderList.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       flex: 2,
                                //       child: Container(
                                //         child: circularProgressWithTitle(
                                //             filledPercentText: 97,
                                //             titleText: 'Response \n Rate'),
                                //       ),
                                //     ),
                                //     Expanded(
                                //       flex: 2,
                                //       child: circularProgressWithTitle(
                                //           filledPercentText: 75,
                                //           titleText: 'Order \n completion'),
                                //     ),
                                //     Expanded(
                                //       flex: 2,
                                //       child: circularProgressWithTitle(
                                //           filledPercentText: 75,
                                //           titleText: 'On-time \n delivery'),
                                //     ),
                                //     Expanded(
                                //       flex: 2,
                                //       child: circularProgressWithTitle(
                                //           filledPercentText: 75,
                                //           titleText: 'Positive \n Rating'),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              )));
        });
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}

Widget columnTxt(
    {required String upperTxt, lowerTxt, Color lowerTxtClr = Colors.black}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        upperTxt,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      const SizedBox(height: 5),
      Text(
        '\$$lowerTxt',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: lowerTxtClr),
      ),
    ],
  );
}

Widget rowTxt(
    {required String leftTxt,
    rightTxt,
    Color rightTxtClr = Colors.white,
    Color leftTxtClr = Colors.white,
    double leftTxtSize = 16}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        leftTxt,
        style: TextStyle(
            fontSize: leftTxtSize,
            color: leftTxtClr,
            fontWeight: FontWeight.w500),
      ),
      Text(
        rightTxt,
        style: TextStyle(
            fontSize: 14, color: rightTxtClr, fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget circularProgressWithTitle({required int filledPercentText, titleText}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircularPercentIndicator(
        radius: 33.0,
        animation: true,
        animationDuration: 1200,
        lineWidth: 3.0,
        percent: (filledPercentText / 100),
        center: Text(
          "$filledPercentText %",
          style: TextStyle(
              color: MyAppColors.whitecolor,
              fontWeight: FontWeight.w500,
              fontSize: 15.0),
        ),
        circularStrokeCap: CircularStrokeCap.butt,
        backgroundColor: Colors.white24,
        progressColor: MyAppColors.appColor,
      ),
      const SizedBox(height: 12),
      SizedBox(
        width: Get.width * .3,
        child: Text(
          titleText,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyAppColors.whitecolor,
              fontWeight: FontWeight.w400,
              fontSize: 13.0),
        ),
      ),
    ],
  );
}
