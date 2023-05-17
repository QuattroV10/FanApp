import UIKit

protocol LoginViewControllerDelegate{
    func openRegVC()
    func openAuthVC()
    func startApp()
    func closeVC()
}

class LoginViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var authVC: AuthViewController!
    var regVC: RegViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        
        
    }
        func configCollectionView(){
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
           collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            collectionView.backgroundColor = .gray
            collectionView.isPagingEnabled = true
            
            self.view.addSubview(collectionView)
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib(nibName: SlideCollectionViewCell.reuceId, bundle: nil), forCellWithReuseIdentifier: SlideCollectionViewCell.reuceId)
    }

}
extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.reuceId, for: indexPath) as! SlideCollectionViewCell
        cell.deligate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
}

extension LoginViewController: LoginViewControllerDelegate{
    
    func openAuthVC() {
        if authVC == nil {
            authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController?
        }
        authVC.delegate = self
        self.view.insertSubview(authVC.view, at: 1)
    }
    
    func openRegVC() {
        if regVC == nil {
            regVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegViewController") as! RegViewController?
        }
        regVC.delegate = self
        self.view.insertSubview(regVC.view, at: 1)
    }
    
    func closeVC() {
        if authVC != nil {
            authVC.view.removeFromSuperview()
            authVC = nil
        }
        if regVC != nil {
            regVC.view.removeFromSuperview()
            regVC = nil
        }
    }
    func startApp() {
        let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppViewController")
        self.view.insertSubview(startVC.view, at: 2)
    }
}
