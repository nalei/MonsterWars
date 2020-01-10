import SpriteKit
import GameplayKit

class Munch: GKEntity {
  
  init(player: Player, entityManager: EntityManager) {
    
    super.init()
    
    let texture = SKTexture(imageNamed: "munch\(player.rawValue)")
    let spriteComponent = SpriteComponent(texture: texture, size: texture.size())
    addComponent(spriteComponent)
    addComponent(HealthComponent(parentNode: spriteComponent.node, barWidth: texture.size().width, barOffset: texture.size().height/2, health: 75, entityManager: entityManager))
    addComponent(MoveComponent(maxSpeed: 50, maxAcceleration: 1, radius: Float(texture.size().width * 0.3), entityManager: entityManager))
    addComponent(PlayerComponent(player: player))
    addComponent(MeleeComponent(damage: 100, destroySelf: false, damageRate: 2.5, aoe: true, sound: SoundManager.sharedInstance.soundBigHit, entityManager: entityManager))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
