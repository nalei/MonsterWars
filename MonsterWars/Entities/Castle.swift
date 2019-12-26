import SpriteKit
import GameplayKit

class Castle: GKEntity {
  
  init(imageName: String, player: Player, entityManager: EntityManager) {
    super.init()
    let texture = SKTexture(imageNamed: imageName)
    let spriteComponent = SpriteComponent(texture: texture)
    addComponent(spriteComponent)
    addComponent(PlayerComponent(player: player))
    addComponent(CastleComponent ())
    addComponent(MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(spriteComponent.node.size.width / 2), entityManager: entityManager))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
