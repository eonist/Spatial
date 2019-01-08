import UIKit
/**
 * Convenient extension methods for UIView
 * Definition: Convenience the state of being able to proceed with something without difficulty
 * TODO: ⚠️️ Make these methods for [UIView] as well
 */
extension UIView {
   /**
    * One-liner for activateAnchorAndSize (Align and size a UIView instance)
    * EXAMPLE: view.anchorAndSize(to:self,height:100,align:.center,alignTo:.center)//multiplier
    */
   public func anchorAndSize(to:UIView, width:CGFloat? = nil, height:CGFloat? = nil, align:Alignment = .topLeft, alignTo:Alignment = .topLeft, multiplier:CGSize = .init(width:1,height:1), offset:CGPoint = .zero, useMargin:Bool = false){
      self.activateAnchorAndSize { view in
         let a = Constraint.anchor(self, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)
         let s = Constraint.size(self, to: to, width: width, height: height, offset: offset, multiplier: multiplier)
         return (a,s)
      }
   }
   /**
    * One-liner for anchor (Align a UIView instance)
    * EXAMPLE: view.anchor(to:self,align:.center,alignTo:.center)//offset
    */
   public func anchor(to:UIView, align:Alignment = .topLeft, alignTo:Alignment = .topLeft, offset:CGPoint = .zero, useMargin:Bool = false){
      self.activateAnchor{ view in
         return Constraint.anchor(self, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)
      }
   }
   /**
    * Horizontally align a UIView instance
    */
   public func anchor(to:UIView, align:HorizontalAlign = .left, alignTo:HorizontalAlign = .left, offset:CGFloat = 0, useMargin:Bool = false) {
      self.activateConstraints { view in
         return [Constraint.anchor(view, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)]
      }
   }
   /**
    * Vertically align a UIView instance
    */
   public func anchor(to:UIView, align:VerticalAlign = .top, alignTo:VerticalAlign = .top, offset:CGFloat = 0, useMargin:Bool = false) {
      self.activateConstraints { view in
         return [Constraint.anchor(view, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)]
      }
   }
   /**
    * Size a UIView instance
    * EXAMPLE: view.size(to:self)//multiplier, offset
    */
   public func size(to:UIView, width:CGFloat? = nil, height:CGFloat? = nil, offset:CGPoint = .zero, multiplier:CGSize = .init(width:1,height:1)){
      self.activateSize { view in
         return Constraint.size(self, to: to, width: width, height: height, offset: offset, multiplier: multiplier)
      }
   }
}
