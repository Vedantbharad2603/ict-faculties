import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_faculties/Controller/AttendanceController.dart';
import 'package:ict_faculties/Screens/EngagedStudentScreen.dart';
import 'package:intl/intl.dart';  // Import intl package for date formatting
import 'package:ict_faculties/Helper/Components.dart';
import '../API/API.dart';
import '../Controller/StudentController.dart';
import '../Helper/Colors.dart';
import '../Helper/Style.dart';

class Addstudentengaged extends StatefulWidget {
  const Addstudentengaged({super.key});

  @override
  State<Addstudentengaged> createState() => _AddstudentengagedState();
}

class _AddstudentengagedState extends State<Addstudentengaged> {
  late int facId;
  late String facDesignation;
  bool isLoading = false;
  List<dynamic>? studentsDataList;
  final StudentController studentController = Get.put(StudentController());
  final AttendanceController attendanceController = Get.put(AttendanceController());
  TextEditingController searchController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  EngagedStudent obj = new EngagedStudent();
  dynamic foundStudent;

  @override
  void initState() {
    facId = Get.arguments['faculty_id'];
    facDesignation = Get.arguments['faculty_des'];
    super.initState();
    fetchStudentDetail();
  }

  Future<void> fetchStudentDetail() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic>? fetchedStudentDataList =
    await studentController.getStudentsByCC(facId);
    if (!mounted) return;
    setState(() {
      studentsDataList = fetchedStudentDataList;
      isLoading = false;
    });
  }

  void searchStudent() {
    String searchText = searchController.text.trim();
    if (studentsDataList != null && searchText.isNotEmpty) {
      foundStudent = studentsDataList?.firstWhere(
            (student) =>
        student['enrollment_no'] == searchText ||
            student['gr_no'] == searchText,
        orElse: () => null,
      );
    } else {
      foundStudent = null;
    }
    setState(() {});
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller, {bool isEndDate = false}) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime.now();

    // For End Date, set firstDate to Start Date if selected
    if (isEndDate && startDateController.text.isNotEmpty) {
      firstDate = DateFormat('yyyy-MM-dd').parse(startDateController.text);
      initialDate = firstDate; // Default to the Start Date as the initial date
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate, // Ensure End Date can't be before Start Date
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: muColor, // Customize the calendar appearance
            colorScheme: ColorScheme.light(
              primary: muColor, // Header and active dates
              onPrimary: Colors.white, // Text color of the header
              onSurface: muColor, // Text color of inactive dates
            ),
            dialogBackgroundColor: Colors.white, // Background color of the date picker
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        controller.text = formattedDate; // Set the selected date to the TextField
      });
    }
  }

  Future<void> upsertEngaged()
  async {
    if(await attendanceController.upsertEngagedStudent(foundStudent['id'], facId, "N/A", "oe", startDateController.text, endDateController.text)){
      ArtSweetAlert.show(
        context: context,
        barrierDismissible: false,
        artDialogArgs: ArtDialogArgs(
          dialogPadding: EdgeInsets.only(top: 30),
          type: ArtSweetAlertType.success,
          sizeSuccessIcon: 70,
          confirmButtonText: "", // Hides the confirm button
          confirmButtonColor: Colors.white,
          title: "Student engaged successful !",
          dialogDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      );
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.back();
        Get.toNamed("/engagedStudent",arguments: {'faculty_id': facId,'faculty_des':facDesignation});
        /////////////// HERE CALL fetchEngagedStudentDetail
      });
    }
    else
      {
        ArtSweetAlert.show(
          context: context,
          barrierDismissible: false,
          artDialogArgs: ArtDialogArgs(
            dialogPadding: EdgeInsets.only(top: 30),
            type: ArtSweetAlertType.danger,
            sizeSuccessIcon: 70,
            confirmButtonText: "", // Hides the confirm button
            confirmButtonColor: Colors.white,
            title: "Fail to engaged student !",
            dialogDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        );
        Future.delayed(const Duration(milliseconds: 1500), () {
          Get.back();
        });
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Student Engage", style: AppbarStyle),
        centerTitle: true,
        backgroundColor: muColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          if(foundStudent != null && startDateController.text!="" &&endDateController.text!="")
            {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs:
                ArtDialogArgs(
                  type: ArtSweetAlertType.question,
                  sizeSuccessIcon: 70,
                  confirmButtonText: "CONFIRM", // Hides the confirm button
                  confirmButtonColor: muColor,
                  onConfirm: () async {
                    upsertEngaged();
                    Get.back();
                  },
                  text: "${foundStudent["first_name"]} ${foundStudent["last_name"]} \n is officially engaged at \n"
                      "${startDateController.text==endDateController.text?startDateController.text:
                  "${startDateController.text} \n to \n ${endDateController.text}"}",
                  dialogDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            }
          else{
            ArtSweetAlert.show(
              context: context,
              artDialogArgs:
              ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                sizeSuccessIcon: 70,
                confirmButtonText: "OK", // Hides the confirm button
                confirmButtonColor: muColor,
                onConfirm: () async {
                  Get.back();
                },
                title: "Missing Required Field",
                dialogDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          }
        },
        backgroundColor: muColor,
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          "SUBMIT",
          style:
          TextStyle(fontFamily: 'mu_bold', color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Enroll GR TextField
                Container(
                  height: getHeight(context, 0.07),
                  width: getWidth(context, 0.7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Light1.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: searchController,
                    cursorColor: muColor,
                    decoration: InputDecoration(
                      labelText: 'GR / Enrollment',
                      labelStyle: const TextStyle(
                        fontFamily: "mu_reg",
                        color: Colors.grey,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Light1, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Light1, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      fontSize:getSize(context,2.5),
                      fontFamily: "mu_reg",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                InkWell(
                  onTap: searchStudent,
                  child: Container(
                    width: getWidth(context, 0.2),
                    height: getHeight(context, 0.065),
                    decoration: BoxDecoration(
                        color: muColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child: Text("GET",style: TextStyle(color: Colors.white,fontFamily: "mu_bold",fontSize: getSize(context, 2)),)),
                  ),
                )
              ],
            ),
            // Student Details
            if (isLoading)
              Center(child: CircularProgressIndicator(color: muColor,))
            else if (foundStudent != null)
              Column(
                children: [
                  Divider(indent: 15,endIndent: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Light1.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.4),
                          )

                      ),
                      width: getWidth(context, 1),
                      height: getHeight(context, 0.15),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: getSize(context, 10),
                                width: getSize(context, 10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(500))),
                                child: Image.network(studentImageAPI(foundStudent['gr_no'])),
                              ),
                            ),
                            SizedBox(width: getWidth(context, 0.05),),
                            Container(
                              width: getWidth(context, 0.6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${foundStudent['first_name']} ${foundStudent['last_name']}",
                                    style: TextStyle(fontFamily: 'mu_bold',fontSize:getSize(context, 2.5)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("Enroll: ${foundStudent['enrollment_no']}",
                                    style: TextStyle(fontFamily: 'mu_reg',fontSize:getSize(context, 2)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text("GR: ${foundStudent['gr_no']}",
                                    style: TextStyle(fontFamily: 'mu_reg',fontSize:getSize(context, 2)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (!isLoading && searchController.text.isNotEmpty)
                Column(
                  children: [
                    Divider(indent: 15,endIndent: 15,),
                    Center(
                      child: Text(
                        "No student found with this GR No. / Enrollment No.",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
            Divider(indent: 15,endIndent: 15,),

            // Date Pickers for Start and End Date
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: getHeight(context, 0.09),
                width: getWidth(context, 1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Light1.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => selectDate(context, startDateController),
                  child: TextField(
                    controller: startDateController,
                    cursorColor: muColor,
                    enabled: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'Start Date',
                      labelStyle: const TextStyle(
                        fontFamily: "mu_reg",
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Light1, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Light1, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      fontSize:getSize(context,2.5),
                      fontFamily: "mu_reg",
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                    readOnly: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: getHeight(context, 0.09),
                width: getWidth(context, 1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Light1.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => selectDate(context, endDateController, isEndDate: true),
                  child: TextField(
                    controller: endDateController,
                    cursorColor: muColor,
                    enabled: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'End Date',
                      labelStyle: const TextStyle(
                        fontFamily: "mu_reg",
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Light1, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Light1, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      fontSize:getSize(context,2.5),
                      fontFamily: "mu_reg",
                      fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                    readOnly: true,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

