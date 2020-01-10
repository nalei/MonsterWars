import SpriteKit
import GameplayKit

class Laser: GKEntity {
  init(player: Player, damage: CGFloat, entityManager: EntityManager) {
    super.init()
    let texture = SKTexture(imageNamed: "laser\(player.rawValue)")
    addComponent(SpriteComponent(texture: texture, size: texture.size()))
    addComponent(MeleeComponent(damage: damage, destroySelf: true, damageRate: 1.0, aoe: false, sound: SoundManager.sharedInstance.soundSmallHit, entityManager: entityManager))
    addComponent(PlayerComponent(player: player))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
