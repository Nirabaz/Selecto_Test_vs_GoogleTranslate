//
//  GoogleTranslateApiManager.swift
//  TestTask
//
//  Created by Nirabaz on 8/29/17.
//  Copyright © 2017 iMolodec. All rights reserved.
//

import Foundation

typealias ServiceResponse = (NSArray?, NSError?) -> Void

class TranslateApiManager{
    
    static let sharedInstance = TranslateApiManager()
    let baseUrl = "https://translation.googleapis.com/language/translate/v2?"
    let apiKey = "key=AIzaSyAGS2fSomnnzE2VhSit7O43XY1zmWZu5fA"
    
    func makeHTTPPostRequest(textForTranslate text: String, sourseLeng: String, targetLeng: String, onCompletion: @escaping ServiceResponse) {
        
        let requestURLComponents = "&q=\(text)&source=\(sourseLeng)&target=\(targetLeng)&format=text"
        let escapedURLComponents = requestURLComponents.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let requestURL = URL.init(string: "\(baseUrl)\(apiKey)\(escapedURLComponents)")!
        let request = NSMutableURLRequest(url: requestURL as URL)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
    
                do {let opt: JSONSerialization.ReadingOptions = .allowFragments
                    let object: Any? = try JSONSerialization.jsonObject(with: jsonData, options: opt)
                    
                    let dict = object as? NSDictionary
                    let myData = dict?.value(forKey: "data") as! NSDictionary
                    let translations = myData.value(forKey: "translations") as! NSArray
                    let translatedText = translations.value(forKey: "translatedText") as! NSArray
                    
                    onCompletion(translatedText, nil)
                } catch let e as NSError {
                    onCompletion(nil, e as NSError)
                }
                
            } else {
                onCompletion(nil, error! as NSError)
            }
        })
        task.resume()
    }

}

