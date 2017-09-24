
import UIKit

class GifCollectionVC: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var gifsNames = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    var imgArr = [UIImage]()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor .white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 17/255, green: 39/255, blue: 45/255, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GifCollectionVC: UICollectionViewDataSource, UICollectionViewDelegate{
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GifCollectionCell
        cell.content.loadGif(name: gifsNames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let totalWidth: CGFloat = (self.view.frame.width / 3.5)
        let totalHeight: CGFloat = totalWidth
        return CGSize(width: totalWidth, height: totalHeight)
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
        return gifsNames.count
    }
}
