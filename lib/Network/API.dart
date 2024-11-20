String Host = "https://3213-119-160-199-91.ngrok-free.app";
String Path = "/ict-server-main/api/index.php";

String CurrentVersion = "1.0";
String validApiKey = "your-secure-api-key";

String validateLoginAPI = '$Host$Path/Faculty/login';
String validateVersionAPI = '$Host$Path/AppVersion/check';

String getScheduleAPI = '$Host$Path/Attendance/GetFacultySchedule';
String getAttendanceListAPI = '$Host$Path/Attendance/GetAttendanceList';
String uploadAttendanceAPI = '$Host$Path/Attendance/UploadAttendance';
String getStudentByCCAPI = '$Host$Path/Attendance/GetStudentsByCC';
String getEngagedStudentByCCAPI =
    '$Host$Path/Attendance/GetEngagedStudentsByCC';
String upsertEngagedStudentAPI = '$Host$Path/Attendance/UpsertEngagedStudent';

String getExtraScheduleAPI = '$Host$Path/Attendance/GetExtraSchedule';
String getExtraAttendanceListAPI =
    '$Host$Path/Attendance/GetExtraAttendanceList';
String uploadExtraAttendanceAPI = '$Host$Path/Attendance/UploadExtraAttendance';

String studentImageAPI(gr) {
  String api =
      "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(f_id) {
  String api =
      "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$f_id";
  return api;
}
