import UIKit
import Firebase
import FirebaseFirestore

class Service {
    static let shared = Service()
    
    init() {}
    
    func createNewUser(_ data: LoginField, complition: @escaping (ResponceCode)->()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { result, err in
            if err == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email":email]
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    complition(ResponceCode(code: 1))
                }
            } else {
                
                complition(ResponceCode(code: 0))
            }
        }
    }
    func confrimEmail(){
        Auth.auth().currentUser?.sendEmailVerification(completion: {err in
            if err != nil {
                print(err!.localizedDescription)
            }
        })
    }
    
    func authInApp(_ data: LoginField, complition: @escaping (AuthResponce) ->()){
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, err in
            if err != nil {
                complition(.error)
            }else  {
                if let result = result {
                    if  result.user.isEmailVerified {
                        complition(.success)
                    } else {
                        self.confrimEmail()
                        complition(.noVerify)
                    }
                }
            }
        }
    }
    func getUsersStatus(){
        
    }
}
