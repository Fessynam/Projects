import ballerina/grpc;
import ballerina/io;
import ballerina/random;

AssessmentsClient ep = check new ("http://localhost:9090");

public function main() {

    courseDetails courseinfo = {course_id: 1, course_name: "sdff", assessor_id: 2, students_registered: [], assignment: []};
}

public function enterCourseDetails() {

    int course_id = check random:createIntInRange(1, 1000);
    string course_name = io:readln("Enter Course Name  :");
    string number_of_courses = io:readln("Enter Number Of Assignments for course :");
    StudentsRegistered[] students_registered = [];
    
    int|error number_of_assesments = 'int:fromString(number_of_courses);
   
    Assignment[] array_of_assignments = [];

    if (number_of_assesments is int) {
      
        foreach var j in 0 ... number_of_assesments {

            int assignment_id = check random:createIntInRange(1, 1000);
            string weight = io:readln("Enter weight :");
            Submissions[] submissions = [];
            //PUSH THE RESULTS IN THE ARRAY
            array_of_assignments.push( { assignment_id: assignment_id, weight: check 'int:fromString(weight) , submission: submissions } );

        }
    } else {
        io:println("error: oops failed to insert weight  ");
    }

}
