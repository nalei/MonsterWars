import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  var entities = [GKEntity]()
  var graphs = [String : GKGraph]()
  
  // Constants
  let margin = CGFloat(30)
  
  // Buttons
  var quirkButton: ButtonNode!
  var zapButton: ButtonNode!
  var munchButton: ButtonNode!
  
  // Labels
  let coin1Label = SKLabelNode(fontNamed: "Courier-Bold")
  let coin2Label = SKLabelNode(fontNamed: "Courier-Bold")
  
  // Update time
  var lastUpdateTimeInterval: TimeInterval = 0
  
  // Game over detection
  var gameOver = false
  
  // Music
  var backgroundMusic: SKAudioNode!
  
  override func sceneDidLoad() {
    
    // Start background music
    if let musicURL = Bundle.main.url(forResource: "Latin_Industries", withExtension: "mp3") {
      backgroundMusic = SKAudioNode(url: musicURL)
      addChild(backgroundMusic)
    }
    
//    let bgMusic = SKAudioNode(fileNamed: "Latin_Industries.mp3")
//    bgMusic.autoplayLooped = true
//    addChild(bgMusic)
    
    // Add background
    let background = SKSpriteNode(imageNamed: "background")
    background.size = CGSize(width: size.width, height: size.height)
    background.position = CGPoint(x: size.width/2, y: size.height/2)
    background.zPosition = -1
    addChild(background)
    
    // Add quirk button
    quirkButton = ButtonNode(iconName: "quirk1", text: "10", onButtonPress: quirkPressed)
    quirkButton.position = CGPoint(x: size.width * 0.25, y: margin + quirkButton.size.height / 2)
    addChild(quirkButton)
    
    // Add zap button
    zapButton = ButtonNode(iconName: "zap1", text: "25", onButtonPress: zapPressed)
    zapButton.position = CGPoint(x: size.width * 0.5, y: margin + zapButton.size.height / 2)
    addChild(zapButton)
    
    // Add munch button
    munchButton = ButtonNode(iconName: "munch1", text: "50", onButtonPress: munchPressed)
    munchButton.position = CGPoint(x: size.width * 0.75, y: margin + munchButton.size.height / 2)
    addChild(munchButton)
    
    // Add coin 1 indicator
    let coin1 = SKSpriteNode(imageNamed: "coin")
    coin1.position = CGPoint(x: margin + coin1.size.width/2, y: size.height - margin - coin1.size.height/2)
    addChild(coin1)
    coin1Label.fontSize = 50
    coin1Label.fontColor = SKColor.black
    coin1Label.position = CGPoint(x: coin1.position.x + coin1.size.width/2 + margin, y: coin1.position.y)
    coin1Label.zPosition = 1
    coin1Label.horizontalAlignmentMode = .left
    coin1Label.verticalAlignmentMode = .center
    coin1Label.text = "10"
    self.addChild(coin1Label)
    
    // Add coin 2 indicator
    let coin2 = SKSpriteNode(imageNamed: "coin")
    coin2.position = CGPoint(x: size.width - margin - coin1.size.width/2, y: size.height - margin - coin1.size.height/2)
    addChild(coin2)
    coin2Label.fontSize = 50
    coin2Label.fontColor = SKColor.black
    coin2Label.position = CGPoint(x: coin2.position.x - coin2.size.width/2 - margin, y: coin1.position.y)
    coin2Label.zPosition = 1
    coin2Label.horizontalAlignmentMode = .right
    coin2Label.verticalAlignmentMode = .center
    coin2Label.text = "10"
    self.addChild(coin2Label)
  }
  
  func quirkPressed() {
    print("Quirk pressed!")
  }
  
  func zapPressed() {
    print("Zap pressed!")
  }
  
  func munchPressed() {
    print("Munch pressed!")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }
    
    let touchLocation = touch.location(in: self)
    print("\(touchLocation)")
    
    if gameOver {}
  }
  
  func showRestartMenu(_ won: Bool) {
    if gameOver {
      return
    }
    
    gameOver = true
    
    let message = won ? "You win" : "You lose"
    
    let label = SKLabelNode(fontNamed: "Courier-Bold")
    label.fontSize = 100
    label.fontColor = SKColor.black
    label.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
    label.zPosition = 1
    label.verticalAlignmentMode = .center
    label.text = message
    label.setScale(0)
    addChild(label)
    
    let scaleAction = SKAction.scale(to: 1.0, duration: 0.5)
    scaleAction.timingMode = SKActionTimingMode.easeInEaseOut
    label.run(scaleAction)
  }
  
  override func update(_ currentTime: TimeInterval) {
    if gameOver {
      return
    }
  }
  
}
