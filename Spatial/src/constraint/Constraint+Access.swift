import UIKit
/**
 * Convenient extension methods for UIView (One-liners)
 * Definition: Convenience the state of being able to proceed with something without difficulty
 * TODO: ⚠️️ Make these methods for [UIView] as well
 * TODO: Rename Constraint+Access to something more meaningful
 */
extension UIView {
   /**
    * One-liner for activateAnchorAndSize (Align and size a UIView instance)
    * - Parameter to: anchor to this view
    * - Parameter sizeTo: provide this if you need to base the size on another view
    * - Parameter width: provide this if you want to use a fixed width
    * - Parameter height: provide this if you want to use a fixed height
    * - Parameter align: alignment for the `to` view
    * - Parameter alignTo: alignment for the `sizeTo` view, if one was provided
    * - Parameter multiplier: multiplies the `size` or `sizeTo`
    * - Parameter offset: offset for the `to` parameter
    * - Parameter sizeOffset: offset for the `sizeTo` parameter (use negative values for inset)
    * - Parameter useMargin: aligns to autolayout margins or not
    * ## Examples:
    * view.anchorAndSize(to:self,height:100,align:.center,alignTo:.center)//multiplier
    */
   public func anchorAndSize(to:UIView, sizeTo:UIView? = nil, width:CGFloat? = nil, height:CGFloat? = nil, align:Alignment = .topLeft, alignTo:Alignment = .topLeft, multiplier:CGSize = .init(width:1,height:1), offset:CGPoint = .zero, sizeOffset:CGSize = .zero, useMargin:Bool = false){
      self.activateAnchorAndSize { view in
         let a = Constraint.anchor(self, to: to, align: align, alignTo: alignTo, offset: offset, useMargin: useMargin)
         let s:SizeConstraint = {
            if let width = width, let height = height {/*This method exists when you have size, but don't want to set size based on another view*/
               return Constraint.size(self, size: CGSize(width:width,height:height), multiplier: multiplier)
            }else {
               return Constraint.size(self, to: sizeTo ?? to, width: width, height: height, offset: sizeOffset, multiplier: multiplier)
            }
         }()
         return (a,s)
      }
   }
   /**
    * One-liner for anchor (Align a UIView instance)
    * ## Examples:
    * view.anchor(to:self,align:.center,alignTo:.center)
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
    * ## Examples:
    * view.size(to:self)
    * - ToDo: ⚠️️ Maybe the to could be optional, 
    */
   public func size(to:UIView, width:CGFloat? = nil, height:CGFloat? = nil, offset:CGSize = .zero, multiplier:CGSize = .init(width:1,height:1)){
      self.activateSize { view in
         return Constraint.size(self, to: to, width: width, height: height, offset: offset, multiplier: multiplier)
      }
   }
   /**
    * Size a UIView instance to a peccific size
    * - ToDo: ⚠️️ This doesn't have offset, maybe it should 🤔 for now I guess you can always inset the size
    * ## Examples:
    * view.size(width:100,height:100)
    */
   public func size(width:CGFloat, height:CGFloat, multiplier:CGSize = .init(width:1,height:1)) {
      self.activateSize { view in
         return Constraint.size(self, size:.init(width:0,height:0), multiplier:multiplier)
      }
   }
}
/**
 * One-liner for multiple views
 */
public extension Array where Element:UIView{
   /**
    * Anchoring for an array of views
    * - Parameter dir: Different between vertical and horizontal
    */
   public func distribute(to:UIView, dir:Axis, align:Alignment = .topLeft, spacing:CGFloat = 0, offset:CGFloat = 0){ 
      self.activateAnchors { views in
         switch dir {
         case .horizontal:
            return Constraint.distribute(horizontally: views, align: .topCenter, spacing:spacing, offset:offset)
         case .vertical:
            return Constraint.distribute(vertically: views, align: .topCenter, spacing:spacing, offset:offset)
         }
      }
   }
}
