#if os(iOS)
import UIKit
/**
 * UIViews that implement this protocol are able to store the anchor and size constraints
 * NOTE: Storing Constraints is a must if you want to change the constraints at a later point in time
 */
public protocol ConstraintKind:class{
   var anchor:AnchorConstraint? {get set}
   var size:SizeConstraint? {get set}
}
/**
 * NOTE: Convenient UIView so you dont have to add anchor and size your self
 */
open class ConstraintView:UIView,ConstraintKind{
   public var anchor: AnchorConstraint?
   public var size: SizeConstraint?
}
/**
 * Update constraints (For items that are of type ConstraintKind)
 */
extension ConstraintKind where Self:UIView{
   /**
    * TODO: ⚠️️ This could be usefull in a global domain, for now just access it by: ConstraintKind.UIViewConstraintKind
    */
   public typealias UIViewConstraintKind = UIView & ConstraintKind
   public typealias AnchorAndSize = (anchor:AnchorConstraint,size:SizeConstraint)//
   public typealias ConstraintKindClosure = (_ view:UIViewConstraintKind) -> AnchorAndSize
   /**
    * Same as UIView().activateConstraint... but also sets size and anchor constraints (ConstraintKind) (For animation etc)
    * TODO: ⚠️️ maybe reuse the code from activateConstraint, by forwarning the closure etc. Nope, cant call closure twice
    * TODO: ⚠️️ Rename to apply, or better 👉 applyConstraint
    * Example:
    * sliderBar.applyConstraint { view in
    *      let anchor = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft)
    *      let size = Constraint.size(view, size: size)
    *      return (anchor:anchor, size:size)//(anchor, size) 👈 also works
    * }
    * NOTE: this had to be renamed to setAndActivateConstraint, as overriding the default extension method didnt work so well when you passed the variable into a method
    */
   public func applyConstraint(closure:ConstraintKindClosure) {
      self.translatesAutoresizingMaskIntoConstraints = false
      let constraints:AnchorAndSize = closure(self)/*the constraints is returned from the closure*/
      setConstraint(anchor: constraints.anchor, size: constraints.size)
      NSLayoutConstraint.activate([constraints.anchor.x,constraints.anchor.y,constraints.size.w,constraints.size.h])
   }
   /**
    * Convenient
    */
   public func setConstraint(anchor:AnchorConstraint,size:SizeConstraint) {
      self.anchor = anchor
      self.size = size
   }
}
/**
 * Update arrays of UIViewConstraintKind
 */
extension Array where Element:ConstraintKind.UIViewConstraintKind{
   public typealias ConstraintsClosure = (_ views:[UIView]) -> AnchorConstraintsAndSizeConstraints
   /**
    * Apply constraints on an array of UIViewConstraintKind
    * Example:
    *  [label1,label2,label3].applyConstraint { views in
    *      let anchors = []
    *      let sizes = []
    *      return (anchors, sizes)
    *  }
    */
   public func applyConstraint(closure:ConstraintsClosure) {
      self.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
      let constraints:AnchorConstraintsAndSizeConstraints = closure(self)/*the constraints is returned from the closure*/
      self.enumerated().forEach {
         let anchor:AnchorConstraint = constraints.anchorConstraints[$0.offset]
         let size:SizeConstraint = constraints.sizeConstraints[$0.offset]
         $0.element.setConstraint(anchor:anchor,size:size)
         
      }
      let layoutConstraints:[NSLayoutConstraint] = {
         let anchors = constraints.anchorConstraints.reduce([]) { $0 + [$1.x,$1.y] }
         let sizes = constraints.sizeConstraints.reduce([]) { $0 + [$1.w,$1.h] }
         return anchors + sizes
      }()
      NSLayoutConstraint.activate(layoutConstraints) //constraints.forEach{$0.setConstraint(anchor: $0.anchor, size: $0.size)}
   }
}
#endif
