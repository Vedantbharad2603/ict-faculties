String Host = "https://2e6c-2409-40c1-302d-c3c7-298e-e3cd-99c7-240.ngrok-free.app";
// String Host = "http://localhost";

String validateLoginAPI = '$Host/icttest/api.php/LoginFaculty';
String getScheduleAPI = '$Host/icttest/api.php/GetFacultySchedule';
String getAttendanceListAPI = '$Host/icttest/api.php/GetAttendanceList';
String uploadAttendanceAPI = '$Host/icttest/api.php/UploadAttendance';
String getStudentByCC = '$Host/icttest/api.php/GetStudentsByCC';
String getEngagedStudentByCC = '$Host/icttest/api.php/GetEngagedStudentsByCC';

String studentImageAPI(gr){
  String api = "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(f_id){
  String api = "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$f_id";
  return api;
}