import UIKit

enum AuthResponce{
    case success, noVerify, error 
}

struct LoginField {
    var email: String
    var password: String
}

struct ResponceCode{
    var code: Int
}

struct CurentUser {
    var id: String
    var email: String  
}
