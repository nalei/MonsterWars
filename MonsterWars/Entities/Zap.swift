import Foundation
import SpriteKit
import GameplayKit

class Zap: GKEntity {
  
  init(player: Player, entityManager: EntityManager) {
    super.init()
    let texture = SKTexture(imageNamed: "zap\(player.rawValue)")
    let spriteComponent = SpriteComponent(texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(texture.size().width / 2), entityManager: entityManager))
    addComponent(PlayerComponent(player: player))
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
