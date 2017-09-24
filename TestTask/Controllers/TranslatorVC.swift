//
//  TranslatorVC.swift
//  TestTask
//
//  Created by Nirabaz on 8/24/17.
//  Copyright © 2017 iMolodec. All rights reserved.
//

import UIKit
import CoreData

class TranslatorVC: UIViewController {
    
    @IBOutlet weak var inputLangType: UILabel!
    @IBOutlet weak var outputLangType: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var outputField: UITextField!
    @IBOutlet weak var changeLengBtn: UIButton!
    @IBOutlet weak var translationHystoryTable: UITableView!
    
    let ukLeng = "Uk"
    let engLeng = "Eng"
    var myDict = [DictionaryItem]()
    var translationHystory = [HistoryItem]()
    
    @IBAction func onChangeLengsBtnPress(_ sender: Any) {
        if inputLangType.text == ukLeng{
            inputLangType.text = engLeng
            outputLangType.text = ukLeng
        }else{
            inputLangType.text = ukLeng
            outputLangType.text = engLeng
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor .white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 17/255, green: 39/255, blue: 45/255, alpha: 1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.text = ukLeng
        outputField.text = engLeng
        inputLangType.text = ukLeng
        outputLangType.text = engLeng
        inputField.delegate = self
        outputField.delegate = self
        prepareToWork()
    }
    
}

extension TranslatorVC{
    
    func prepareToWork(){
        changeLengBtn.isHidden = false
        inputField.text = ""
        outputField.text = ""
        outputField.isUserInteractionEnabled = false
        getHystory()
    }
    
    func translate(){
        
        outputField.text = ""
        var inputLeng = ""
        var outputLeng = ""
        let stringForTranslate = inputField.text
        
        if inputLangType.text == engLeng{
            inputLeng = engLeng
            outputLeng = ukLeng
        }else{
            inputLeng = ukLeng
            outputLeng = engLeng
        }
        
        if inputLeng != ""{
            TranslateApiManager.sharedInstance.makeHTTPPostRequest(textForTranslate: stringForTranslate!, sourseLeng: inputLeng, targetLeng: outputLeng) { (dict, error) in
                if error == nil{
                    if dict != nil{
                        var translatedString = ""
                        for val in dict!{
                            translatedString = translatedString + String(describing: val)
                        }
                        DispatchQueue.main.async { // Correct
                            self.outputField.text = translatedString
                        }
                        self.addNewHystoryItem(input: stringForTranslate!, output: translatedString)
                    }
                }else{
                    print(error?.localizedDescription ?? "some error")
                }
            }
        }
    }
    
    func addNewHystoryItem(input: String, output: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newHistoryItem = NSEntityDescription.insertNewObject(forEntityName: "HistItem", into: context)
        
        let date = NSDate()
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        
        newHistoryItem.setValue("\(input) - \(output)", forKey: "words")
        newHistoryItem.setValue("\(hour):\(minutes)", forKey: "translationDate")
        
        do{
            try context.save()
            getHystory()
            print("saved")
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func getHystory(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistItem")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                translationHystory.removeAll()
                for result in results as! [NSManagedObject]{
                    if let date = result.value(forKey: "translationDate") as? String, let words = result.value(forKey: "words") as? String{
                        let item = HistoryItem(words: words, date: date)
                        translationHystory.append(item)
                    }
                }
                translationHystoryTable.reloadData()
            }
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
}

extension TranslatorVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(translationHystory[indexPath.row].words) - \(translationHystory[indexPath.row].date)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translationHystory.count
    }
}

extension TranslatorVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        translate()
        textField.resignFirstResponder()
        return true;
    }
}



















