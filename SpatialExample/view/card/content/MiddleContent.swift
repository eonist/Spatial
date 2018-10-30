
import UIKit
import Spatial

class MiddleContent:UIView{
   /*UI*/
   lazy var itemViews:[ItemView] = createItemViews()
   override init(frame: CGRect) {
      super.init(frame: frame)
//      self.layer.cornerRadius = 24
      self.backgroundColor = .yellow
      _ = itemViews
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

//try labels 👈
extension MiddleContent{
   /**
    * Create items
    */
   func createItemViews() -> [ItemView] {
      Swift.print("createItemViews: \(self.frame)")
      let size:CGSize = CGSize.init(width: self.frame.width, height: 48)
      let itemViews:[ItemView] = (0..<5).indices.map{ i in
         let itemView = ItemView.init(frame: .zero)//.init(origin: .zero, size: size)
         self.addSubview(itemView)
         return itemView
      }
      itemViews.activateConstraint { views in /*All vertically centered, 48p height each*/
         let anchors = Constraint.distribute(vertically: views, align: .topLeft)
         let sizes = views.map{Constraint.size($0, size: size)}
         return (anchors, sizes)
      }
//      Swift.print("itemViews:  \(itemViews)")
      return itemViews
   }
}
class ItemView:UIView{
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .purple
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

