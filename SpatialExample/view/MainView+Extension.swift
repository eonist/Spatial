
import UIKit
@testable import Spatial

extension MainView{
   /**
    * Create the FlowView
    */
   func createCardView() -> CardView{
      let screenSize:CGSize = self.frame.size
      let view:CardView = CardView.init(frame: CGRect.init(origin: .zero, size: screenSize))
      self.addSubview(view)
      
      Swift.print("screenSize:  \(screenSize)")
      view.activateConstraint { view in
         let size = Constraint.size(view, size: screenSize)
         let pos = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft)
         return [pos.x,pos.y,size.w,size.h]
      }
      return view
   }
}
