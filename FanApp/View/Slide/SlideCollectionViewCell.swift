import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
   
    
    static let reuceId = "SlideCollectionViewCell"
    var deligate: LoginViewControllerDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func btnReg(_ sender: Any) {
        deligate.openRegVC()
    }
    
    
    @IBAction func authBtnClick(_ sender: Any) {
        deligate.openAuthVC()
    }
}
