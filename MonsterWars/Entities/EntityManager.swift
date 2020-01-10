import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
  let scene: SKScene
  var entities = Set<GKEntity>()
  var toRemove = Set<GKEntity>()
  
  lazy var componentSystems: [GKComponentSystem] = {
    let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
    let castleSystem = GKComponentSystem(componentClass: CastleComponent.self)
    let meleeSystem = GKComponentSystem(componentClass: MeleeComponent.self)
    let firingSystem = GKComponentSystem(componentClass: FiringComponent.self)
    let aiSystem = GKComponentSystem(componentClass: AiComponent.self)
    return [moveSystem, castleSystem, meleeSystem, firingSystem, aiSystem]
  }()
  
  init(scene: SKScene) {
    self.scene = scene
  }
  
  func add(_ entity: GKEntity) {
    entities.insert(entity)
    
    if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
      scene.addChild(spriteNode)
    }
    
    for componentSystem in componentSystems {
      componentSystem.addComponent(foundIn: entity)
    }
  }
  
  func remove(_ entity: GKEntity) {
    if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
      spriteNode.removeFromParent()
    }
    
    entities.remove(entity)
    toRemove.insert(entity)
  }
  
  /// Возвращает Castle entity для конкретного игрока
  func castleForPlayer(_ player: Player) -> GKEntity? {
    for entity in entities {
      if let playerComponent = entity.component(ofType: PlayerComponent.self), let _ = entity.component(ofType: CastleComponent.self) {
        if playerComponent.player == player {
          return entity
        }
      }
    }
    return nil
  }
  
  /// Возвращает все MoveComponent для конкретного игрока
  func moveComponentsForPlayer(_ player: Player) -> [MoveComponent] {
    let entitiesToMove = entitiesForPlayer(player)
    var moveComponents = [MoveComponent]()
    for entity in entitiesToMove {
      if let moveComponent = entity.component(ofType: MoveComponent.self) {
        moveComponents.append(moveComponent)
      }
    }
    return moveComponents
  }
  
  /// Возвращает все GKEntity для конкретного игрока
  func entitiesForPlayer(_ player: Player) -> [GKEntity] {
    return entities.compactMap{ entity in
      if let playerComponent = entity.component(ofType: PlayerComponent.self) {
        if playerComponent.player == player {
          return entity
        }
      }
      return nil
    }
  }
  
  func update(_ deltaTime: CFTimeInterval) {
    for componentSystem in componentSystems {
      componentSystem.update(deltaTime: deltaTime)
    }
    
    for currentRemove in toRemove {
      for componentSystem in componentSystems {
        componentSystem.removeComponent(foundIn: currentRemove)
      }
    }
    toRemove.removeAll()
  }
  
  func spawnQuirk(_ player: Player) {
    guard let teamEntity = castleForPlayer(player),
      let teamCastleComponent = teamEntity.component(ofType: CastleComponent.self),
      let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
        return
    }
    
    if teamCastleComponent.coins < costQuirk {
      return
    }
    
    teamCastleComponent.coins -= costQuirk
    scene.run(SoundManager.sharedInstance.soundSpawn)
    
    let monster = Quirk(player: player, entityManager: self)
    if let spriteComponent = monster.component(ofType: SpriteComponent.self) {
      spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
      spriteComponent.node.zPosition = 2
    }
    self.add(monster)
  }
  
  func spawnZap(_ player: Player) {
    guard let teamEntity = castleForPlayer(player),
      let teamCastleComponent = teamEntity.component(ofType: CastleComponent.self),
      let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
        return
    }
    
    if teamCastleComponent.coins < costZap {
      return
    }
    
    teamCastleComponent.coins -= costZap
    scene.run(SoundManager.sharedInstance.soundSpawn)
    
    let monster = Zap(player: player, entityManager: self)
    if let spriteComponent = monster.component(ofType: SpriteComponent.self) {
      spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
      spriteComponent.node.zPosition = 2
    }
    add(monster)
  }
  
  func spawnMunch(_ player: Player) {
    guard let teamEntity = castleForPlayer(player),
      let teamCastleComponent = teamEntity.component(ofType: CastleComponent.self),
      let teamSpriteComponent = teamEntity.component(ofType: SpriteComponent.self) else {
        return
    }
    
    if teamCastleComponent.coins < costMunch {
      return
    }
    
    teamCastleComponent.coins -= costMunch
    scene.run(SoundManager.sharedInstance.soundSpawn)
    
    let monster = Munch(player: player, entityManager: self)
    if let spriteComponent = monster.component(ofType: SpriteComponent.self) {
      spriteComponent.node.position = CGPoint(x: teamSpriteComponent.node.position.x, y: CGFloat.random(min: scene.size.height * 0.25, max: scene.size.height * 0.75))
      spriteComponent.node.zPosition = 2
    }
    add(monster)
  }
}
