//
//  GameScene.swift
//  TapCars
//
//  Created by Phoom Punpeng on 5/4/18.
//  Copyright © 2018 Phoom Punpeng. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var touchCount: Int = 0
    var leftCar = SKSpriteNode()
    var rightCar = SKSpriteNode()
    var canMove = false
    var leftToMoveLeft = true
    var rightCarToMoveRight = true
    var leftCarAtRight = false
    var rightCarAtLeft = false
    var centerPoint : CGFloat!
    
    let leftCarMinimumX :CGFloat = -280
    let leftCarMaximumX :CGFloat = -100
    
    let rightCarMinimumX :CGFloat = 100
    let rightCarMaximumX :CGFloat = 200
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setUp()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(GameScene.createRoadStrip), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.removeItems), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if touchLocation.x > centerPoint {
                if rightCarAtLeft {
                    rightCarAtLeft = false
                    rightCarToMoveRight = true
                }
                else {
                    rightCarAtLeft = true
                    rightCarToMoveRight = false
                }
            }
            else {
                if leftCarAtRight {
                    leftCarAtRight = false
                    leftToMoveLeft = true
                }
                else {
                    leftCarAtRight = true
                    leftToMoveLeft = false
                }
            }
            canMove = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if canMove {
            move(leftSide:leftToMoveLeft)
        }
        showRoadStrip()
    }
    
    func setUp() {
        leftCar = self.childNode(withName: "leftCar") as! SKSpriteNode
        rightCar = self.childNode(withName: "rightCar") as! SKSpriteNode
        centerPoint = self.frame.size.width / self.frame.size.height
    }
    
    @objc func createRoadStrip() {
        let leftRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        leftRoadStrip.strokeColor = SKColor.white
        leftRoadStrip.fillColor = SKColor.white
        leftRoadStrip.alpha = 0.4
        leftRoadStrip.name = "leftRoadStrip"
        leftRoadStrip.zPosition = 10
        leftRoadStrip.position.x = -187.5
        leftRoadStrip.position.y = 700
        addChild(leftRoadStrip)
        
        let rightRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        rightRoadStrip.strokeColor = SKColor.white
        rightRoadStrip.fillColor = SKColor.white
        rightRoadStrip.alpha = 0.4
        rightRoadStrip.name = "rightRoadStrip"
        rightRoadStrip.zPosition = 10
        rightRoadStrip.position.x = 187.5
        rightRoadStrip.position.y = 700
        addChild(rightRoadStrip)
    }
    
    func showRoadStrip() {
        enumerateChildNodes(withName: "leftRoadStrip") { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        }
        enumerateChildNodes(withName: "rightRoadStrip") { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        }
    }
    
    @objc func removeItems() {
        for child in children {
            if child.position.y < -self.size.height - 15 {
                child.removeFromParent()
            }
        }
    }
    
    func move(leftSide:Bool) {
        if leftSide {
            leftCar.position.x -= 20
            if leftCar.position.x < leftCarMinimumX {
                leftCar.position.x = leftCarMinimumX
            }
        }
        else {
            leftCar.position.x += 20
            if leftCar.position.x > leftCarMaximumX {
                leftCar.position.x = leftCarMaximumX
            }
        }
    }
    func moveRightCar(rightSide:Bool) {
        if rightSide {
            rightCar.position.x += 20
            if rightCar.position.x > rightCarMaximumX {
                rightCar.position.x = rightCarMaximumX
            }
        }
        else {
            rightCar.position.x -= 20
            if rightCar.position.x < rightCarMinimumX {
                rightCar.position.x = rightCarMinimumX
            }
        }
    }
    
}
    

