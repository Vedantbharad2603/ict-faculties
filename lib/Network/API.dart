String Host = "https://c546-2409-40c1-303a-fadd-e95e-ba7e-4a43-5bb3.ngrok-free.app";
String Path = "/ict-server/api.php";

String CurrentVersion = "1.0";

String validateLoginAPI = '$Host$Path/LoginFaculty';
String validateVersionAPI = '$Host$Path/ValidateVersion';
String getScheduleAPI = '$Host$Path/GetFacultySchedule';
String getExtraScheduleAPI = '$Host$Path/GetExtraSchedule';
String getAttendanceListAPI = '$Host$Path/GetAttendanceList';
String getExtraAttendanceListAPI = '$Host$Path/GetExtraAttendanceList';
String uploadAttendanceAPI = '$Host$Path/UploadAttendance';
String uploadExtraAttendanceAPI = '$Host$Path/UploadExtraAttendance';
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