//
//  GameBoardDelegate.swift
//  ConnectTheDots
//
//  Created by Bibhas Bhattacharya on 8/1/17.
//  Copyright © 2017 Bibhas Bhattacharya. All rights reserved.
//

import Foundation

protocol GameBoardDelegate : class {
    func onPlayerTurn(player:Player)
    func onBoxFilled(box:Box)
}
