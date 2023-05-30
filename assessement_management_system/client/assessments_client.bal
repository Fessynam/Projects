
import ballerina/io;
import ballerina/grpc;

AssessmentsClient ep = check new ("http://localhost:9090");

string logged_status = "";
public function main() returns error? {

   UI();
}

function UI() {


    string login_result;
   if ( logged_status is "" ){
         io:println("WELCOME TO THE ASSESMENT MANAGEMENT SYSTEM");
         io:println("******************************");
         io:println("***** LOGIN TO THE SYSTEM ***********");
        string username = io:readln("Enter username :");
        string password = io:readln("Enter password :");
        io:println("******************************");
        loginRequest logindetails = {fullname: username, password: password};

        login_result = checkpanic ep->login(logindetails);
        logged_status = login_result;
   } else {
      login_result = logged_status;
   }

   if ( login_result === "admin" ) {
        adminUi();
   } else if (  login_result === "learner"  ) {
        learnerUI();
   } else if ( login_result === "assesor" ) {
        assesorUI ();
   } else {
        io:println(" failed to login please try again");
        UI();
    }

}

function adminUi( ) {
            io:println("**** WELCOME ADMIN ****");

            io:println("1.Create Course");
            io:println("2.Assign Course");
            io:println("3.Create User");
            io:println("4.Logout");
            io:println("******************************");

            string admin_choice = io:readln("Enter choice :");

            if (admin_choice === "1") {
                enterCourseDetails();
            } else if (admin_choice === "2") {
                assignCourses();
            } else if (admin_choice === "3") {
                createUsers();
            } else {
                logged_status = "";
                UI();
            }
}

function learnerUI( ) {
            io:println("**** WELCOME Learner ****");

            io:println("1.Register");
            io:println("2.Submit Assignment");
            io:println("3.logout");
            io:println("******************************");

            string user_choice = io:readln("Enter choice :");

            if (user_choice === "1") {
                registration();
            } else if (user_choice === "2") {
                submitAssignments();
            } else {
                logged_status = "";
                UI();
            }
}

function assesorUI ( ) {
            io:println("**** WELCOME ASSESOR ****");

            io:println("1.Request Unmarked Assignment");
            io:println("2.Submit Marks");
            io:println("3.logout");
            io:println("******************************");

            string user_choice = io:readln("Enter choice :");

            if (user_choice === "1") {
                requestAssignments();
            } else if (user_choice === "2") {
                submit_marks();
            } else {
                logged_status = "";
                UI();
            }
}
public function enterCourseDetails() {

    Create_coursesStreamingClient Create_coursesStreamingClient = checkpanic ep->create_courses();
    
    io:println("*** Entering Course Details ***");
    
    string cid = io:readln("Enter Course Number eg 1  :");
    int course_id = checkpanic 'int:fromString(cid);
    string course_name = io:readln("Enter Course Name  :");
    string number_of_courses = io:readln("Enter Number Of Assignments for course :");
    StudentsRegistered[] students_registered = [];

    int|error number_of_assesments = 'int:fromString(number_of_courses);

    Assignment[] array_of_assignments = [];

    if (number_of_assesments is int) {

        foreach var j in 1 ... number_of_assesments {

            string id = io:readln("Enter assignment number :");
            int assignment_id = checkpanic 'int:fromString(id);
            string w = io:readln("Enter weight eg 35:");
            int weight = checkpanic 'int:fromString(w);
            Submissions[] submissions = [];
            //PUSH THE RESULTS IN THE ARRAY
            array_of_assignments.push({assignment_id: assignment_id, weight: weight, submission: submissions});

        }

        courseDetails courseinfo = {
            course_id: course_id,
            course_name: course_name,
            assessor_id: 0,
            students_registered: [],
            assignment: array_of_assignments
        };

    future<error?> responses = start readResponse(Create_coursesStreamingClient);

    //foreach courseDetails course in all_created_courses {
    //send course to server 
      checkpanic Create_coursesStreamingClient->sendCourseDetails(courseinfo);

    checkpanic Create_coursesStreamingClient->complete();

    checkpanic wait responses;

    UI();

    } else {
        io:println("error: oops failed to insert weight  ");
    }


}

