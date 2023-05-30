import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);


map<courseInformation> course_details = {};
map<Users> users =  {
        
        "admin" : { usersId: 1  ,
                     username:"admin" , 
                     password : "1234",
                      role : "admin" },
        "assesor" : { usersId: 2  ,
                      username:"assesor" , 
                      password : "1234",
                       role : "assesor" },
        "learner" : { usersId: 3 ,
                        username:"learner" , 
                        password : "1234", 
                        role : "learner" }
     
     };

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_ASSESMENT, descMap: getDescriptorMapAssesment()}
service "Assessments" on ep {


    remote function login(loginRequest value) returns string|error {
      
        if (users.hasKey(value.fullname)) {
            Users? user = users[value.fullname];

            if (user is Users && user.password == value.password) {
                    return user.role;
            }
        }
       
      return "user does not exist";
    }

    remote function assign_courses(assignCourse value) returns string|error {
       
        var course_id = value.courseId.toString();

        if ( course_details.hasKey(course_id)  ) {
          
           course_details[course_id]["assessorId"] = value.assessorId;

           return "assesor assigned to : " + course_details[course_id]["courseName"].toString();

        }  

        return "course does not exist";
    }

    remote function submit_marks(requestsAssignments value) returns string|error {
         
          var assignmentMark = value.assignmentMark;

          foreach courseInformation course in course_details {

               if ( course.courseName === value.courseName ) {
                
                  foreach Assignment assignment in course.assignment {
               
                    foreach Submissions submission in assignment.submission {
                         
                          submission.studentMark = value.assignmentMark;
                    }  

                  }

               }
               course_details[course.courseId.toString()] = course;
          }

        return "submit marks";
       
    }
    remote function create_users(AssessmentsStringCaller caller , stream<Users, grpc:Error?> clientStream) returns error? {
      
      check clientStream.forEach(function(Users value) {

                  users[value.username] = value;

                  checkpanic caller->sendString( "created user : " + value.fullname );

        });

       check caller->complete();
      
    }
    remote function submit_assignments(AssessmentsStringCaller caller , stream<Assignment, grpc:Error?> clientStream) returns error? {

        check clientStream.forEach(function(Assignment value) {
         
          map<courseInformation> requested_course_details = course_details.filter((o) => 
                                                o.assignment.some((ass) => (   ass.assignmentId ===  value.assignmentId ))
                                            );
          courseInformation courseAssignment = requested_course_details.get("1");
          Assignment[] requested_assignment = courseAssignment.assignment.filter((a) =>  a.assignmentId == value.assignmentId );
          requested_assignment[0].submission.push( value.submission[0] );
          
          course_details[courseAssignment.courseId.toString()].assignment  = requested_assignment;
           
                 io:println(course_details.get("1"));
                 checkpanic caller->sendString( "successful" );
        });
       //complete assignment
       check caller->complete();
       
      
    }
    remote function register(stream<StudentsRegistered, grpc:Error?> clientStream) returns string|error {
         
         check clientStream.forEach(function(StudentsRegistered value) {
         
          foreach courseInformation course in course_details {

               if ( course.courseName === value.courseName ) {

                  StudentsRegistered[] students = course.studentsRegistered;
                  students.push( {usersId: value.usersId} );

                  course_details[course.courseId.toString()].studentsRegistered = students;
                  io:println(course_details[course.courseId.toString()]);

               }
          }
       
        });

      return " user registered succesfully ";
    }
    remote function request_assignments(AssessmentsSubmissionsCaller caller,requestsAssignments value) returns error?  {
           var course_id =  value.courseName ;

        if ( course_details.hasKey(course_id)  ) {
          
          courseInformation extracted_course =  course_details.get(course_id);
          Assignment[] requested_assignment = extracted_course.assignment.filter((a) =>  a.assignmentId == value.assignmentId );
           
           foreach Submissions submitted_assignment in requested_assignment[0].submission {
              //looping through and streaming the result
              if ( submitted_assignment.studentMark === 0 ) {
                   checkpanic caller->sendSubmissions( submitted_assignment );
              }
               
           }
           
        }  
      check caller->complete();

    }
    remote function create_courses(AssessmentsCourseCodesResponseCaller caller , stream<courseInformation, grpc:Error?> clientStream) returns error?  {

        check clientStream.forEach(function(courseInformation value) {
                  //storing course by id 
                  course_details[value.courseId.toString()] = value;

                 checkpanic caller->sendCourseCodesResponse( { code: value.courseName + value.courseId.toString() } );
        });
       //close stream
       check caller->complete();
    }

}



