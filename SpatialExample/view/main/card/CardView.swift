import UIKit

class CardView:UIView{
   lazy var backgroundLayer:CALayer = createBackgroundLayer()
   lazy var maskLayer:CAShapeLayer = createMaskLayer()
   lazy var topBar:TopBar = createTopBar()
   lazy var cardContent:MiddleContent = createMiddleContent()
   lazy var bottomBar:BottomBar = createBottomBar()
   /**
    * We create UI elements in the layoutSubViews method since we need to access the .frame in these UI elements
    */
   override func layoutSubviews() {
      super.layoutSubviews()
      self.backgroundColor = .gray
      _ = backgroundLayer
      _ = maskLayer
      _ = topBar
      _ = cardContent
      _ = bottomBar
   }
}
