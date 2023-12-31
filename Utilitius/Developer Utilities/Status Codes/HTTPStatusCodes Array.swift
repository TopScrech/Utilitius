import Foundation

let httpStatusCodes: [HTTPStatusCode] = [
    // MARK: - 1xx informational response
    .init(100, name: "Continue"),
    .init(101, name: "Switching Protocols"),
    .init(102, name: "Processing"),
    .init(103, name: "Early Hints"),
    
    // MARK: - 2xx successful
    .init(200, name: "OK"),
    .init(201, name: "Created"),
    .init(202, name: "Accepted"),
    .init(203, name: "Non-Authoritative Information"),
    .init(204, name: "No Content"),
    .init(205, name: "Reset Content"),
    .init(206, name: "Partial Content"),
    .init(207, name: "Multi-Status"),
    .init(208, name: "Already Reported"),
    .init(209, name: "IM Used"),
    
    // MARK: - 3xx redirection
    .init(300, name: "Multiple Choices"),
    .init(301, name: "Moved Permanently"),
    .init(302, name: "Found (Moved temporarily)"),
    .init(303, name: "See other"),
    .init(304, name: "Not Modified"),
    .init(305, name: "Use Proxy"),
    .init(306, name: "Switch Proxy"),
    .init(307, name: "Temporary Redirect"),
    .init(308, name: "Permanent Redirect"),
    
    // MARK: - 4xx client error
    .init(400, name: "Bad Request"),
    .init(401, name: "Unauthorized"),
    .init(402, name: "Payment Required"),
    .init(403, name: "Forbidden"),
    .init(404, name: "Not Found"),
    .init(405, name: "Method Not Allowed"),
    .init(406, name: "Not Acceptable"),
    .init(407, name: "Proxy Authentication Required"),
    .init(408, name: "Request Timeout"),
    .init(409, name: "Conflict"),
    .init(410, name: "Gone"),
    .init(411, name: "Length Required"),
    .init(412, name: "Precondition Failed"),
    .init(413, name: "Payload Too Large"),
    .init(414, name: "URI Too Long"),
    .init(415, name: "Unsupported Media Type"),
    .init(416, name: "Range Not Satisfiable"),
    .init(417, name: "Expectation Failed"),
    .init(418, name: "I'm a teapot ", description: "Indicates that the client has requested the server to brew coffee, but the server is a teapot and, therefore, incapable of brewing coffee. It's not a real error code used in actual web development or networking; it's simply an easter egg or humorous part of the HTTP status code specification."),
    .init(421, name: "Misdirected Request"),
    .init(422, name: "Unprocessable Entity"),
    .init(423, name: "Locked"),
    .init(424, name: "Failed Dependency"),
    .init(425, name: "Too Early"),
    .init(426, name: "Upgrade Required"),
    .init(428, name: "Precondition Required"),
    .init(429, name: "Too Many Requests"),
    .init(431, name: "Request Header Fields Too Large"),
    .init(451, name: "Unavailable For Legal Reasons"),
    
    // MARK: - 5xx server error
    .init(500, name: "Internal Server Error"),
    .init(501, name: "Not Implemented"),
    .init(502, name: "Bad Gateway"),
    .init(503, name: "Service Unavailable"),
    .init(504, name: "Gateway Timeout"),
    .init(505, name: "HTTP Version Not Supported"),
    .init(506, name: "Variant Also Negotiates"),
    .init(507, name: "Insufficient Storage"),
    .init(508, name: "Loop Detected"),
    .init(510, name: "Not Extended"),
    .init(511, name: "Network Authentication Required")
]
