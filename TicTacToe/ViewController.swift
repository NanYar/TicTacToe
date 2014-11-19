//
//  ViewController.swift
//  TicTacToe
//
//  Created by NanYar on 19.11.14.
//  Copyright (c) 2014 NanYar. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // @IBOutlets
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    // Properties
    var goNumber = 1 // Null (nought) faengt an
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 = empty, 1 = nought, 2 = cross
    var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]] // = 3 horizontal + 3 verikal + 2 diagonal
    var winner = 0 // 0= keiner, 1 = nought, 2 = cross
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        label.center = CGPointMake(label.center.x - 400, label.center.y)
        playAgainButton.alpha = 0
    }
    

    // @IBActions
    @IBAction func buttonPressed(sender: UIButton)
    {
        if gameState[sender.tag] == 0 && winner == 0
        {
            var image = UIImage()
            
            if goNumber % 2 == 0 // goNumber ist gerade
            {
                image = UIImage(named: "cross.png")!
                gameState[sender.tag] = 2
            }
            else // goNumber = ungerade
            {
                image = UIImage(named: "nought.png")!
                gameState[sender.tag] = 1
            }
            
            for combination in winningCombinations
            {
                if gameState[combination[0]] == gameState[combination[1]] &&
                   gameState[combination[0]] == gameState[combination[2]] &&
                   gameState[combination[0]] != 0
                {
                    winner = gameState[combination[0]]
                }
            }
            
            if winner != 0
            {
                if winner == 1
                {
                    label.text = "Noughts has won!"
                }
                else
                {
                    label.text = "Crosses has won!"
                }
                
                UIView.animateWithDuration(0.5, animations:
                {
                    self.label.hidden = false
                    self.label.center = CGPointMake(self.label.center.x + 400, self.label.center.y)
                    self.playAgainButton.alpha = 1
                }
                )
            }           
            
            goNumber++
            sender.setImage(image, forState: UIControlState.Normal)
            
            if goNumber == 10 && winner == 0
            {
                label.text = "No winner!"
                UIView.animateWithDuration(0.5, animations:
                {
                    self.label.hidden = false
                    self.label.center = CGPointMake(self.label.center.x + 400, self.label.center.y)
                    self.playAgainButton.alpha = 1
                }
                )
            }
        }
    }
    
    @IBAction func playAgainButtonPressed(sender: UIButton)
    {
        goNumber = 1
        winner = 0
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        label.center = CGPointMake(label.center.x - 400, label.center.y)
        label.hidden = true
        playAgainButton.alpha = 0
        
        var button: UIButton
        
        for var i = 0; i < 9; i++
        {
            button = view.viewWithTag(i) as UIButton
            button.setImage(nil, forState: UIControlState.Normal)
        }
    }

}
