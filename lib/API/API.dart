String Host = "https://255d-2409-40c1-3018-9397-45e6-321b-61ba-8142.ngrok-free.app";
// String Host = "http://localhost";

String validateLoginAPI = '$Host/icttest/api.php/LoginFaculty';
String getScheduleAPI = '$Host/icttest/api.php/GetFacultySchedule';
String getAttendanceListAPI = '$Host/icttest/api.php/GetAttendanceList';
String uploadAttendanceAPI = '$Host/icttest/api.php/UploadAttendance';

String studentImageAPI(gr){
  String api = "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(f_id){
  String api = "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$f_id";
  return api;
}