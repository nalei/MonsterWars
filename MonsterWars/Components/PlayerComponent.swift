import SpriteKit
import GameplayKit

enum Player: Int {
  case player1 = 1
  case player2 = 2

  static let allValues = [player1, player2]
  
  var opponent: Player {
    switch self {
    case .player1:
      return .player2
    case .player2:
      return .player1
    }
  }
}

class PlayerComponent: GKComponent {
  let player: Player

  init(player: Player) {
    self.player = player
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
