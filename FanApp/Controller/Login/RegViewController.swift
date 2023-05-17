import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var service = Service.shared
    
    @IBOutlet var mainView: UIView!
    
    var tapGest: UITapGestureRecognizer?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rePasswordView: UIView!
    @IBOutlet weak var rePasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGest!)
    }
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @objc func endEditing() {
        self.view.endEditing(true)
    }
    
    @IBAction func regBtn(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField)
        {
            if passwordField.text == rePasswordField.text{
                service.createNewUser(LoginField (email: emailField.text!, password: passwordField.text!)) { [weak self]
                    code in
                    switch code.code{
                    case 0:
                        print("Error")
                    case 1:
                        print("Reg Ok")
                        self?.service.confrimEmail()
                        let alert = UIAlertController(title: "OK", message: "Success", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "Хорошо", style: .default) { _ in
                            self?.delegate.closeVC()
                        }
                        alert.addAction(okBtn)
                        self?.present(alert, animated: true)
                    default:
                        print("No Error")
                    }
                }
                
            }else {
                print("пароли не совпадают")
            }
           
        }
    }
}
    

