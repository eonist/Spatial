import UIKit
import Spatial
extension MainView{
   /**
    * Create the FlowView
    */
   func createCardView() -> CardView{
      let screenSize:CGSize = self.frame.size
      let view:CardView = CardView.init(frame: .init(origin: .zero, size: screenSize))
      self.addSubview(view)
      view.activateAnchorAndSize { view in
         let s = Constraint.size(view, size: screenSize)
         let a = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft)
         return (a,s)
      }
      return view
   }
   /**
    * Create spacing test view
    */
   func createSpacingTestView() -> SpacingTestView{
      let view:SpacingTestView = .init()
      self.addSubview(view)
      view.backgroundColor = .green
      view.anchorAndSize(to: self)
      return view
   }
}
