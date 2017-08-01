//
//  GameViewController.swift
//  ConnectTheDots
//
//  Created by Bibhas Bhattacharya on 7/31/17.
//  Copyright © 2017 Bibhas Bhattacharya. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameBoardDelegate {
    @IBOutlet weak var gameBoardView: GameBoardView!
    @IBOutlet weak var playerAScore: UILabel!
    @IBOutlet weak var playerBScore: UILabel!
    @IBOutlet weak var turnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameBoardView.delegate = self
        
        startNewGame(self)
    }

    func updateScore() {
        playerAScore.text = "\(gameBoardView.playerA.label): \(gameBoardView.playerA.score)"
        playerBScore.text = "\(gameBoardView.playerB.label): \(gameBoardView.playerB.score)"
        
        playerAScore.textColor = gameBoardView.playerA.lineColor
        playerBScore.textColor = gameBoardView.playerB.lineColor
    }
    
    @IBAction func startNewGame(_ sender: Any) {
        gameBoardView.newGame()

        updateScore()
        
        onPlayerTurn(player: gameBoardView.currentPlayer)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func onBoxFilled(box: Box) {
        updateScore()
    }
    
    func onPlayerTurn(player: Player) {
        turnLabel.textColor = player.lineColor
        turnLabel.text = "Go \(player.label)!"
    }
}
