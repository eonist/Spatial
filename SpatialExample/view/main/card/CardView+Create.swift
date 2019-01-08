import UIKit
import Spatial

extension CardView{
   static let margin:UIEdgeInsets = .init(top: 24, left: 12, bottom: 24, right: 12)
   /**
    * Creates bg layer
    */
   func createBackgroundLayer() -> CALayer{
      let bgLayer: CALayer = {
         let layer = CALayer()
         layer.backgroundColor = UIColor.green.cgColor
         layer.frame = self.frame//CGRect.init(x: CardView.margin.left, y: CardView.margin.top, width: self.frame.width - (CardView.margin.left + CardView.margin.right)  , height: self.frame.height - (CardView.margin.top + CardView.margin.bottom))
         //layer.cornerRadius = 24
         return layer
      }()
      self.layer.addSublayer(bgLayer)
      return bgLayer
   }
   /**
    * Creates and applies mask to view
    */
   func createMaskLayer() -> CAShapeLayer{
      let maskLayer = CAShapeLayer()
      let insetFrame:CGRect = {
         let origin:CGPoint = .init(x: CardView.margin.left, y: CardView.margin.top)
         let width = self.frame.width - (CardView.margin.left + CardView.margin.right)
         let height = self.frame.height - (CardView.margin.top + CardView.margin.bottom)
         return .init(origin:origin,size:.init(width:width,height:height))
      }()
      let path:UIBezierPath = .init(roundedRect: insetFrame, cornerRadius: 24)
      maskLayer.path = path.cgPath
      self.layer.mask = maskLayer/*applies the mask to the view*/
      return maskLayer
   }
   /**
    * Creates topBar
    */
   func createTopBar() -> TopBar{
      let topBar:TopBar = .init()
      self.addSubview(topBar)
      let offset = CGPoint(x:CardView.margin.left,y:CardView.margin.top)
      topBar.anchorAndSize(to: self, height: TopBar.topBarHeight, offset:offset )
      return topBar
   }
   /**
    * Creates the middle card content view
    */
   func createMiddleContent() -> MiddleContent{
      let middleContent:MiddleContent = .init()
      self.addSubview(middleContent)
      let w:CGFloat = /*self.frame.width */ (CardView.margin.left + CardView.margin.right)
      let h:CGFloat = /*self.frame.height*/ (TopBar.topBarHeight + BottomBar.bottomBarHeight + CardView.margin.top + CardView.margin.bottom)
      
      //Continue here: 🏀
         //add anchorTo:, sizeTo
      
      middleContent.anchorAndSize(to: topBar, alignTo: .bottomLeft, sizeOffset:.init(width:w,height:h))
      return middleContent
   }
   /**
    * Creates bottomBar
    */
   func createBottomBar() -> BottomBar {
      let bottomBar:BottomBar = .init()
      self.addSubview(bottomBar)
      bottomBar.anchorAndSize(to: cardContent, width: UIScreen.main.bounds.width, height: BottomBar.bottomBarHeight, alignTo: .bottomLeft)
      return bottomBar
   }
}
