import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:untitled/app_bar.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime today = DateTime.now();

  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _leaveTimeController = TextEditingController();

  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _eventController.dispose();
    _startTimeController.dispose();
    _leaveTimeController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDate)) {
      setState(() {
        _selectedDay = selectedDate;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDate);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  Future<void> _showAddAttendanceBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Attendance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _startTimeController,
                  decoration: InputDecoration(
                    labelText: "Starting Time",
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      _startTimeController.text = pickedTime.format(context);
                    }
                  },
                ),
                TextField(
                  controller: _leaveTimeController,
                  decoration: InputDecoration(
                    labelText: "Leaving Time",
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      _leaveTimeController.text = pickedTime.format(context);
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14.0),
                        backgroundColor: Color(0xff4d2880),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_startTimeController.text.isNotEmpty &&
                            _leaveTimeController.text.isNotEmpty) {
                          setState(() {
                            events[_selectedDay!] = [
                              Event(
                                _startTimeController.text,
                                _leaveTimeController.text,
                              )
                            ];
                          });

                          _startTimeController.clear();
                          _leaveTimeController.clear();
                          Navigator.of(context).pop();
                          _selectedEvents.value = _getEventsForDay(_selectedDay!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter Start and Leaving times"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Attendance',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: Drawer(
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
              contentPadding: EdgeInsets.zero, // Remove default padding
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4d2880),
        onPressed: () {
          _showAddAttendanceBottomSheet(context);
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Column(
        children: [
          Container(
            child: TableCalendar(
              rowHeight: 45,
              headerStyle: HeaderStyle(
                titleCentered: true,
              ),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

              firstDay: DateTime.utc(2023, 01, 01),
              lastDay: DateTime.utc(3030, 12, 31),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
              ),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          SizedBox(height: 10.0),
          Divider(thickness: 1,),
          // Text(
          //   'Selected Date = ' + today.toString().split(" ")[0],
          //   style: TextStyle(fontSize: 16),
          // ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (Context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xff4d2880),
                        ),
                      ),
                      child: ListTile(
                        onTap: () => print(''),
                        title: Text(
                          'Date: ${_selectedDay?.day}/${_selectedDay?.month}/${_selectedDay?.year}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                           fontSize: 20,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(

                                  children: [
                                    Text(
                                      'Start: ${value[index].startTime}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Leave: ${value[index].leaveTime}', style: TextStyle(fontSize: 18),),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    IconButton(onPressed: () {}, icon: Icon(Icons.check, color: Colors.green, size: 35.0,),),
                                    ],
                                ),
                                Column(
                                  children: [
                                    IconButton(onPressed: () {}, icon: Icon(Icons.close, color: Colors.red,size: 35.0,),)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Event {

  final String startTime;
  final String leaveTime;

  Event(this.startTime, this.leaveTime);
}