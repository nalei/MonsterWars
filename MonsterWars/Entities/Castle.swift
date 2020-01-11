import SpriteKit
import GameplayKit

class Castle: GKEntity {
  init(imageName: String, player: Player, entityManager: EntityManager) {
    super.init()
    let texture = SKTexture(imageNamed: imageName)
    let spriteComponent = SpriteComponent(texture: texture, size: CGSize(width: 120, height: 120))
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: spriteComponent.node.size.width, barOffset: spriteComponent.node.size.height/2, health: 500, entityManager: entityManager))
    addComponent(MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(spriteComponent.node.size.width / 2), entityManager: entityManager))
    addComponent(PlayerComponent(player: player))
    addComponent(FiringComponent(range: 400, damage: 5, damageRate: 2.0, sound: SoundManager.sharedInstance.soundPew, entityManager: entityManager))
    addComponent(CastleComponent ())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
