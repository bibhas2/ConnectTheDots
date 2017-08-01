//
//  Player.swift
//  ConnectTheDots
//
//  Created by Bibhas Bhattacharya on 7/31/17.
//  Copyright © 2017 Bibhas Bhattacharya. All rights reserved.
//

import UIKit

class Player {
    let lineColor:UIColor
    let label:String
    var score = 0
    
    init(color:UIColor, label:String) {
        self.lineColor = color
        self.label = label
    }
}
