import UIKit

class AuthViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    var userDefault = UserDefaults.standard
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var service = Service.shared
    
    var tapGuest: UITapGestureRecognizer?
  

    
    
    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGuest = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        mainView.addGestureRecognizer(tapGuest!)
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    @IBAction func clickAuthBtn(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField){
            
            let authData = LoginField(email: emailField.text!, password: passwordField.text!)
            
            service.authInApp(authData) {[weak self]responce in
                switch responce {
                case .success:
                    self?.userDefault.set(true, forKey: "isLogin")
                    self?.delegate.startApp()
                    self?.delegate.closeVC()
                case .noVerify:
                    let alert = self?.alertAction("Error", message: "Вам на почту была отправлена ссылка для потверждения")
                    let verefyBtn = UIAlertAction(title: "OK", style: .cancel )
                    alert?.addAction(verefyBtn)
                    self?.present(alert!, animated: true)
                case .error:
                    let alert = self?.alertAction("Error", message: "Не правельный логин или пароль")
                    let verefyBtn = UIAlertAction(title: "OK", style: .cancel )
                    alert?.addAction(verefyBtn)
                    self?.present(alert!, animated: true)
                }
            }
        } else{
            let alert = self.alertAction("Error", message: "Не правельные данные")
            let verefyBtn = UIAlertAction(title: "OK", style: .cancel )
            alert.addAction(verefyBtn)
            self.present(alert, animated: true)
        }
    }
    
    func alertAction(_ header: String?, message: String?) -> UIAlertController{
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    @IBAction func closeVC(_ sender: Any) {
        delegate.closeVC()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
}
