String Host = "https://8489-2409-40c1-3004-981f-7d08-f66c-b539-d26f.ngrok-free.app";
String  serverPath= "/ict-server/api/index.php";

String CurrentVersion = "1.0";
String validApiKey = "your-secure-api-key";
String updateURL = 'https://devanpatel28.blogspot.com/';

String validateLoginAPI = '$Host$serverPath/Faculty/login';

String validateVersionAPI = '$Host$serverPath/AppVersion/check';

String updatePasswordAPI = '$Host$serverPath/Password/updatePassword';

String getScheduleAPI = '$Host$serverPath/Attendance/GetFacultySchedule';
String getAttendanceListAPI = '$Host$serverPath/Attendance/GetAttendanceList';
String uploadAttendanceAPI = '$Host$serverPath/Attendance/UploadAttendance';
String getStudentByCCAPI = '$Host$serverPath/Attendance/GetStudentsByCC';
String getEngagedStudentByCCAPI = '$Host$serverPath/Attendance/GetEngagedStudentsByCC';
String upsertEngagedStudentAPI = '$Host$serverPath/Attendance/UpsertEngagedStudent';
String getExtraScheduleAPI = '$Host$serverPath/Attendance/GetExtraSchedule';
String getExtraAttendanceListAPI = '$Host$serverPath/Attendance/GetExtraAttendanceList';
String uploadExtraAttendanceAPI = '$Host$serverPath/Attendance/UploadExtraAttendance';

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
