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
    
    var columns:Int!
    var rows:Int!
    var MARGIN_H:Double!
    var MARGIN_V:Double!
    
    required init?(coder aDecoder: NSCoder) {
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
    }
    
    func onTap(_ recognizer: UITapGestureRecognizer) {
        //recognizer.numberOfTouches
        let loc = recognizer.location(ofTouch: 0, in: self)
        
        print("\(loc.x) \(loc.y)")
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
        ctx.setStrokeColor(UIColor.black.cgColor)
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
                
                ctx.fillEllipse(in: circSize)
            }
        }
//        ctx.addEllipse(in: circSize)
//        ctx.strokePath()
//        ctx.strokeEllipse(in: circSize)
    }
}
