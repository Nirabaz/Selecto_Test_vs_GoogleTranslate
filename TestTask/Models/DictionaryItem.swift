//
//  DictItem.swift
//  TestTask
//
//  Created by Nirabaz on 8/25/17.
//  Copyright © 2017 iMolodec. All rights reserved.
//

import Foundation

class DictionaryItem: NSObject{

    var ukrTranslation: String
    var engTranslation: String
    
    init(ukrTerm ukr: String, engTerm eng: String) {
        ukrTranslation = ukr
        engTranslation = eng
    }
}
