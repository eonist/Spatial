/**
 * Hybrid
 */
extension View {
   public typealias AnimComplete = () -> Void
   public typealias AnimUpdate = () -> Void
   public static func defaultOnComplete() { Swift.print("default anim completed closure") }
}
#if os(iOS)
import UIKit
/**
 * Animation (Static & convenient)
 * - Fixme: ⚠️️ Add support for macOS
 */
extension View {
   /**
    * Animate
    * - Parameters:
    *   - onUpdate: is "animateTo this" and on every frame do this at the same time 🤔
    *   - onComplete: call back closure for when aim is complete
    *   - dur: seconds the anim should last
    *   - easing: the easing curve
    * ## Examples:
    * UIView.animate({ self.update(offset: to, align: align, alignTo: alignTo) }, onComplete: { Swift.print("🎉") })
    */
   public static func animate(_ onUpdate:@escaping AnimUpdate, onComplete:@escaping AnimComplete = View.defaultOnComplete, dur: Double = 0.3, easing: AnimationCurve = .easeOut) {
      let anim: UIViewPropertyAnimator = .init(duration: dur, curve: easing, animations: {
         onUpdate()
      })
      anim.addCompletion { _ in onComplete() }
      anim.startAnimation()
   }
}
#elseif os(macOS)
import Cocoa
extension View {
   /**
    * Animate for macOS
    * - Note: animating to new alignments also works
    * - Fixme: ⚠️️ add support for easing curves, do research etc
    */
   public static func animate(_ onUpdate:@escaping AnimUpdate, onComplete:@escaping AnimComplete = View.defaultOnComplete, dur: Double = 0.3) {
      NSAnimationContext.runAnimationGroup({ context -> Void in
         context.duration = dur // length of the animation time in seconds
         context.allowsImplicitAnimation = true // must be activated, for constraints to be able to animate, or else must use .animator().constnat etc
         onUpdate()
      }, completionHandler: { () -> Void in
         onComplete() // insert any completion code here
      })
   }
}
#endif
