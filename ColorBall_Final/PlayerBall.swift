//
//  PlayerBall.swift
//  ColorBall_Final
//
//  Created by Emily Kolar on 7/10/17.
//  Copyright © 2017 Laurens-Art Ramsenthaler. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerBall: SKSpriteNode {
    
    convenience init() {
        let texture = SKTexture(imageNamed: "YellowBall")
        let size = CGSize(width: 200.0, height: 200.0)
        self.init(texture: texture, color: UIColor.clear, size: size)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
