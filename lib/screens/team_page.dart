import 'package:flutter/material.dart';
import 'package:freightbro_app/models/api_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grouped_list/grouped_list.dart';

class TeamPage extends StatefulWidget {
  TeamPage({this.employees, this.department});
  final List<Employee> employees;
  final String department;
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  List empMap;

  @override
  void initState() {
    super.initState();
    getMap();
  }

  void getMap() {
    List<Employee> empList = widget.employees;
    empList.sort((a, b) => a.firstName.compareTo(b.firstName));
    empMap = empList.map((e) => e.toMap()).toList();
    //print(empMap);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF7F8F9),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                empMap.length > 1
                    ? '${empMap.length} participants'
                    : '${empMap.length} participant',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                widget.department,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: GroupedListView(
                  elements: empMap,
                  groupBy: (emp) => emp['firstName'].toString().substring(0, 1),
                  groupSeparatorBuilder: (String groupByValue) => Text(
                    ' $groupByValue ',
                    style: TextStyle(
                      foreground: Paint()
                        ..color = Colors.black
                        ..strokeWidth = 1.0
                        ..style = PaintingStyle.fill,
                      backgroundColor: Colors.yellow,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  itemBuilder: (context, dynamic element) => Dismissible(
                    key: ValueKey(element['id']),
                    background: Container(
                      color: Colors.redAccent,
                      child: Icon(Icons.delete),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        empMap.remove(element);
                      });
                    },
                    child: ListTile(
                      leading: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImage(
                              imageUrl: element['avatar'],
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/user.png'),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Icon(
                              Icons.circle,
                              size: 15.0,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                          '${element['firstName']} ${element['lastName']}'),
                      subtitle: Text('Employee ID: ${element['id']}'),
                      trailing: Icon(
                        Icons.run_circle_outlined,
                        color: Colors.blue,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
