import GameplayKit

enum MonsterType {
  case quirk
  case zap
  case munch

  static let allValues = [quirk, zap, munch]

}

class AiComponent: GKComponent {
  var nextMonster = MonsterType.quirk
  let entityManager: EntityManager
  
  init(entityManager: EntityManager) {
    self.entityManager = entityManager
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    // Get required components
    guard let playerComponent = entity?.component(ofType: PlayerComponent.self),
              let castleComponent = entity?.component(ofType: CastleComponent.self) else {
      return
    }
    
    if nextMonster == .quirk && castleComponent.coins >= costQuirk {
      entityManager.spawnQuirk(playerComponent.player)
      nextMonster = MonsterType.allValues[Int(arc4random()) % MonsterType.allValues.count]
    }
    if nextMonster == .zap && castleComponent.coins >= costZap {
      entityManager.spawnZap(playerComponent.player)
      nextMonster = MonsterType.allValues[Int(arc4random()) % MonsterType.allValues.count]
    }
  }
}
