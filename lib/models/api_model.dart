class Employee {
  final String id;
  final String createdAt;
  final String firstName;
  final String lastName;
  final String team;
  final String avatar;

  Employee({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.team,
    this.avatar,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      createdAt: json['createdAt'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      team: json['team'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'firstName': firstName,
      'lastName': lastName,
      'team': team,
      'avatar': avatar,
    };
  }
}
