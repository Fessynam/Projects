import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_ASSESMENT, descMap: getDescriptorMapAssesment()}
service "Assessments" on ep {

    remote function assign_courses(assignCourse value) returns string|error {
    }
    remote function submit_marks(requestsAssignments value) returns string|error {
    }
    remote function login(loginRequest value) returns string|error {
    }
    remote function create_users(stream<Users, grpc:Error?> clientStream) returns string|error {
    }
    remote function submit_assignments(stream<Assignment, grpc:Error?> clientStream) returns string|error {
    }
    remote function register(stream<StudentsRegistered, grpc:Error?> clientStream) returns string|error {
    }
    remote function request_assignments(requestsAssignments value) returns stream<Submissions, error?>|error {
    }
    remote function create_courses(stream<courseInformation, grpc:Error?> clientStream) returns stream<courseCodesResponse, error?>|error {
    }
}

