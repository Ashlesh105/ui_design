import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ui_design/pages/qr_scanner.dart';
import 'package:ui_design/pages/test_history.dart';
import '../utility/permission_utility.dart';
import '../widgets/custome_pie_chart.dart';
import '../widgets/custome_tile.dart';
import 'add_farmer.dart';

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  bool isDeskTop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;
  late double height, width, size;
  int completedTests = 0; // Initial completed tests
  int pendingTests = 0; // Initial pending tests
  final TextEditingController completedController = TextEditingController(
    text: '0',
  );
  final TextEditingController pendingController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    completedController.dispose();
    pendingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    size = height + width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                height: height * 0.23,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ui_bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/icon.png',
                          width: width * (isDeskTop(context) ? 0.4 : 0.4),
                          height: height * 0.1,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.notifications_none),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: width * 0.02),
                            CircleAvatar(
                              radius:
                                  !isDeskTop(context)
                                      ? size * 0.021
                                      : size * 0.03,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.04),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Hi, Ashlesh Kini',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Hers\'s an overview of your test progress so far.',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black)
                    // ),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    // padding: EdgeInsets.only(right:),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Tests Registered',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '${completedTests + pendingTests}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromRGBO(5, 92, 208, 1.0),
                                  size: height * 0.025,
                                ),
                                SizedBox(width: width * 0.005),
                                Text(
                                  'Completed Test -',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 50, // Adjust width as needed
                                  child: TextField(
                                    controller: completedController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          completedTests = 0;
                                        } else {
                                          completedTests =
                                              int.tryParse(value) ??
                                              completedTests;
                                        }
                                        completedController.text =
                                            completedTests.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: completedTests.toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromRGBO(137, 187, 253, 1.0),
                                  size: height * 0.025,
                                ),
                                SizedBox(width: width * 0.005),
                                Text(
                                  'Pending Test -',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: TextField(
                                    controller: pendingController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          pendingTests = 0;
                                        } else {
                                          pendingTests =
                                              int.tryParse(value) ??
                                              pendingTests;
                                        }
                                        pendingController.text =
                                            pendingTests.toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: pendingTests.toString(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.2,
                          width: width * 0.38,
                          child: AnimatedRoundedPieChart(
                            pendingTests: pendingTests.toDouble(),
                            completedTests: completedTests.toDouble(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black),
                      image: DecorationImage(
                        image: AssetImage('assets/images/ad.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: height * 0.15,
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: SearchBar(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 20),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(101, 99, 99, 0.25882352941176473),
                      ),
                      elevation: WidgetStatePropertyAll(0.0),
                      leading: Icon(Icons.search),
                      hintText: 'Search Farmer by Phone number',
                      hintStyle: WidgetStatePropertyAll(
                        TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddFarmer(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_add_alt_outlined,
                                color: Colors.blue,
                                size: 30,
                              ),
                              Text(
                                'Add \n Farmer',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await requestPermission(
                            permission: Permission.camera,
                          )) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QrScanner(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Camera Permission Denied'),
                                duration: Duration(milliseconds: 500),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                color: Colors.blue,
                                size: 30,
                              ),
                              Text(
                                'Scan \n QR',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestHistory(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Icon(Icons.history, color: Colors.blue, size: 30),
                              Text(
                                'Test \n History',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recent Tests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: DefaultTabController(
                      length: 2,
                      child: SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            Container(
                              width: width,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(
                                  101,
                                  99,
                                  99,
                                  0.25882352941176473,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                indicator: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                tabs: [
                                  Container(
                                    height: height * 0.04,
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(color: Colors.white),
                                    ),
                                    child: Tab(text: 'New'),
                                  ),
                                  Container(
                                    height: height * 0.04,
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(color: Colors.white),
                                    ),
                                    child: Tab(text: 'Completed'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height * 0.04),
                              height: height * 0.76,
                              width: width,
                              child: TabBarView(
                                children: [
                                  Column(
                                    children: [
                                      CustomTile(
                                        title: 'Ishwar Bhootra',
                                        subTitle: 'PY0520026838288',
                                      ),
                                      CustomTile(
                                        title: 'Rohan Ramanathan',
                                        subTitle: 'PI05200216515145',
                                      ),
                                      CustomTile(
                                        title: 'Ishwar Bhootra',
                                        subTitle: 'PI05200216515145',
                                      ),
                                      CustomTile(
                                        title: 'Ishwar Bhootra',
                                        subTitle: 'PI05200216515145',
                                      ),
                                      CustomTile(
                                        title: 'Ishwar Bhootra',
                                        subTitle: 'PI05200216515145',
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CustomTile(
                                        title: 'Ishwar Bhootra',
                                        subTitle: 'PY0520026838288',
                                      ),
                                      CustomTile(
                                        title: 'Rohan Ramanathan',
                                        subTitle: 'PI05200216515145',
                                      ),
                                      CustomTile(
                                        title: 'Ishwar Bhootra',
                                        subTitle: 'PI05200216515145',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
