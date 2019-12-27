import SpriteKit
import GameplayKit

class Zap: GKEntity {
  init(player: Player, entityManager: EntityManager) {
    super.init()
    let texture = SKTexture(imageNamed: "zap\(player.rawValue)")
    let spriteComponent = SpriteComponent(texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, barOffset: texture.size().height/2, health: 10, entityManager: entityManager))
    addComponent(PlayerComponent(player: player))
    addComponent(MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(texture.size().width / 2), entityManager: entityManager))
    addComponent(FiringComponent(range: 500, damage: 5, damageRate: 1.5, sound: SoundManager.sharedInstance.soundPew, entityManager: entityManager))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
