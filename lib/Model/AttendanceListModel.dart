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
        studentID: json['studentId']as int?,
        enrollment: json['enrollment_no'] as String?,
        studentGR:json['gr_no']as String?,
        studentName: json['student_name']as String?,
        classname: json['classname']as String?,
        classBatch: json['class_batch']as String?,
        status: json['status']as String?
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

  AttendanceList copyWith({String? newStatus}) {
    return AttendanceList(
      studentID: this.studentID,
      enrollment: this.enrollment,
      studentGR: this.studentGR,
      studentName: this.studentName,
      classname: this.classname,
      classBatch: this.classBatch,
      status: newStatus ?? this.status,
    );
  }
}