public function assignCourses() {
    //assigning courses
    io:println("**** Assign Course To assessor ******");
    string cid = io:readln("Enter Course Number :");
    int course_id = checkpanic 'int:fromString(cid);
    string aid = io:readln("Enter Assesor  Number  :");
    int assesor_id = checkpanic 'int:fromString(aid);

    assignCourse assigncourse = {course_id: course_id, assessor_id: assesor_id};

    string assign_result = checkpanic ep->assign_courses(assigncourse);

    io:println(assign_result);

    //go back to admin 
    UI();

}

public function requestAssignments() {

    io:println("**** Request Assignments ******");
    string course_name = io:readln("Enter Course Name :");

    string aid = io:readln("Enter Assignment ID  :");
    int assignment_id = checkpanic 'int:fromString(aid);

    requestsAssignments req_assignments = {course_name: course_name, assignment_id: assignment_id};

    stream<Submissions, grpc:Error?> result_submit_assignments = checkpanic ep->request_assignments(req_assignments);
    
    checkpanic result_submit_assignments.forEach(function(Submissions i) {
        io:println("submitted assignment :", i);
    });

    //go back to admin 
    UI();
}

function submitAssignments() {

    io:println("**** Submit Assignments ******");
    string sub_id = io:readln("Enter Submission Number :");
    int submission_id = checkpanic 'int:fromString(sub_id);
    string student_number = io:readln("Enter Student Number  :");

    Submit_assignmentsStreamingClient Submit_assignmentsStreamingClient = checkpanic ep->submit_assignments();
    Assignment assignment_details = {assignment_id: 1, weight: 35, submission: [{submission_id: submission_id, student_number: student_number, student_mark: 0}]};

    checkpanic Submit_assignmentsStreamingClient->sendAssignment(assignment_details);

    checkpanic Submit_assignmentsStreamingClient->complete();

    var response = Submit_assignmentsStreamingClient->receiveString();

    io:println("result: ", response);

    UI();

}

function createUsers() {

    io:println("**** Insert Users ******");
    string uid = io:readln("Enter User Number eg 1 :");
    int user_id = checkpanic 'int:fromString(uid);

    string full_name = io:readln("Enter Full Name :");
    string user_name = io:readln("Enter User Name :");
    string password = io:readln("Enter Default Password :");
    string role = io:readln("Enter Role :");

    Create_usersStreamingClient Create_usersStreamingClient = checkpanic ep->create_users();
    Users usersinfo = {
             users_id: user_id, 
             fullname: full_name,
             username: user_name,
             role: role,
             password: password
             
             };

    checkpanic Create_usersStreamingClient->sendUsers(usersinfo);

    checkpanic Create_usersStreamingClient->complete();

    var response = Create_usersStreamingClient->receiveString();

    io:println("result :", response );

    UI();
}

function registration() {
    RegisterStreamingClient RegisterStreamingClient = checkpanic ep->register();

    string uid = io:readln("Enter User Number :");
    int user_id = checkpanic 'int:fromString(uid);

    string course_name = io:readln("Enter Course Name :");

    StudentsRegistered students_registered = {users_id: user_id, course_name: course_name};

    checkpanic RegisterStreamingClient->sendStudentsRegistered(students_registered);


    checkpanic RegisterStreamingClient->complete();

    var response = RegisterStreamingClient->receiveString();

    io:println("register ", response);

    UI();
}

function submit_marks() {
    io:println("**** Submit Marks ******");
    string course_name = io:readln("Enter Course Name :");
   
    string uid = io:readln("Enter Assignment Number :");
    int ass_id = checkpanic 'int:fromString(uid);

    string assignment_mark = io:readln("Enter Assignment Mark :");
    int ass_mark = checkpanic 'int:fromString(assignment_mark);
   
    requestsAssignments submit_marks = { course_name:course_name ,assignment_id: ass_id , assignment_mark : ass_mark };
    string assign_result = checkpanic ep->submit_marks(submit_marks);

    UI();
          
}

function login() {

    string username = io:readln("Enter username :");
    string password = io:readln("Enter password :");
    
    loginRequest logindetails = {fullname: username, password: password};

    string login_result = checkpanic ep->login(logindetails);

    io:println(login_result);
}
//Function to receive response.
function readResponse(Create_coursesStreamingClient Create_coursesStreamingClient) returns error? {
    courseCodesResponse? result = check Create_coursesStreamingClient->receiveCourseCodesResponse();
    while !(result is ()) {
        io:println("Course codes:", result);
        result = check Create_coursesStreamingClient->receiveCourseCodesResponse();
    }
}


