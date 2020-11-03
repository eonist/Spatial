#if os(iOS)
import UIKit
/**
 * Animation
 * - Description: These are examples how you can animate with Spatial and autolayout
 * - Fixme: ⚠️️ Use animation classes that support earlier versions of iOS
 * - Fixme: ⚠️️ Use UIViewConstraintKind?
 * - Fixme: ⚠️️ Add support for macOS animation
 */
extension ConstraintKind where Self: UIView {
   /**
    * Animates a UIView that adhers to ConstraintKind (hor)
    * ## Examples:
    * btn.animate(to: 100, align: left, alignTo: .left)
    */
   public func animate(to: CGFloat, align: HorizontalAlign, alignTo: HorizontalAlign, onComplete:@escaping AnimComplete = Self.defaultOnComplete) {
      UIView.animate({
         self.update(offset: to, align: align, alignTo: alignTo)
      }, onComplete: onComplete)
   }
   /**
    * Anim (ver)
    */
   public func animate(to: CGFloat, align: VerticalAlign, alignTo: VerticalAlign, onComplete:@escaping AnimComplete = Self.defaultOnComplete) {
      UIView.animate({
         self.update(offset: to, align: align, alignTo: alignTo)
      }, onComplete: onComplete)
   }
   /**
    * Anim (ver, hor)
    */
   public func animate(to: CGPoint, align: Alignment, alignTo: Alignment, onComplete:@escaping AnimComplete = Self.defaultOnComplete) {
      UIView.animate({
         self.update(offset: to, align: align, alignTo: alignTo)
      }, onComplete: onComplete)
   }
}
#endif
