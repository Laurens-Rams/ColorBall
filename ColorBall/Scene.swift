//
//  Scene.swift
//  ColorBall
//
//  Created by Emily Kolar on 7/11/17.
//  Copyright © 2017 Emily Kolar. All rights reserved.
//

import Foundation
import SpriteKit

class Scene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: properties
    
    let Circle = SKSpriteNode(imageNamed: "circle")
    
    let diameter = CGFloat(200.0)
    
    let smallDiameter = CGFloat(20)
    
    let turnspeed = Double.pi * 0.5
    
    var balls = [SKSpriteNode]()
    
    // MARK: lifecycle methods
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        backgroundColor = .white
        let startX = CGFloat((size.width / 2))
        let startY = CGFloat((size.height / 2))
        let startpos = CGPoint(x: startX, y: startY)
        Circle.position = startpos
        Circle.size = CGSize(width: diameter, height: diameter)
        let body = SKPhysicsBody(circleOfRadius: diameter / 2)
        body.categoryBitMask = 0b10
        body.angularDamping = 0
        body.allowsRotation = true
        body.pinned = true
        body.restitution = 0
        Circle.physicsBody = body
        Circle.name = "Circle"
        addChild(Circle)
        createActions()
        addBall()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == 0b10 && secondBody.categoryBitMask != 0b1 {
            print("Hit player's ball. First contact has been made.")
            let pin = SKPhysicsJointFixed.joint(withBodyA: firstBody, bodyB: secondBody, anchor: contact.contactPoint)
            physicsWorld.add(pin)
        }
    }
    
    func addBall() {
        let ballImage = randomImageName()
        let newBall = SKSpriteNode(imageNamed: ballImage)
        newBall.size = CGSize(width: smallDiameter, height: smallDiameter)
        newBall.position = CGPoint(x: size.width / 2, y: size.height)
        
        let body = SKPhysicsBody(circleOfRadius: smallDiameter / 2)
        body.categoryBitMask = 0b1
        body.contactTestBitMask = 0b10
        body.allowsRotation = true
        body.angularDamping = 0
        body.restitution = 0
        newBall.physicsBody = body
        addChild(newBall)
        balls.append(newBall)
    }

    
    
    // MARK: class methods
    
    // a function to return a random image name
    func randomImageName() -> String {
         return "ball-\(arc4random_uniform(4) + 1)"
    }
    
    // a function to spin everything
    func createActions() {
        let rotation = SKAction.rotate(byAngle: CGFloat(turnspeed), duration: TimeInterval(1.0))
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(rotation, onChildWithName: "Circle"),
                SKAction.wait(forDuration: TimeInterval(1.0))
            ])
        ))
    }
    
    // a function to test collisions (did the balls hit each other?)

    
    
    
    // MARK: actions
    
    
}
