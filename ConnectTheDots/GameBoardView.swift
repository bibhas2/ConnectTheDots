//
//  GameBoardView.swift
//  ConnectTheDots
//
//  Created by Bibhas Bhattacharya on 7/31/17.
//  Copyright © 2017 Bibhas Bhattacharya. All rights reserved.
//

import UIKit

class GameBoardView: UIView {
    static let DOT_RAD = 2.0
    static let BOX_SIZE = 50.0
    static let MIN_MARGIN = 20.0
    static let HIT_MARGIN = 10.0
    
    let playerA = Player(color: UIColor.blue, label: "A")
    let playerB = Player(color: UIColor.red, label: "B")
    
    var columns:Int!
    var rows:Int!
    var MARGIN_H:Double!
    var MARGIN_V:Double!
    var boxes = [Box]()
    var lines = [Line]()
    var currentPlayer:Player
    var lastFilledLine:Line?
    
    required init?(coder aDecoder: NSCoder) {
        currentPlayer = playerA

        super.init(coder: aDecoder)
        
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(onTap(_:))))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rect = self.bounds
        
        let availWidth = Double(rect.width) - GameBoardView.MIN_MARGIN * 2.0
        let availHeight = Double(rect.height) - GameBoardView.MIN_MARGIN * 2.0
        
        columns = Int((availWidth / GameBoardView.BOX_SIZE).rounded(.down))
        rows = Int((availHeight / GameBoardView.BOX_SIZE).rounded(.down))
        
        MARGIN_H = (Double(rect.width) - Double(self.columns) * GameBoardView.BOX_SIZE) / 2.0
        MARGIN_V = (Double(rect.height) - Double(self.rows) * GameBoardView.BOX_SIZE) / 2.0
        
        //Horizontal lines
        for r in 0...rows {
            for c in 0..<columns {
                let startX = GameBoardView.BOX_SIZE * Double(c) + MARGIN_H
                let startY = GameBoardView.BOX_SIZE * Double(r) + MARGIN_V
                let endX = GameBoardView.BOX_SIZE * Double(c + 1) + MARGIN_H
                let hitRect = CGRect(x: startX - GameBoardView.HIT_MARGIN,
                                     y: startY - GameBoardView.HIT_MARGIN,
                                     width: GameBoardView.BOX_SIZE + 2.0 * GameBoardView.HIT_MARGIN,
                                     height: 2.0 * GameBoardView.HIT_MARGIN)
                lines.append(Line(
                    start: CGPoint(x:startX, y:startY),
                    end: CGPoint(x:endX, y:startY),
                    hitRect: hitRect))
            }
        }
        //Vertical lines
        for r in 0..<rows {
            for c in 0...columns {
                let startX = GameBoardView.BOX_SIZE * Double(c) + MARGIN_H
                let startY = GameBoardView.BOX_SIZE * Double(r) + MARGIN_V
                let endY = GameBoardView.BOX_SIZE * Double(r + 1) + MARGIN_V
                let hitRect = CGRect(x: startX - GameBoardView.HIT_MARGIN,
                                     y: startY - GameBoardView.HIT_MARGIN,
                                     width: 2.0 * GameBoardView.HIT_MARGIN,
                                     height: GameBoardView.BOX_SIZE + 2.0 * GameBoardView.HIT_MARGIN)

                lines.append(Line(
                    start: CGPoint(x:startX, y:startY),
                    end: CGPoint(x:startX, y:endY),
                    hitRect:hitRect))
            }
        }
        
        for r in 0..<rows {
            for c in 0..<columns {
                let box = Box(
                    row: r,
                    column: c,
                    top: lines[r * columns + c],
                    right: lines[(rows + 1) * columns + (r * (columns + 1) + c + 1)],
                    bottom: lines[(r + 1) * columns + c],
                    left: lines[(rows + 1) * columns + (r * (columns + 1) + c)])
                
                boxes.append(box)
            }
        }
    }
    
    func onTap(_ recognizer: UITapGestureRecognizer) {
        let loc = recognizer.location(ofTouch: 0, in: self)
        
        for box in boxes {
            let boxHitRect = box.hitRect(board: self)
            
            if boxHitRect.contains(loc) {
                var selectedLine:Line?
                var rowOffset = 0
                var colOffset = 0
                
                if box.top.hitRect.contains(loc) {
//                    print("Top")
                    selectedLine = box.top
                    rowOffset = -1
                } else if box.right.hitRect.contains(loc) {
//                    print("Right")
                    selectedLine = box.right
                    colOffset = 1
                } else if box.bottom.hitRect.contains(loc) {
//                    print("Bottom")
                    selectedLine = box.bottom
                    rowOffset = 1
                } else if box.left.hitRect.contains(loc) {
//                    print("Left")
                    selectedLine = box.left
                    colOffset = -1
                }
                
                if let selectedLine = selectedLine {
                    if selectedLine.filledBy == nil {
                        if let lastLine = lastFilledLine {
                            self.setNeedsDisplay(lastLine.hitRect)
                        }
                        
                        lastFilledLine = selectedLine
                        
                        var boxCompleted = false
                        
                        if box.numberOfLinesFilled() == 3 {
                            //This will fill the box
                            box.completedBy = currentPlayer
                            boxCompleted = true
                            
                            self.setNeedsDisplay(boxHitRect)
                        }
                        
                        //See if the neighbor got filled also
                        if (rowOffset != 0 || colOffset != 0) {
                            let neighborRow = box.row + rowOffset
                            let neighborCol = box.column + colOffset
                            
                            if neighborRow >= 0 && neighborRow < rows && neighborCol >= 0 && neighborCol < columns {
                                let neighbor = boxes[neighborRow * columns + neighborCol]
                                
                                if neighbor.numberOfLinesFilled() == 3 {
                                    //Neighbor also will get filled
                                    neighbor.completedBy = currentPlayer

                                    boxCompleted = true

                                    self.setNeedsDisplay(neighbor.hitRect(board: self))
                                }
                            }
                        }
                        
                        selectedLine.filledBy = currentPlayer
                        
                        self.setNeedsDisplay(selectedLine.hitRect)
                        
                        //Set the next current player
                        if !boxCompleted {
                            currentPlayer = currentPlayer === playerA ? playerB : playerA
                            
                            print("Player now: \(currentPlayer.label)")
                        }
                    }
                }
                
                break
            }
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctx.setFillColor(UIColor.black.cgColor)
        ctx.setLineWidth(2)

        for posY in 0...self.rows {
            for posX in 0...self.columns {
                let centerX = MARGIN_H + GameBoardView.BOX_SIZE * Double(posX)
                let centerY = MARGIN_V + GameBoardView.BOX_SIZE * Double(posY)
                
                let circSize = CGRect(x: centerX - GameBoardView.DOT_RAD,
                                      y: centerY - GameBoardView.DOT_RAD,
                                      width: GameBoardView.DOT_RAD * 2,
                                      height: GameBoardView.DOT_RAD * 2)
                
                ctx.addEllipse(in: circSize)
            }
        }
        
        ctx.fillPath()

        for box in boxes {
            if let completedBy = box.completedBy {
                ctx.setFillColor(completedBy.lineColor.cgColor)
                ctx.fill(box.rect(board: self))
            }
        }
        
        ctx.setStrokeColor(UIColor.black.cgColor)
        
        for line in lines {
            if let _ = line.filledBy {
                ctx.move(to: line.start)
                ctx.addLine(to: line.end)

            }
        }

        ctx.strokePath()
        
        if let lastLine = lastFilledLine {
            ctx.setStrokeColor(lastLine.filledBy!.lineColor.cgColor)
            
            ctx.move(to: lastLine.start)
            ctx.addLine(to: lastLine.end)
            
            ctx.strokePath()
        }
    }
}
