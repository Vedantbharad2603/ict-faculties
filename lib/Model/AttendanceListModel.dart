class AttendanceList {
  int? studentID;
  String? enrollment;
  String? studentName;
  String? studentGR;
  String? classname;
  String? classBatch;
  String? status;

  AttendanceList({
    required this.studentID,
    required this.enrollment,
    required this.studentName,
    required this.studentGR,
    required this.classname,
    required this.classBatch,
    required this.status
  });
  @override
  String toString() {
    return 'Enroll: $enrollment, GR: $studentGR, Name: $studentName, Class: $classname, Batch: $classBatch, Status: $status';
  }
  factory AttendanceList.fromJson(Map<String, dynamic> json) {
    return AttendanceList(
        studentID: json['studentId'],
        enrollment: json['enrollment_no'],
        studentGR:json['gr_no'],
        studentName: json['student_name'],
        classname: json['classname'],
        classBatch: json['class_batch'],
        status: json['status']
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'studentId':studentID,
      'enrollment_no':enrollment,
      'student_gr':studentGR,
      'student_name':studentName,
      'classname':classname,
      'batch':classBatch,
      'status':status
    };
  }
}