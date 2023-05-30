import ballerina/grpc;
import ballerina/protobuf.types.wrappers;

public isolated client class AssessmentsClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR_ASSESMENT, getDescriptorMapAssesment());
    }

    isolated remote function assign_courses(assignCourse|ContextAssignCourse req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        assignCourse message;
        if req is ContextAssignCourse {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessments/assign_courses", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function assign_coursesContext(assignCourse|ContextAssignCourse req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        assignCourse message;
        if req is ContextAssignCourse {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessments/assign_courses", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function submit_marks(requestsAssignments|ContextRequestsAssignments req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        requestsAssignments message;
        if req is ContextRequestsAssignments {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessments/submit_marks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function submit_marksContext(requestsAssignments|ContextRequestsAssignments req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        requestsAssignments message;
        if req is ContextRequestsAssignments {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessments/submit_marks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function login(loginRequest|ContextLoginRequest req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        loginRequest message;
        if req is ContextLoginRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessments/login", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function loginContext(loginRequest|ContextLoginRequest req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        loginRequest message;
        if req is ContextLoginRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessments/login", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Assessments/create_users");
        return new Create_usersStreamingClient(sClient);
    }

    isolated remote function submit_assignments() returns Submit_assignmentsStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Assessments/submit_assignments");
        return new Submit_assignmentsStreamingClient(sClient);
    }

    isolated remote function register() returns RegisterStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Assessments/register");
        return new RegisterStreamingClient(sClient);
    }

    isolated remote function request_assignments(requestsAssignments|ContextRequestsAssignments req) returns stream<Submissions, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        requestsAssignments message;
        if req is ContextRequestsAssignments {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("Assessments/request_assignments", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        SubmissionsStream outputStream = new SubmissionsStream(result);
        return new stream<Submissions, grpc:Error?>(outputStream);
    }

    isolated remote function request_assignmentsContext(requestsAssignments|ContextRequestsAssignments req) returns ContextSubmissionsStream|grpc:Error {
        map<string|string[]> headers = {};
        requestsAssignments message;
        if req is ContextRequestsAssignments {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("Assessments/request_assignments", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        SubmissionsStream outputStream = new SubmissionsStream(result);
        return {content: new stream<Submissions, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function create_courses() returns Create_coursesStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("Assessments/create_courses");
        return new Create_coursesStreamingClient(sClient);
    }
}

public client class Create_usersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUsers(Users message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUsers(ContextUsers message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class Submit_assignmentsStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendAssignment(Assignment message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextAssignment(ContextAssignment message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class RegisterStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendStudentsRegistered(StudentsRegistered message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextStudentsRegistered(ContextStudentsRegistered message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class SubmissionsStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Submissions value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Submissions value;|} nextRecord = {value: <Submissions>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class Create_coursesStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCourseInformation(courseInformation message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCourseInformation(ContextCourseInformation message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCourseCodesResponse() returns courseCodesResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <courseCodesResponse>payload;
        }
    }

    isolated remote function receiveContextCourseCodesResponse() returns ContextCourseCodesResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <courseCodesResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class AssessmentsSubmissionsCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSubmissions(Submissions response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSubmissions(ContextSubmissions response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class AssessmentsCourseCodesResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCourseCodesResponse(courseCodesResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCourseCodesResponse(ContextCourseCodesResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class AssessmentsStringCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendString(string response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextString(wrappers:ContextString response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextAssignmentStream record {|
    stream<Assignment, error?> content;
    map<string|string[]> headers;
|};

public type ContextStudentsRegisteredStream record {|
    stream<StudentsRegistered, error?> content;
    map<string|string[]> headers;
|};

public type ContextCourseCodesResponseStream record {|
    stream<courseCodesResponse, error?> content;
    map<string|string[]> headers;
|};

public type ContextUsersStream record {|
    stream<Users, error?> content;
    map<string|string[]> headers;
|};

public type ContextCourseInformationStream record {|
    stream<courseInformation, error?> content;
    map<string|string[]> headers;
|};

public type ContextSubmissionsStream record {|
    stream<Submissions, error?> content;
    map<string|string[]> headers;
|};

public type ContextAssignment record {|
    Assignment content;
    map<string|string[]> headers;
|};

public type ContextStudentsRegistered record {|
    StudentsRegistered content;
    map<string|string[]> headers;
|};

public type ContextCourseCodesResponse record {|
    courseCodesResponse content;
    map<string|string[]> headers;
|};

public type ContextRequestsAssignments record {|
    requestsAssignments content;
    map<string|string[]> headers;
|};

public type ContextAssignCourse record {|
    assignCourse content;
    map<string|string[]> headers;
|};

public type ContextLoginRequest record {|
    loginRequest content;
    map<string|string[]> headers;
|};

public type ContextUsers record {|
    Users content;
    map<string|string[]> headers;
|};

public type ContextCourseInformation record {|
    courseInformation content;
    map<string|string[]> headers;
|};

public type ContextSubmissions record {|
    Submissions content;
    map<string|string[]> headers;
|};

public type Assignment record {|
    int assignmentId = 0;
    int weight = 0;
    Submissions[] submission = [];
|};

public type StudentsRegistered record {|
    int usersId = 0;
    string courseName = "";
|};

public type courseCodesResponse record {|
    string code = "";
|};

public type requestsAssignments record {|
    string courseName = "";
    int assignmentId = 0;
    int assignmentMark = 0;
|};

public type assignCourse record {|
    int courseId = 0;
    int assessorId = 0;
|};

public type loginRequest record {|
    string fullname = "";
    string password = "";
|};

public type Users record {|
    int usersId = 0;
    string fullname = "";
    string username = "";
    string password = "";
    string role = "";
|};

public type courseInformation record {|
    int courseId = 0;
    string courseName = "";
    int assessorId = 0;
    StudentsRegistered[] studentsRegistered = [];
    Assignment[] assignment = [];
|};

public type Submissions record {|
    int submissionId = 0;
    string studentNumber = "";
    int studentMark = 0;
|};

const string ROOT_DESCRIPTOR_ASSESMENT = "0A0F61737365736D656E742E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22E1010A11636F75727365496E666F726D6174696F6E121A0A08636F7572736549641801200128055208636F757273654964121E0A0A636F757273654E616D65180220012809520A636F757273654E616D65121E0A0A6173736573736F724964180320012805520A6173736573736F72496412430A1273747564656E74735265676973746572656418042003280B32132E53747564656E747352656769737465726564521273747564656E747352656769737465726564122B0A0A61737369676E6D656E7418052003280B320B2E41737369676E6D656E74520A61737369676E6D656E74224A0A0C61737369676E436F75727365121A0A08636F7572736549641801200128055208636F757273654964121E0A0A6173736573736F724964180220012805520A6173736573736F72496422760A0A41737369676E6D656E7412220A0C61737369676E6D656E744964180120012805520C61737369676E6D656E74496412160A067765696768741802200128055206776569676874122C0A0A7375626D697373696F6E18032003280B320C2E5375626D697373696F6E73520A7375626D697373696F6E22790A0B5375626D697373696F6E7312220A0C7375626D697373696F6E4964180120012805520C7375626D697373696F6E496412240A0D73747564656E744E756D626572180220012809520D73747564656E744E756D62657212200A0B73747564656E744D61726B180320012805520B73747564656E744D61726B2289010A05557365727312180A0775736572734964180120012805520775736572734964121A0A0866756C6C6E616D65180220012809520866756C6C6E616D65121A0A08757365726E616D651803200128095208757365726E616D65121A0A0870617373776F7264180420012809520870617373776F726412120A04726F6C651805200128095204726F6C6522290A13636F75727365436F646573526573706F6E736512120A04636F64651801200128095204636F6465224E0A1253747564656E74735265676973746572656412180A0775736572734964180120012805520775736572734964121E0A0A636F757273654E616D65180220012809520A636F757273654E616D652281010A13726571756573747341737369676E6D656E7473121E0A0A636F757273654E616D65180120012809520A636F757273654E616D6512220A0C61737369676E6D656E744964180220012805520C61737369676E6D656E74496412260A0E61737369676E6D656E744D61726B180320012805520E61737369676E6D656E744D61726B22460A0C6C6F67696E52657175657374121A0A0866756C6C6E616D65180120012809520866756C6C6E616D65121A0A0870617373776F7264180220012809520870617373776F726432FF030A0B4173736573736D656E7473123E0A0E6372656174655F636F757273657312122E636F75727365496E666F726D6174696F6E1A142E636F75727365436F646573526573706F6E736528013001123D0A0E61737369676E5F636F7572736573120D2E61737369676E436F757273651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512360A0C6372656174655F757365727312062E55736572731A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112410A127375626D69745F61737369676E6D656E7473120B2E41737369676E6D656E741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801123B0A13726571756573745F61737369676E6D656E747312142E726571756573747341737369676E6D656E74731A0C2E5375626D697373696F6E73300112420A0C7375626D69745F6D61726B7312142E726571756573747341737369676E6D656E74731A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123F0A08726567697374657212132E53747564656E7473526567697374657265641A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112340A056C6F67696E120D2E6C6F67696E526571756573741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565620670726F746F33";

public isolated function getDescriptorMapAssesment() returns map<string> {
    return {"assesment.proto": "0A0F61737365736D656E742E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22E1010A11636F75727365496E666F726D6174696F6E121A0A08636F7572736549641801200128055208636F757273654964121E0A0A636F757273654E616D65180220012809520A636F757273654E616D65121E0A0A6173736573736F724964180320012805520A6173736573736F72496412430A1273747564656E74735265676973746572656418042003280B32132E53747564656E747352656769737465726564521273747564656E747352656769737465726564122B0A0A61737369676E6D656E7418052003280B320B2E41737369676E6D656E74520A61737369676E6D656E74224A0A0C61737369676E436F75727365121A0A08636F7572736549641801200128055208636F757273654964121E0A0A6173736573736F724964180220012805520A6173736573736F72496422760A0A41737369676E6D656E7412220A0C61737369676E6D656E744964180120012805520C61737369676E6D656E74496412160A067765696768741802200128055206776569676874122C0A0A7375626D697373696F6E18032003280B320C2E5375626D697373696F6E73520A7375626D697373696F6E22790A0B5375626D697373696F6E7312220A0C7375626D697373696F6E4964180120012805520C7375626D697373696F6E496412240A0D73747564656E744E756D626572180220012809520D73747564656E744E756D62657212200A0B73747564656E744D61726B180320012805520B73747564656E744D61726B2289010A05557365727312180A0775736572734964180120012805520775736572734964121A0A0866756C6C6E616D65180220012809520866756C6C6E616D65121A0A08757365726E616D651803200128095208757365726E616D65121A0A0870617373776F7264180420012809520870617373776F726412120A04726F6C651805200128095204726F6C6522290A13636F75727365436F646573526573706F6E736512120A04636F64651801200128095204636F6465224E0A1253747564656E74735265676973746572656412180A0775736572734964180120012805520775736572734964121E0A0A636F757273654E616D65180220012809520A636F757273654E616D652281010A13726571756573747341737369676E6D656E7473121E0A0A636F757273654E616D65180120012809520A636F757273654E616D6512220A0C61737369676E6D656E744964180220012805520C61737369676E6D656E74496412260A0E61737369676E6D656E744D61726B180320012805520E61737369676E6D656E744D61726B22460A0C6C6F67696E52657175657374121A0A0866756C6C6E616D65180120012809520866756C6C6E616D65121A0A0870617373776F7264180220012809520870617373776F726432FF030A0B4173736573736D656E7473123E0A0E6372656174655F636F757273657312122E636F75727365496E666F726D6174696F6E1A142E636F75727365436F646573526573706F6E736528013001123D0A0E61737369676E5F636F7572736573120D2E61737369676E436F757273651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512360A0C6372656174655F757365727312062E55736572731A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112410A127375626D69745F61737369676E6D656E7473120B2E41737369676E6D656E741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801123B0A13726571756573745F61737369676E6D656E747312142E726571756573747341737369676E6D656E74731A0C2E5375626D697373696F6E73300112420A0C7375626D69745F6D61726B7312142E726571756573747341737369676E6D656E74731A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123F0A08726567697374657212132E53747564656E7473526567697374657265641A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112340A056C6F67696E120D2E6C6F67696E526571756573741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565620670726F746F33", "google/protobuf/wrappers.proto": "0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"};
}

