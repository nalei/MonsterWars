import SpriteKit
import GameplayKit

class MoveComponent: GKAgent2D, GKAgentDelegate {
  let entityManager: EntityManager

  init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
    self.entityManager = entityManager
    super.init()
    delegate = self
    self.maxSpeed = maxSpeed
    self.maxAcceleration = maxAcceleration
    self.radius = radius
    print(self.mass)
    self.mass = 0.01
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Прежде чем агент обновит позицию, устанавливаем агента в позицию спрайта
  func agentWillUpdate(_ agent: GKAgent) {
    guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
      return
    }

    position = simd_float2(spriteComponent.node.position)
  }
  
  /// После того, как агент обновит позицию, устанавливаем спрайт в позицию агента
  func agentDidUpdate(_ agent: GKAgent) {
    guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
      return
    }

    spriteComponent.node.position = CGPoint(position)
  }
  
  /// Поиск ближайшего MoveComponent среди компонентов конкретного игрока
  func closestMoveComponent(for player: Player) -> GKAgent2D? {
    var closestMoveComponent: MoveComponent? = nil
    var closestDistance = CGFloat(0)

    let enemyMoveComponents = entityManager.moveComponents(for: player)
    for enemyMoveComponent in enemyMoveComponents {
      let distance = (CGPoint(enemyMoveComponent.position) - CGPoint(position)).length()
      if closestMoveComponent == nil || distance < closestDistance {
        closestMoveComponent = enemyMoveComponent
        closestDistance = distance
      }
    }
    return closestMoveComponent
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    super.update(deltaTime: seconds)

    // PlayerComponent для текущего объекта
    guard let entity = entity, let playerComponent = entity.component(ofType: PlayerComponent.self) else {
        return
    }

    // Ближайший MoveComponent оппонента
    guard let enemyMoveComponent = closestMoveComponent(for: playerComponent.player.opponent) else {
      return
    }

    // Все MoveComponent союзников
    let alliedMoveComponents = entityManager.moveComponents(for: playerComponent.player)

    // Поведение
    behavior = MoveBehavior(targetSpeed: maxSpeed, seek: enemyMoveComponent, avoid: alliedMoveComponents)
  }
}
