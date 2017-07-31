//
//  Box.swift
//  ConnectTheDots
//
//  Created by Bibhas Bhattacharya on 7/31/17.
//  Copyright © 2017 Bibhas Bhattacharya. All rights reserved.
//

import Foundation

class Box {
    let row:Int
    let column:Int
    
    let top:Line
    let right:Line
    let bottom:Line
    let left:Line
    
    var completedBy:Player?
    
    init(row:Int, column:Int, top:Line, right:Line, bottom:Line, left:Line) {
        self.row = row
        self.column = column
        
        self.top = top
        self.right = right
        self.bottom = bottom
        self.left = left
    }
}
