//
//  GameScene.swift
//  MadBirb
//
//  Created by Yasin Cengiz on 17.03.2020.
//  Copyright © 2020 MrYC. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameStarted = false
    var originalPosition : CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    var bird = SKSpriteNode()
    var bird2 = SKSpriteNode()
    
    var smallMonster = SKSpriteNode()
    var mediumMonster = SKSpriteNode()
    var bigMonster = SKSpriteNode()
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Monster = 2
    }
    
    override func didMove(to view: SKView) {
        
        // Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
        // Birds
        
        let birdTexture = SKTexture(imageNamed: "bird")
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 20)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Monster.rawValue
        
        
        let bird2Texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: bird2Texture)
        bird2.position = CGPoint(x: -535.217, y: -0.001)
        bird2.size = CGSize(width: self.frame.width / 12 , height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
        
        // Monsters

        let monsterTexture = SKTexture(imageNamed: "monster")
        let smallMediumSize = CGSize(width: monsterTexture.size().width / 15, height: monsterTexture.size().height / 12)
        let bigSize = CGSize(width: monsterTexture.size().width / 6, height: monsterTexture.size().height / 6)
        
        smallMonster = childNode(withName: "smallMonster") as! SKSpriteNode
        smallMonster.physicsBody = SKPhysicsBody(rectangleOf: smallMediumSize)
        smallMonster.physicsBody?.affectedByGravity = true
        smallMonster.physicsBody?.isDynamic = true
        smallMonster.physicsBody?.allowsRotation = true
        smallMonster.physicsBody?.mass = 0.1
        
        smallMonster.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        mediumMonster = childNode(withName: "mediumMonster") as! SKSpriteNode
        mediumMonster.physicsBody = SKPhysicsBody(rectangleOf: smallMediumSize)
        mediumMonster.physicsBody?.affectedByGravity = true
        mediumMonster.physicsBody?.isDynamic = true
        mediumMonster.physicsBody?.allowsRotation = true
        mediumMonster.physicsBody?.mass = 0.1
        
        mediumMonster.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        bigMonster = childNode(withName: "bigMonster") as! SKSpriteNode
        bigMonster.physicsBody = SKPhysicsBody(rectangleOf: bigSize)
        bigMonster.physicsBody?.affectedByGravity = true
        bigMonster.physicsBody?.isDynamic = true
        bigMonster.physicsBody?.allowsRotation = true
        bigMonster.physicsBody?.mass = 0.1
        
        bigMonster.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 2.7)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score += 1
            scoreLabel.text = "\(score)"
            
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

        
        
    }
    
    func touchUp(atPoint pos : CGPoint) {

        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
//        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
//        bird.physicsBody?.affectedByGravity = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1,
                birdPhysicsBody.velocity.dy <= 0.1,
                birdPhysicsBody.angularVelocity <= 0.1, gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                
                score = 0
                scoreLabel.text = "\(score)"
                
                gameStarted = false
                
            }
        }
        
    }
    
    
    
    
    
}
