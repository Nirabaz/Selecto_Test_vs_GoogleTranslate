
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor  }
        get {
            var color: UIColor?
            if layer.borderColor != nil{
                color = UIColor(cgColor: layer.borderColor!)
            }
            return color
        }
    }
}

@IBDesignable
class designableImage: UIImageView{
    @IBInspectable var isCircle: Bool = false{
        didSet{
            layoutIfNeeded()
            if  isCircle{
                self.layer.cornerRadius = self.frame.size.width/2
            }else{
                self.layer.cornerRadius = 0
            }
            self.clipsToBounds = true
        }
    }
}
