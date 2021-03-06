import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
/**
 * AutoLayout Sugar for UIView
 * - Note: Method overloading doesn't work with closures so each method name needs to be unique
 */
extension View {
   /**
    * Activate constraint (multiple layoutconstraints)
    * ## Examples:
    * button.activateConstraints { view in
    *      let anchor = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft)
    *      let size = Constraint.size(view, size: CGSize.init(width: UIScreen.main.bounds.width, height: TopBar.topBarHeight))
    *      return [anchor.x, anchor.y, size.w, size.h]
    * }
    */
   public func activateConstraints(closure: ConstraintsClosure) {
      self.translatesAutoresizingMaskIntoConstraints = false
      let constraints: [NSLayoutConstraint] = closure(self) // the constraints is returned from the closure
      NSLayoutConstraint.activate(constraints)
   }
   /**
    * Activate constraint (singular layoutconstraint)
    */
   public func activateConstraint(closure: ConstraintClosure) {
      self.translatesAutoresizingMaskIntoConstraints = false
      let constraint: NSLayoutConstraint = closure(self) // the constraints is returned from the closure
      NSLayoutConstraint.activate([constraint])
   }
   /**
    * Same as activateConstraint, but returns a tuple in the closure instead of an array
    * - Note: Useful for when you return anchor and size
    * ## Examples:
    * label.activateAnchorAndSize { view in
    *    let a: AnchorConstraint = Constraint.anchor(view, to: self, align: .topLeft, alignTo:  .topLeft)
    *    let s: SizeConstraint = Constraint.size(view, to: self)
    *    return (a, s)
    * }
    */
   public func activateAnchorAndSize(closure: AnchorAndSizeClosure) {
      self.translatesAutoresizingMaskIntoConstraints = false
      let anchorAndSize: AnchorAndSize = closure(self) // The constraints is returned from the closure
      let constraints: [NSLayoutConstraint] = [anchorAndSize.anchor.x, anchorAndSize.anchor.y, anchorAndSize.size.w, anchorAndSize.size.h]
      NSLayoutConstraint.activate(constraints)
   }
   /**
    * Activate for AnchorConstraint
    */
   public func activateAnchor(closure: AnchorClosure) {
      self.translatesAutoresizingMaskIntoConstraints = false
      let anchorConstraint: AnchorConstraint = closure(self) // The constraints is returned from the closure
      let constraints: [NSLayoutConstraint] = [anchorConstraint.x, anchorConstraint.y]
      NSLayoutConstraint.activate(constraints)
   }
   /**
    * Activate for SizeConstraint
    */
   public func activateSize(closure: SizeClosure) {
      self.translatesAutoresizingMaskIntoConstraints = false
      let sizeConstraint: SizeConstraint = closure(self) // The constraints is returned from the closure
      let constraints: [NSLayoutConstraint] = [sizeConstraint.w, sizeConstraint.h]
      NSLayoutConstraint.activate(constraints)
   }
}
