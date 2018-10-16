import UIKit
@testable import Spatial

/**
 * Create
 */
extension ViewController{
   /**
    * Creates main view
    */
   func createMainView() -> MainView{
      let screenSize:CGSize = {
         let size = UIScreen.main.bounds.size
         return CGSize(width:size.width/* - 24*/, height:size.height/* - 24*/)
      }()
      let view:MainView = MainView.init(frame: CGRect.init(origin: .zero, size: screenSize))
      self.view.addSubview(view)
      
      //Swift.print("screenSize:  \(screenSize)")
      view.activateConstraint { view in
         let size = Constraint.size(view, size: screenSize)
         let pos = Constraint.anchor(view, to: self.view, align: .topLeft, alignTo: .topLeft/*, offset:CGPoint.init(x: 12, y: 12)*/)
         return [pos.x,pos.y,size.w,size.h]
      }
      return view
   }
}
