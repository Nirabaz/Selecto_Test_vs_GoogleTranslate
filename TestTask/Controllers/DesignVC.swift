
import UIKit

class DesignVC: UIViewController {

    @IBOutlet weak var myScrollView: UIScrollView!

    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    var colHeight: CGFloat = 0.0
    let cellNumber = 11
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.title = "Vika@"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor .white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 17/255, green: 39/255, blue: 45/255, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.title = ""
    }

}

extension DesignVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DesignCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let totalWidth: CGFloat = (self.view.frame.width / 3.5)
        let totalHeight: CGFloat = totalWidth * 1.3
        
        var rowsNumber = cellNumber / 3
        if rowsNumber % 2 != 0{
            rowsNumber = rowsNumber + 1
        }
        colHeight = CGFloat(rowsNumber) * totalHeight
        collectionHeight.constant = colHeight + 32
        return CGSize(width: totalWidth, height: totalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DesignCollectionCell
        if cell.isChecked == false{
            cell.isChecked = true
            cell.statusImage.isHidden = false
        }else{
            cell.isChecked = false
            cell.statusImage.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 13, left: 13, bottom: 13, right: 13)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellNumber
    }

}
