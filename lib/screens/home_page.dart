import 'package:flutter/material.dart';
import 'package:freightbro_app/models/api_model.dart';
import 'package:freightbro_app/services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:freightbro_app/screens/team_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = [];
  List teams = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final employees = await APIService().fetchAPIData();
    setState(() {
      this.employees = employees;
      teams = employees.map((e) => e.team).toSet().toList();
    });
  }

  List<Employee> getEmployees(String team) {
    return employees.where((employee) {
      final employeeTeam = employee.team;
      return employeeTeam == team;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF7F8F9),
        body: teams.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Groups',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFE1E6EC),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset(
                              'assets/user.png',
                              height: 40.0,
                              width: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        '${teams.length} groups created',
                        style: TextStyle(
                          color: Colors.blueGrey[300],
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: teams.length,
                        itemBuilder: (context, index) {
                          final team = teams[index];
                          final members = getEmployees(team);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TeamPage(
                                      employees: members,
                                      department: team,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0XFFFEFEFE),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Spacer(),
                                          Icon(
                                            Icons.more_horiz_outlined,
                                            color: Colors.blueGrey[300],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        team,
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: members.length,
                                          itemBuilder: (context, index) {
                                            final member = members[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: member.avatar,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          'assets/user.png'),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Text(
                                        members.length > 1
                                            ? '${members.length} participants'
                                            : '${members.length} participant',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
