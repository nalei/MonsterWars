import Foundation
import SpriteKit

class ButtonNode : SKSpriteNode {
  
  let onButtonPress: () -> ()
  
  init(iconName: String, text: String, onButtonPress: @escaping () -> ()) {
    
    self.onButtonPress = onButtonPress
    
    let texture = SKTexture(imageNamed: "button")
    super.init(texture: texture, color: SKColor.white, size: texture.size())
    
    let icon = SKSpriteNode(imageNamed: iconName)
    icon.position = CGPoint(x: -size.width * 0.25, y: 0)
    icon.zPosition = 1
    self.addChild(icon)
    
    let label = SKLabelNode(fontNamed: "Courier-Bold")
    label.fontSize = 50
    label.fontColor = SKColor.black
    label.position = CGPoint(x: size.width * 0.25, y: 0)
    label.zPosition = 1
    label.verticalAlignmentMode = .center
    label.text = text
    self.addChild(label)
    
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.texture = SKTexture(imageNamed: "button_sel")
    onButtonPress()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.texture = SKTexture(imageNamed: "button")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
