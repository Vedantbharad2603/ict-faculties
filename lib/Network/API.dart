String Host = "https://16e8-2409-40c1-3038-c1e6-bdbb-c5c8-393b-4e42.ngrok-free.app";
String Path = "/ict-server/api.php";

String CurrentVersion = "1.0";

String validateLoginAPI = '$Host$Path/LoginFaculty';
String validateVersionAPI = '$Host$Path/ValidateVersion';
String getScheduleAPI = '$Host$Path/GetFacultySchedule';
String getExtraScheduleAPI = '$Host$Path/GetExtraSchedule';
String getAttendanceListAPI = '$Host$Path/GetAttendanceList';
String uploadAttendanceAPI = '$Host$Path/UploadAttendance';
String getStudentByCCAPI = '$Host$Path/GetStudentsByCC';
String getEngagedStudentByCCAPI = '$Host$Path/GetEngagedStudentsByCC';
String upsertEngagedStudentAPI = '$Host$Path/UpsertEngagedStudent';

String studentImageAPI(gr){
  String api = "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(f_id){
  String api = "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$f_id";
  return api;
}