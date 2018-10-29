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
/**
 * Offset horizontally or vertically
 */
extension ConstraintKind where Self:UIView{
   /**
    * Updates horizontal anchor
    */
   public func update(offset:CGFloat, align:HorizontalAlign, alignTo:HorizontalAlign){
      guard let superview:UIView = self.superview else {fatalError("err superview not available")}
      guard let oldAnchor = self.anchor else {fatalError("err anchor not available")}
      NSLayoutConstraint.deactivate([oldAnchor.x])
      let newAnchorX = Constraint.anchor(self, to: superview, align: align, alignTo: alignTo, offset: offset)
      NSLayoutConstraint.activate([newAnchorX])
      self.anchor?.x = newAnchorX
      superview.layoutIfNeeded()/*The superview is responsible for updating subView constraint updates*/
   }
   /**
    * Updates vertical anchor
    */
   public func update(offset:CGFloat, align:VerticalAlign, alignTo:VerticalAlign){
      guard let superview:UIView = self.superview else {fatalError("err superview not available")}
      guard let oldAnchor = self.anchor else {fatalError("err anchor not available")}
      NSLayoutConstraint.deactivate([oldAnchor.y])
      let newAnchorY = Constraint.anchor(self, to: superview, align: align, alignTo: alignTo, offset: offset)
      NSLayoutConstraint.activate([newAnchorY])
      self.anchor?.y = newAnchorY
      superview.layoutIfNeeded()/*The superview is responsible for updating subView constraint updates*/
   }
}
/**
 * Animation
 */
extension ConstraintKind where Self:UIView{//TODO ⚠️️ use UIViewConstraintKind
   /**
    * Animates a UIView that adhers to ConstraintKind (hor)
    */
   public func animate(to:CGFloat, align:HorizontalAlign, alignTo:HorizontalAlign, onComplete:@escaping AnimComplete = Self.defaultOnComplete){
      UIView.animate({self.update(offset: to, align: align, alignTo: alignTo)},onComplete:onComplete)
   }
   /**
    * Anim for ver
    */
   public func animate(to:CGFloat, align:VerticalAlign = .top, alignTo:VerticalAlign = .top, onComplete:@escaping AnimComplete = Self.defaultOnComplete){
      UIView.animate({self.update(offset: to, align: align, alignTo: alignTo)},onComplete:onComplete)
   }
}
/**
 * Animation (Static & convenient)
 */
extension UIView{
   public typealias AnimComplete = () -> Void
   public typealias AnimUpdate = () -> Void
   public static func defaultOnComplete() {Swift.print("default anim completed closure")}
   /**
    * Animate
    * Example:
    * PARAM: onUpdate is animateTo this and on every frame do this at the same time 🤔
    */
   public static func animate(_ onUpdate:@escaping AnimUpdate,onComplete:@escaping AnimComplete = UIView.defaultOnComplete){
      let anim = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
         onUpdate()
      })
      anim.addCompletion{_ in onComplete() }
      anim.startAnimation()
   }
}
#endif
