import UIKit
import With
/**
 * UI elements
 */
extension CardView {
   /**
    * Creates topBar
    */
   func createTopBar() -> TopBar {
      with(.init()) {
         self.addSubview($0)
         $0.anchorAndSize(to: self, height: TopBar.topBarHeight)
      }
   }
   /**
    * Creates the middle card content view
    */
   func createMiddleContent() -> MiddleContent {
      with(.init()) {
         self.addSubview($0)
         let sizeOffset: CGSize = .init(width: 0, height: -(TopBar.topBarHeight + BottomBar.bottomBarHeight))
         $0.anchorAndSize(to: topBar, sizeTo: self, alignTo: .bottomLeft, sizeOffset: sizeOffset)
      }
   }
   /**
    * Creates bottomBar
    */
   func createBottomBar() -> BottomBar {
      with(.init()) {
         self.addSubview($0)
         $0.anchorAndSize(to: cardContent, sizeTo: self, height: BottomBar.bottomBarHeight, alignTo: .bottomLeft)
      }
   }
}
/**
 * Background & layer
 */
extension CardView {
   /**
    * Creates bg layer
    */
   func createBackgroundLayer() -> CALayer {
      let bgLayer: CALayer = {
         let layer = CALayer()
         layer.backgroundColor = UIColor.green.cgColor
         layer.frame = self.bounds//CGRect.init(x: CardView.margin.left, y: CardView.margin.top, width: self.frame.width - (CardView.margin.left + CardView.margin.right)  , height: self.frame.height - (CardView.margin.top + CardView.margin.bottom))
         return layer
      }()
      self.layer.insertSublayer(bgLayer, at: 0)/*⚠️️ We need to insert bg at 0, or else it is put above all views*/
      return bgLayer
   }
   /**
    * Creates and applies mask to view
    */
   func createMaskLayer() -> CAShapeLayer {
      let maskLayer = CAShapeLayer()
      let path: UIBezierPath = .init(roundedRect: self.bounds, cornerRadius: 24)
      maskLayer.path = path.cgPath
      self.layer.mask = maskLayer/*Applies the mask to the view*/
      return maskLayer
   }
}
