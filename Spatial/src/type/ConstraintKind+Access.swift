import UIKit

/**
 * Convenient extension methods for UIView
 * Definition: Convenience the state of being able to proceed with something without difficulty
 * TODO: ⚠️️ Make these methods for [uiview] as well
 */
extension ConstraintKind where Self:UIView{
   /**
    * Align and size a UIView instance
    * EXAMPLE: view.anchorAndSize(to:self,height:100,align:.center,alignTo:.center)//multiplier
    */
   public func anchorAndSize(to:UIView, width:CGFloat, height:CGFloat, align:Alignment, alignTo:Alignment, multiplier:CGSize, offset:CGPoint, useMargin:Bool){
      self.activateAnchorAndSize { view in
         let a = Constraint.anchor(self, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)
         let s = Constraint.size(self, to: to, width: width, height: height, offset: offset, multiplier: multiplier)
         return (a,s)
      }
   }
   /**
    * Align a UIView instance
    * EXAMPLE: view.anchor(to:self,align:.center,alignTo:.center)//offset
    */
   public func anchor(to:UIView, align:Alignment, alignTo:Alignment, offset:CGPoint = CGPoint(), useMargin:Bool = false){
      self.activateAnchor{ view in
         return Constraint.anchor(self, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)
      }
   }
   /**
    * Horizontally align a UIView instance
    */
   public func anchor(to:UIView, align:HorizontalAlign, alignTo:HorizontalAlign, offset:CGFloat = 0, useMargin:Bool = false) {
      self.activateConstraint { view in
         return [Constraint.anchor(view, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)]
      }
   }
   /**
    * Vertically align a UIView instance
    */
   public func anchor(to:UIView, align:VerticalAlign, alignTo:VerticalAlign, offset:CGFloat = 0, useMargin:Bool = false) {
      self.activateConstraint { view in
         return [Constraint.anchor(view, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)]
      }
   }
   /**
    * Size a UIView instance
    * EXAMPLE: view.size(to:self)//multiplier,offset
    */
   public func size(to:UIView, width:CGFloat, height:CGFloat, offset:CGPoint, multiplier:CGSize){
      self.activateSize { view in
         return Constraint.size(self, to: to, width: width, height: height, offset: offset, multiplier: multiplier)
      }
   }
}
