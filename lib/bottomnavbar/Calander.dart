import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() =>
      _CalendarPageState();
}

class _CalendarPageState
    extends State<CalendarPage> {

  DateTime today = DateTime.now();

  DateTime selectedDay =
  DateTime.now();

  final Map<DateTime,
      List<Map<String, dynamic>>>
  meetings = {

    DateTime.utc(2026, 5, 18): [

      {
        "title": "UI Team Meeting",
        "time": "10:00 AM",
        "members": "6 Members",
      },

      {
        "title": "Acote Workspace",
        "time": "2:00 PM",
        "members": "12 Members",
      },
    ],

    DateTime.utc(2026, 5, 20): [

      {
        "title": "Development Sprint",
        "time": "11:30 AM",
        "members": "8 Members",
      },
    ],
  };

  List<Map<String, dynamic>>
  getMeetingsForDay(DateTime day) {

    return meetings[
    DateTime.utc(
      day.year,
      day.month,
      day.day,
    )
    ] ??
        [];
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    final height =
        MediaQuery.of(context).size.height;

    final selectedMeetings =
    getMeetingsForDay(selectedDay);

    return Scaffold(

      backgroundColor:
      const Color(0xFF0B0618),

      body: SafeArea(

        child: Stack(
          children: [

            /// BACKGROUND GLOW
            Positioned(
              top: -120,
              left: -80,
              child: glowCircle(
                250,
                const Color(
                  0xFFB026FF,
                ),
              ),
            ),

            Positioned(
              bottom: -120,
              right: -80,
              child: glowCircle(
                220,
                const Color(
                  0xFF00E5FF,
                ),
              ),
            ),

            /// MAIN BODY
            SingleChildScrollView(

              physics:
              const BouncingScrollPhysics(),

              child: Padding(

                padding:
                EdgeInsets.symmetric(

                  horizontal:
                  width * 0.05,

                  vertical:
                  height * 0.02,
                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    /// TOP BAR
                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        topButton(
                          Icons.arrow_back_ios_new,
                              () {
                            Navigator.pop(
                              context,
                            );
                          },
                        ),

                        Text(

                          "Calendar",

                          style: TextStyle(

                            color:
                            Colors.white,

                            fontWeight:
                            FontWeight.bold,

                            fontSize:
                            width * 0.06,
                          ),
                        ),

                        topButton(
                          Icons.notifications_none,
                              () {},
                        ),
                      ],
                    ),

                    SizedBox(
                      height:
                      height * 0.03,
                    ),

                    /// CURRENT DATE
                    Text(

                      "Today's Date",

                      style: TextStyle(

                        color:
                        Colors.white60,

                        fontSize:
                        width * 0.04,
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.01,
                    ),

                    Text(

                      "${today.day}/${today.month}/${today.year}",

                      style: TextStyle(

                        color:
                        Colors.white,

                        fontWeight:
                        FontWeight.bold,

                        fontSize:
                        width * 0.08,
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.03,
                    ),

                    /// CALENDAR
                    Container(

                      padding:
                      const EdgeInsets.all(
                        16,
                      ),

                      decoration: BoxDecoration(

                        borderRadius:
                        BorderRadius.circular(
                          28,
                        ),

                        color:
                        Colors.white
                            .withOpacity(
                          0.07,
                        ),

                        border: Border.all(

                          color:
                          Colors.white
                              .withOpacity(
                            0.08,
                          ),
                        ),
                      ),

                      child: TableCalendar(

                        focusedDay:
                        selectedDay,

                        firstDay:
                        DateTime.utc(
                          2020,
                          1,
                          1,
                        ),

                        lastDay:
                        DateTime.utc(
                          2035,
                          12,
                          31,
                        ),

                        selectedDayPredicate:
                            (day) {

                          return isSameDay(
                            selectedDay,
                            day,
                          );
                        },

                        onDaySelected:
                            (
                            selected,
                            focused,
                            ) {

                          setState(() {

                            selectedDay =
                                selected;
                          });
                        },

                        eventLoader:
                            (day) {

                          return getMeetingsForDay(
                            day,
                          );
                        },

                        headerStyle:
                        const HeaderStyle(

                          formatButtonVisible:
                          false,

                          titleCentered:
                          true,

                          titleTextStyle:
                          TextStyle(

                            color:
                            Colors.white,

                            fontWeight:
                            FontWeight.bold,

                            fontSize: 18,
                          ),

                          leftChevronIcon:
                          Icon(

                            Icons.chevron_left,

                            color:
                            Colors.white,
                          ),

                          rightChevronIcon:
                          Icon(

                            Icons.chevron_right,

                            color:
                            Colors.white,
                          ),
                        ),

                        daysOfWeekStyle:
                        const DaysOfWeekStyle(

                          weekdayStyle:
                          TextStyle(
                            color:
                            Colors.white70,
                          ),

                          weekendStyle:
                          TextStyle(
                            color:
                            Colors.white70,
                          ),
                        ),

                        calendarStyle:
                        CalendarStyle(

                          defaultTextStyle:
                          const TextStyle(
                            color:
                            Colors.white,
                          ),

                          weekendTextStyle:
                          const TextStyle(
                            color:
                            Colors.white,
                          ),

                          outsideTextStyle:
                          TextStyle(

                            color:
                            Colors.white
                                .withOpacity(
                              0.3,
                            ),
                          ),

                          todayDecoration:
                          const BoxDecoration(

                            color:
                            Color(0xFFB026FF),

                            shape:
                            BoxShape.circle,
                          ),

                          selectedDecoration:
                          const BoxDecoration(

                            color:
                            Color(0xFF00E5FF),

                            shape:
                            BoxShape.circle,
                          ),

                          markerDecoration:
                          const BoxDecoration(

                            color:
                            Colors.pinkAccent,

                            shape:
                            BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.04,
                    ),

                    /// MEETING TITLE
                    Text(

                      "Meetings",

                      style: TextStyle(

                        color:
                        Colors.white,

                        fontWeight:
                        FontWeight.bold,

                        fontSize:
                        width * 0.065,
                      ),
                    ),

                    SizedBox(
                      height:
                      height * 0.02,
                    ),

                    /// NO MEETING
                    if (selectedMeetings
                        .isEmpty)

                      Center(

                        child: Padding(

                          padding:
                          EdgeInsets.only(
                            top:
                            height * 0.08,
                          ),

                          child: Column(
                            children: [

                              Icon(

                                Icons
                                    .calendar_month,

                                color:
                                Colors.white24,

                                size: 80,
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              const Text(

                                "No Meetings Found",

                                style: TextStyle(

                                  color:
                                  Colors.white70,

                                  fontSize: 18,

                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    /// MEETING LIST
                    ...selectedMeetings.map(
                          (meeting) {

                        return Padding(

                          padding:
                          const EdgeInsets.only(
                            bottom: 18,
                          ),

                          child: meetingCard(

                            meeting["title"],

                            meeting["time"],

                            meeting["members"],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// MEETING CARD
  Widget meetingCard(
      String title,
      String time,
      String members,
      ) {

    return Container(

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(

        borderRadius:
        BorderRadius.circular(28),

        gradient:
        LinearGradient(

          colors: [

            Colors.white.withOpacity(
              0.10,
            ),

            Colors.white.withOpacity(
              0.04,
            ),
          ],
        ),

        border: Border.all(

          color:
          Colors.white.withOpacity(
            0.08,
          ),
        ),
      ),

      child: Row(
        children: [

          Container(

            height: 60,
            width: 60,

            decoration: const BoxDecoration(

              shape:
              BoxShape.circle,

              gradient:
              LinearGradient(

                colors: [

                  Color(0xFF00E5FF),

                  Color(0xFFB026FF),
                ],
              ),
            ),

            child: const Icon(

              Icons.groups,

              color: Colors.white,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style:
                  const TextStyle(

                    color:
                    Colors.white,

                    fontWeight:
                    FontWeight.bold,

                    fontSize: 18,
                  ),
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(

                  time,

                  style:
                  const TextStyle(

                    color:
                    Colors.white70,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(

                  members,

                  style:
                  const TextStyle(

                    color:
                    Color(0xFF00E5FF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// TOP BUTTON
  Widget topButton(
      IconData icon,
      VoidCallback onTap,
      ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        height: 52,
        width: 52,

        decoration: BoxDecoration(

          borderRadius:
          BorderRadius.circular(
            18,
          ),

          color:
          Colors.white.withOpacity(
            0.08,
          ),
        ),

        child: Icon(

          icon,

          color: Colors.white,
        ),
      ),
    );
  }

  /// GLOW
  Widget glowCircle(
      double size,
      Color color,
      ) {

    return Container(

      height: size,
      width: size,

      decoration: BoxDecoration(

        shape:
        BoxShape.circle,

        color:
        color.withOpacity(0.20),

        boxShadow: [

          BoxShadow(

            color:
            color.withOpacity(
              0.45,
            ),

            blurRadius: 120,
          ),
        ],
      ),
    );
  }
}