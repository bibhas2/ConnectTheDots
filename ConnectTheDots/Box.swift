//
//  Box.swift
//  ConnectTheDots
//
//  Created by Bibhas Bhattacharya on 7/31/17.
//  Copyright © 2017 Bibhas Bhattacharya. All rights reserved.
//

import UIKit

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
    
    func numberOfLinesFilled() -> Int {
        return
            (top.filledBy == nil ? 0 : 1) +
            (right.filledBy == nil ? 0 : 1) +
            (bottom.filledBy == nil ? 0 : 1) +
            (left.filledBy == nil ? 0 : 1)
    }
    
    func hitRect(board:GameBoardView) -> CGRect {
        let topX = GameBoardView.BOX_SIZE * Double(self.column) + board.MARGIN_H
        let topY = GameBoardView.BOX_SIZE * Double(self.row) + board.MARGIN_V
        
        return CGRect(x: topX - GameBoardView.HIT_MARGIN,
                      y: topY - GameBoardView.HIT_MARGIN,
                      width: GameBoardView.BOX_SIZE +  2.0 * GameBoardView.HIT_MARGIN,
                      height: GameBoardView.BOX_SIZE +  2.0 * GameBoardView.HIT_MARGIN)
    }

    func rect(board:GameBoardView) -> CGRect {
        let topX = GameBoardView.BOX_SIZE * Double(self.column) + board.MARGIN_H
        let topY = GameBoardView.BOX_SIZE * Double(self.row) + board.MARGIN_V
        
        return CGRect(x: topX,
                      y: topY,
                      width: GameBoardView.BOX_SIZE,
                      height: GameBoardView.BOX_SIZE)
    }
}
