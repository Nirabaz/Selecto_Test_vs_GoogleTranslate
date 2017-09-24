//
//  HistoryItem.swift
//  TestTask
//
//  Created by Nirabaz on 8/27/17.
//  Copyright © 2017 iMolodec. All rights reserved.
//

import Foundation

class HistoryItem: NSObject{
    var  date: String
    var words: String
    
    init(words w: String, date d: String){
        date = d
        words = w
    }
}
