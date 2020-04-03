//
//  GameScene.swift
//  jumping soonans
//
//  Created by 安部学 on 2020/03/26.
//  Copyright © 2020 Manabu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var mainCharNode:SKSpriteNode = SKSpriteNode(imageNamed: "P202_sonans.png")
    
    override func didMove(to view: SKView) {
        print("[debug] didMove - called")
        
        self.mainCharNode.alpha = 1 // 0 - 1
        self.mainCharNode.size = CGSize(width: 100,height: 100)
        self.mainCharNode.position = CGPoint(x: 200, y: view.frame.height / -2 + 50)
        self.addChild(mainCharNode)
        self.addMonbo()
        
//        self.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let movePos = CGPoint(x: self.mainCharNode.position.x, y: self.mainCharNode.position.y + 300)
        let jumpUpAction = SKAction.move(to: movePos, duration: 0.2)
        jumpUpAction.timingMode = .easeInEaseOut
        let jumpDownAction = SKAction.move(to: self.mainCharNode.position, duration: 0.2)
        
        let jumpAction = SKAction.sequence([jumpUpAction, jumpDownAction ])
        
        self.mainCharNode.run(jumpAction)
        
        //gameover
        
        if self.isGameOver() == true {
            let gameOverLabel = SKLabelNode()
            gameOverLabel.text = "Game Over"
            gameOverLabel.fontSize = 128
            gameOverLabel.fontColor = UIColor.red
            self.addChild(gameOverLabel)
        }
        
    }
    
    func isGameOver() -> Bool {
        
        if self.mainCharNode.position.y > self.view!.frame.height / 2 - 100 {
            return true
        }
        
        return false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
    
    func addMonbo(){
        let monbo = SKSpriteNode(imageNamed: "monbo.png")
        
        let yPosition = CGFloat(Int.random(in:0 ..< Int(self.view!.frame.height))) - (self.view!.frame.height / 2 )
            monbo.size = CGSize(width: 50,height: 50)
        monbo.position = CGPoint(
            x: self.view!.frame.width * -1,
            y: yPosition
            )
        self.addChild(monbo)
        let moveAction = SKAction.moveTo(x: self.view!.frame.width, duration: 2)
        monbo.run(moveAction)
        
        let monboAction = SKAction.run {
            
            self.addMonbo()
        }
        let newMonboAction = SKAction.sequence([SKAction.wait(forDuration: 1), monboAction])
        self.run(newMonboAction)
    }
}
