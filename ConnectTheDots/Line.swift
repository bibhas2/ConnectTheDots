//
//  Line.swift
//  ConnectTheDots
//
//  Created by Bibhas Bhattacharya on 7/31/17.
//  Copyright © 2017 Bibhas Bhattacharya. All rights reserved.
//

import UIKit

class Line {
    let start:CGPoint
    let end:CGPoint
    let hitRect:CGRect
    var filledBy:Player?
    
    init(start:CGPoint, end:CGPoint, hitRect:CGRect) {
        self.start = start
        self.end = end
        self.hitRect = hitRect
    }
}
