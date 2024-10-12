class Schedule {
  String subjectName;
  String shortName;
  String subjectCode;
  String subjectType;
  int sem;
  String eduType;
  String className;
  String batch;
  String classLocation;
  String startTime;
  String endTime;

  Schedule({
    required this.subjectName,
    required this.sem,
    required this.shortName,
    required this.subjectCode,
    required this.subjectType,
    required this.eduType,
    required this.className,
    required this.batch,
    required this.classLocation,
    required this.startTime,
    required this.endTime
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      subjectName: json['subject_name'] ?? '',
      sem: json['sem'] ?? 0,
      shortName: json['short_name']??'',
      subjectCode: json['subject_code']??'',
      subjectType: json['type'][0].toUpperCase() + json['type'].substring(1) ?? '',
      eduType: json['edu_type'][0].toUpperCase() + json['edu_type'].substring(1) ?? '',
      className: json['classname'] ?? '${json['short_name']}',
      batch: json['batch'] ?? 'ALL',
      classLocation: json['class_location'] ?? '',
      startTime: json['start_time'] ?? '00:00',
      endTime: json['end_time'] ?? '00:00',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'subject_name': subjectName,
      'short_name':shortName,
      'subject_code':subjectCode,
      'type':subjectType,
      'sem': sem,
      'edu_type':eduType,
      'classname':className,
      'batch':batch,
      'class_location': classLocation,
      'class_start_time': startTime,
      'class_end_time': endTime,
    };
  }
}