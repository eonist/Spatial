import Foundation
/**
 * Extension for spaceAround method
 */
extension Array where Element: ConstraintKind.ViewConstraintKind {
   /**
    * Same as spaceBetween but does not pin to sides but rather add equal spacing there as well
    * - Important: ⚠️️ only works with UIConstraintView where size is available
    * - Important: ⚠️️ only works were the parent.bound are available
    * - Description: |--[]--[]--[]--[]--[]--|
    * ## Examples:
    * let views: [ConstraintView] = [UIColor.purple, .orange,.red].map {
    *    let view: ConstraintView = .init(frame: .zero)
    *    self.addSubview(view)
    *    view.backgroundColor = $0
    *    return view
    * }
    * views.applySizes(width: 120, height: 48)
    * views.applyAnchors(to: self, align: .top, alignTo: .top, offset: 20)
    * views.spaceAround(dir: .hor, parent: self)
    * - Parameters:
    *   - inset: Inset the parent bound
    *   - dir: vertical or horizontal axis
    *   - parent: the parent of the views
    */
   public func spaceAround(dir: Axis, parent: View, inset: EdgeInsets = .init()) {
      switch dir {
      case .hor:
         SpaceAroundUtil.spaceAround(horizontally: parent, views: self, inset: inset)
      case .ver:
         SpaceAroundUtil.spaceAround(vertically: parent, views: self, inset: inset)
      }
   }
}
/**
 * SpaceAround helper
 */
fileprivate class SpaceAroundUtil {
   /**
    * spaceAround (Horizontal)
    */
   static func spaceAround(horizontally parent: View, views: [ConstraintKind.ViewConstraintKind], inset: EdgeInsets) {
      let rect: CGRect = parent.bounds.inset(by: inset)
      let itemVoid: CGFloat = {
         let totW: CGFloat = views.reduce(0) { $0 + ($1.size?.w.constant ?? 0) } // Find the totalW of all items
         let totVoid: CGFloat = rect.width - totW // Find totVoid by doing w - totw
         let numOfVoids = CGFloat(views.count + 1) // Then divide this voidSpace with .count - 1 and
         return totVoid / numOfVoids // Iterate of each item and inserting itemVoid in + width
      }()
      var x: CGFloat = rect.origin.x + itemVoid // Interim x
      views.forEach { item in
         item.activateConstraint { _ in
            let constraint = Constraint.anchor(item, to: parent, align: .left, alignTo: .left, offset: x)
            item.anchor?.x = constraint
            return constraint
         }
         x += (item.size?.w.constant ?? 0) + itemVoid
      }
   }
   /**
    * spaceAround (Vertical)
    */
   static func spaceAround(vertically parent: View, views: [ConstraintKind.ViewConstraintKind], inset: EdgeInsets) {
      let rect: CGRect = parent.bounds.inset(by: inset)
      let itemVoid: CGFloat = {
         let totH: CGFloat = views.reduce(0) { $0 + ($1.size?.h.constant ?? 0) } // Find the totalW of all items
         let totVoid: CGFloat = rect.height - totH // Find totVoid by doing w - totw
         let numOfVoids = CGFloat(views.count + 1) // Then divide this voidSpace with .count - 1 and
         return totVoid / numOfVoids // Iterate of each item and inserting itemVoid in + width
      }()
      var y: CGFloat = rect.origin.y + itemVoid // Interim y
      views.forEach { item in
         item.activateConstraint { _ in
            let constraint = Constraint.anchor(item, to: parent, align: .top, alignTo: .top, offset: y)
            item.anchor?.y = constraint
            return constraint
         }
         y += (item.size?.h.constant ?? 0) + itemVoid
      }
   }
}
