import SpriteKit
import GameplayKit

class Quirk: GKEntity {

  init(player: Player, entityManager: EntityManager) {
    super.init()
    let texture = SKTexture(imageNamed: "quirk\(player.rawValue)")
    addComponent(SpriteComponent(texture: texture))
    addComponent(PlayerComponent(player: player))
    addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
