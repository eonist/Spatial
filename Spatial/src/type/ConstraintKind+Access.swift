#if os(iOS)
import UIKit
/**
 * Update constraints (For items that are of type ConstraintKind)
 * NOTE: adding a method called activateConstraints doesn't make any sense because you have only anchor and size or either
 */
public extension ConstraintKind where Self:UIView{
   /**
    * One-liner for applyAnchorAndSize
    */
   public func applyAnchorAndSize(to:UIView, width:CGFloat? = nil, height:CGFloat? = nil, align:Alignment = .topLeft, alignTo:Alignment = .topLeft, multiplier:CGSize = .init(width:1,height:1), offset:CGPoint = .zero, useMargin:Bool = false) {
      self.applyAnchorAndSize { view in
         let anchor = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft,useMargin:useMargin)
         let size = Constraint.size(self, to:to, width: width, height: height, offset: offset, multiplier: multiplier)
         return (anchor, size)
      }
   }
   /**
    * One-liner for applyAnchor
    */
   public func applyAnchor(to:UIView, align:Alignment = .topLeft, alignTo:Alignment = .topLeft, offset:CGPoint = .zero, useMargin:Bool = false)  {
      self.applyAnchor { view in
         return Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft,useMargin:useMargin)
      }
   }
   /**
    * One-liner for applySize
    */
   public func applySize(to:UIView, width:CGFloat? = nil, height:CGFloat? = nil, offset:CGPoint = .zero, multiplier:CGSize = .init(width:1,height:1)) {
      self.activateSize { view in
         return Constraint.size(self, to:to, width: width, height: height, offset: offset, multiplier: multiplier)
      }
   }
}
#endif
