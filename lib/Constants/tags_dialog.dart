import 'package:flutter/material.dart';

import '../widgets/rounded_containers.dart';
import 'constants.dart';

Future<dynamic> showNewDialog(
  BuildContext context,
  String title,
  String title2,
  AnimationController controller,
  Animation<double> animation,
  StateSetter? _setState,
  String? _selectedYear,
  String? _selectedSem,
  String? _selectedBranch,
) {
  return showDialog(
    context: context,
    builder: (context) {
      controller.forward();
      return FadeTransition(
        opacity: animation,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            _setState = setState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'manRope Regular',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = null;
                            _selectedSem = null;
                            _selectedYear = null;
                          });
                        },
                        child: const RoundedContainer(
                          title: 'Reset',
                          yellowBg: false,
                        )),
                  ],
                ),
                const Divider(
                  color: Colors.black87,
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'YEAR',
                    style: TextStyle(
                      fontFamily: 'manRope Regular',
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  runSpacing: 6,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _setState!(() {
                          _selectedYear = '1st Year';
                        });
                      },
                      child: RoundedContainer(
                          title: '1st Year',
                          yellowBg: _selectedYear == '1st Year'),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _setState!(() {
                          _selectedYear = '2nd Year';
                        });
                      },
                      child: RoundedContainer(
                          title: '2nd Year',
                          yellowBg: _selectedYear == '2nd Year'),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _setState!(() {
                          _selectedYear = '3rd Year';
                        });
                      },
                      child: RoundedContainer(
                          title: '3rd Year',
                          yellowBg: _selectedYear == '3rd Year'),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _setState!(() {
                          _selectedYear = '4th Year';
                        });
                      },
                      child: RoundedContainer(
                          title: '4th Year',
                          yellowBg: _selectedYear == '4th Year'),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _setState!(() {
                          _selectedYear = '5th Year';
                        });
                      },
                      child: RoundedContainer(
                          title: '5th Year',
                          yellowBg: _selectedYear == '5th Year'),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'SEMESTER',
                    style: TextStyle(
                      fontFamily: 'manRope Regular',
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  runSpacing: 6,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedSem = '1st Semester';
                          });
                        },
                        child: RoundedContainer(
                            title: '1st Semester',
                            yellowBg: _selectedSem == '1st Semester')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedSem = '2nd Semester';
                          });
                        },
                        child: RoundedContainer(
                            title: '2nd Semester',
                            yellowBg: _selectedSem == '2nd Semester')),
                    const SizedBox(width: 10),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'BRANCH',
                    style: TextStyle(
                      fontFamily: 'manRope Regular',
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  runSpacing: 6,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'ENI';
                          });
                        },
                        child: RoundedContainer(
                            title: 'ENI', yellowBg: _selectedBranch == 'ENI')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'ECE';
                          });
                        },
                        child: RoundedContainer(
                            title: 'ECE', yellowBg: _selectedBranch == 'ECE')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'EEE';
                          });
                        },
                        child: RoundedContainer(
                            title: 'EEE', yellowBg: _selectedBranch == 'EEE')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'CS';
                          });
                        },
                        child: RoundedContainer(
                            title: 'CS', yellowBg: _selectedBranch == 'CS')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'Chemical';
                          });
                        },
                        child: RoundedContainer(
                            title: 'Chemical',
                            yellowBg: _selectedBranch == 'Chemical')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'Manufacturing';
                          });
                        },
                        child: RoundedContainer(
                            title: 'Manufacturing',
                            yellowBg: _selectedBranch == 'Manufacturing')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'Civil';
                          });
                        },
                        child: RoundedContainer(
                            title: 'Civil',
                            yellowBg: _selectedBranch == 'Civil')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'Bio Dual';
                          });
                        },
                        child: RoundedContainer(
                            title: 'Bio Dual',
                            yellowBg: _selectedBranch == 'Bio Dual')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'Phy Dual';
                          });
                        },
                        child: RoundedContainer(
                            title: 'Phy Dual',
                            yellowBg: _selectedBranch == 'Phy Dual')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'Chem Dual';
                          });
                        },
                        child: RoundedContainer(
                            title: 'Chem Dual',
                            yellowBg: _selectedBranch == 'Chem Dual')),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          _setState!(() {
                            _selectedBranch = 'Eco Dual';
                          });
                        },
                        child: RoundedContainer(
                            title: 'Eco Dual',
                            yellowBg: _selectedBranch == 'Eco Dual')),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [Constant.boxShadow],
                        gradient: Constant.yellowlinear,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      margin: const EdgeInsets.only(top: 28),
                      child: Text(
                        title2,
                        style: const TextStyle(
                          fontFamily: 'ManRope Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      );
    },
  );
}
