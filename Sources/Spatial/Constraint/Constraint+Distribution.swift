import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
/**
 * Distribute items horizontally or vertically
 */
extension Constraint {
   /**
    * Horizontal distribution
    * - Fixme: ⚠️️ make it throw?
    * - Fixme: ⚠️️ Add support for spacing
    * - Fixme: ⚠️️ Add support for alignTo: (because you might want to set a different anchor for the views than for the view to align to)
    * - Fixme: ⚠️️ parent is always superview, then we must use UIView as type, remember your returning constriants, not setting actual anchor or size, you do that in activeConstraint
    * - Important: ⚠️️ Sets only anchors not sizes
    * ## EXAMPLE:
    * [label1, label2, label3].applyAnchorsAndSizes { views in
    *      let anchors = Constraint.distribute(vertically:views,align:.left)
    *      let sizes = views.map{ Constraint.size($0, toView: self.frame.width, height: 48)) }
    *      return (anchors, sizes)
    * }
    * - Note: Alternativly you can do: views.enumerated().map{Constraint.anchor($0.1, to: self, align: .topLeft, alignTo:.topLeft,offset:CGPoint(x:0,y:48 * $0.0))} etc
    * - Parameters:
    *    - spacing: a void between items
    *    - offset: offset the x in the begining
    *    - align: at which corner should the first item align to
    *    - views: the views to distribute in a row
    */
   public static func distribute(horizontally views: [View], align: Alignment = .topLeft, spacing: CGFloat = .zero, offset: CGPoint = .zero) -> [AnchorConstraint] {
      let xConstraints: [NSLayoutConstraint] = distribute(views, axis: .hor, align: align, spacing: spacing, offset: offset.x)
      let yConstraints: [NSLayoutConstraint] = views.map { view in
         guard let superView = view.superview else { fatalError("View must have superview") }
         return Constraint.anchor(view, to: superView, align: align.verAlign, alignTo: align.verAlign, offset: offset.y)
      }
      let anchors: [AnchorConstraint] = Array(zip(xConstraints, yConstraints))
      return anchors
   }
   /**
    * Vertical distribution
    * - Important: ⚠️️ Sets only anchors not sizes
    * - Fixme: ⚠️️ make it throw? yepp
    */
   public static func distribute(vertically views: [View], align: Alignment = .topLeft, spacing: CGFloat = .zero, offset: CGPoint = .zero) -> [AnchorConstraint] {
      let xConstraints: [NSLayoutConstraint] = views.map { view in
         guard let superView = view.superview else { fatalError("View must have superview") }
         return Constraint.anchor(view, to: superView, align: align.horAlign, alignTo: align.horAlign, offset: offset.x)
      }
      let yConstraints = distribute(views, axis: .ver, align: align, spacing: spacing, offset: offset.y)
      let anchors: [AnchorConstraint] = Array(zip(xConstraints, yConstraints))
      return anchors
   }
}
/**
 * Internal helper methods
 * - Note: Consider moving to fileprivate Util class
 */
extension Constraint {
   /**
    * Distributes vertically or horizontally
    * - Fixme: ⚠️️ Remove fatal error? make it throw?
    */
   fileprivate static func distribute(_ views: [View], axis: Axis, align: Alignment, spacing: CGFloat = .zero, offset: CGFloat = .zero) -> [NSLayoutConstraint] {
      switch (align.horAlign, align.verAlign) {
      case (.left, _), (_, .top): return distribute(fromStart: views, axis: axis, spacing: spacing, offset: offset)
      case (.right, _), (_, .bottom): return distribute(fromEnd: views, axis: axis, spacing: spacing, offset: offset)
      default: fatalError("Type not supported: h: \(align.horAlign) v: \(align.verAlign)")
      }
   }
   /**
    * Distributes from start to end
    * - Fixme: ⚠️️ Remove fatal error? make it throw?
    */
   fileprivate static func distribute(fromStart views: [View], axis: Axis, spacing: CGFloat = .zero, offset: CGFloat = .zero) -> [NSLayoutConstraint] {
      var anchors: [NSLayoutConstraint] = []
      var prevView: View?
      views.enumerated().forEach { _, view in
         guard let toView: View = prevView ?? view.superview else { fatalError("View must have superview") }
         let offset: CGFloat = prevView == nil ? offset : .zero // Only the first view gets offset
         let spacing: CGFloat = prevView != nil ? spacing : 0 // All subsequent views gets spacing
         switch axis {
         case .hor:
            let alignTo: HorizontalAlign = prevView == nil ? .left : .right // First align to left pf superView, then right of each subsequent item
            anchors.append(Constraint.anchor(view, to: toView, align: .left, alignTo: alignTo, offset: offset + spacing))
         case .ver:
            let alignTo: VerticalAlign = prevView == nil ? .top : .bottom // First align to top pf superView, then bottom of each subsequent item
            anchors.append(Constraint.anchor(view, to: toView, align: .top, alignTo: alignTo, offset: offset + spacing))
         }
         prevView = view
      }
      return anchors
   }
   /**
    * Aligns from end to start
    * - Fixme: ⚠️️ Remove fatal error? make it throw?
    */
   fileprivate static func distribute(fromEnd views: [View], axis: Axis, spacing: CGFloat = .zero, offset: CGFloat = .zero) -> [NSLayoutConstraint] {
      var anchors: [NSLayoutConstraint] = []
      var prevView: View?
      for view in views.reversed() { // Move backwards
         guard let toView: View = prevView ?? view.superview else { fatalError("View must have superview") }
         let offset: CGFloat = prevView == nil ? offset : .zero
         let spacing: CGFloat = prevView != nil ? spacing : 0 // All subsequent views gets spacing
         switch axis {
         case .hor:
            let alignTo: HorizontalAlign = prevView == nil ? .right : .left // First align to right pf superView, then left of each subsequent item
            anchors.append(Constraint.anchor(view, to: toView, align: .right, alignTo: alignTo, offset: offset + spacing))
         case.ver:
            let alignTo: VerticalAlign = prevView == nil ? .bottom : .top // First align to bottom pf superView, then top of each subsequent item
            anchors.append(Constraint.anchor(view, to: toView, align: .bottom, alignTo: alignTo, offset: offset + spacing))
         }
         prevView = view
      }
      return anchors
   }
}
