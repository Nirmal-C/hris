import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/app_colors.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  String? selectedLeaveType;
  DateTime? startDate;
  DateTime? endDate;
  String? reason;

  final leaveTypes = ['Annual Leave', 'Casual Leave', 'Medical Leave'];
  final leaveDetails = {
    'Entitled': 30,
    'Utilized': 10,
    'Pending': 2,
    'Available': 18,
  };

  final additionalDetails = {
    'Attendance': 200,
    'Leave': 12,
    'No Pay': 3,
    'Working Days': 220,
    'Leave Balance': 18,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Leaves',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: Container(
        width: 300.0, // Adjust the width as needed
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(77, 40, 128, 0.5),
                      Color.fromRGBO(77, 40, 128, 0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/test-bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.event_available,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('Attendance'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/attendance');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.airplanemode_on_sharp,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('Leaves'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/leave');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.list_alt,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('Requests'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/requests');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_pin_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.receipt_long_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('News'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/news_screen');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.receipt_long_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('PaySlips'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/payslips');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('Approval Tasks'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/taskScreen');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group_add_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: Text('My Team'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/employee');
                },
              ),
              Divider(
                thickness: 0.5,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
                contentPadding: EdgeInsets.zero,
                title: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.red),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 8),
              // Text('Leave Chart',
              //     style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.purple)),
              // SizedBox(height: 8),
              // SizedBox(
              //   height: 200,
              //   child: LeaveBar(
              //     leaveData: leaveDetails.values.toList(),
              //   ),
              // ),
              // SizedBox(
              //   height: 4,
              // ),
              // Divider(
              //   thickness: 1,
              // ),
              // SizedBox(height: 4),
              // Leave Details Section
              Text('Leave Details',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background)),
              SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: leaveDetails.entries.map((entry) {
                  return _buildDetailCard(entry.key, entry.value);
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 5),

              Text('Request Leaves',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.flight,
                            size: 25, color: AppColors.background),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Annual',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.beach_access,
                            size: 25, color: AppColors.background),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Casual',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.local_hospital,
                            size: 25, color: AppColors.background),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Medical',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text('Dates',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        startDate = null;
                        endDate = null;
                      });
                    },
                    child: Text('Clear'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != startDate)
                          setState(() {
                            startDate = picked;
                          });
                      },
                      child: Text(startDate == null
                          ? 'Start Date'
                          : '${startDate!.toLocal()}'.split(' ')[0]),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != endDate)
                          setState(() {
                            endDate = picked;
                          });
                      },
                      child: Text(endDate == null
                          ? 'Due Date'
                          : '${endDate!.toLocal()}'.split(' ')[0]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Notify Employee',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Text('Save'),
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

  Widget _buildDetailCard(String title, int value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background),
            ),
            SizedBox(height: 8),
            Text(
              '$value days',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveBar extends StatefulWidget {
  final List<int> leaveData;
  const LeaveBar({super.key, required this.leaveData});

  @override
  State<LeaveBar> createState() => _LeaveBarState();
}

class _LeaveBarState extends State<LeaveBar> {
  late BarData myBarData;

  @override
  void initState() {
    super.initState();
    myBarData = BarData(
      entitledAmount: widget.leaveData[0].toDouble(),
      utilizedAmount: widget.leaveData[1].toDouble(),
      pendingAmount: widget.leaveData[2].toDouble(),
      availableAmount: widget.leaveData[3].toDouble(),
    );
    myBarData.initializeBarData();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 40,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(0),
                      width: 50,
                    )
                  ],
                ))
            .toList(),
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
    );
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double entitledAmount;
  final double utilizedAmount;
  final double pendingAmount;
  final double availableAmount;

  BarData(
      {required this.entitledAmount,
      required this.pendingAmount,
      required this.utilizedAmount,
      required this.availableAmount});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: entitledAmount),
      IndividualBar(x: 1, y: utilizedAmount),
      IndividualBar(x: 2, y: pendingAmount),
      IndividualBar(x: 3, y: availableAmount),
    ];
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: AppColors.background,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  switch (value.toInt()) {
    case 0:
      return SideTitleWidget(
          child: const Text('Entitled', style: style), axisSide: meta.axisSide);
    case 1:
      return SideTitleWidget(
          child: const Text('Utilized', style: style), axisSide: meta.axisSide);
    case 2:
      return SideTitleWidget(
          child: const Text('Pending', style: style), axisSide: meta.axisSide);
    case 3:
      return SideTitleWidget(
          child: const Text('Available', style: style),
          axisSide: meta.axisSide);
    default:
      return SideTitleWidget(
          child: const Text('Unknown', style: style), axisSide: meta.axisSide);
  }
}
