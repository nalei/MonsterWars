import SpriteKit
import GameplayKit

class Quirk: GKEntity {
  init(player: Player, entityManager: EntityManager) {
    super.init()
    let texture = SKTexture(imageNamed: "quirk\(player.rawValue)")
    let spriteComponent = SpriteComponent(texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, barOffset: texture.size().height/2, health: 15, entityManager: entityManager))
    addComponent(PlayerComponent(player: player))
    addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
