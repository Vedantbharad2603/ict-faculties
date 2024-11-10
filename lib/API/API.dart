String Host = "https://316c-2409-40c1-3009-d76e-485a-f5e2-d55b-eeea.ngrok-free.app";
String Path = "/ict-server/api.php";

String CurrentVersion = "1.0";

String validateLoginAPI = '$Host$Path/LoginFaculty';
String validateVersionAPI = '$Host$Path/ValidateVersion';
String getScheduleAPI = '$Host$Path/GetFacultySchedule';
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