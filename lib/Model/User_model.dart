class User {
  String? email;
  String? phoneNo;
  int? id;
  String? userLoginId;
  String? facultyId;
  String? firstName;
  String? lastName;
  int? addressInfoId;
  String? gender;
  String? profilePic;
  DateTime? birthDate;
  String? designation;
  DateTime? joiningDate;

  User({
    this.email,
    this.phoneNo,
    this.id,
    this.userLoginId,
    this.facultyId,
    this.firstName,
    this.lastName,
    this.addressInfoId,
    this.gender,
    this.profilePic,
    this.birthDate,
    this.designation,
    this.joiningDate,
  });

  // Factory method to create a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      phoneNo: json['phone_no'],
      id: json['id'],
      userLoginId: json['user_login_id'],
      facultyId: json['faculty_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      addressInfoId: json['address_info_id'],
      gender: json['gender'],
      profilePic: json['profile_pic'],
      birthDate: DateTime.parse(json['birth_date']),
      designation: json['designation'],
      joiningDate: DateTime.parse(json['joining_date']),
    );
  }

  // Method to convert User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone_no': phoneNo,
      'id': id,
      'user_login_id': userLoginId,
      'faculty_id': facultyId,
      'first_name': firstName,
      'last_name': lastName,
      'address_info_id': addressInfoId,
      'gender': gender,
      'profile_pic': profilePic,
      'birth_date': birthDate?.toIso8601String(),
      'designation': designation,
      'joining_date': joiningDate?.toIso8601String(),
    };
  }
}
