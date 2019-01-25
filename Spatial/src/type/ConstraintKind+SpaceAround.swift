import Foundation
/**
 * Extension for spaceAround method
 */
extension Array where Element:ConstraintKind.UIViewConstraintKind{
   /**
    * Same as spaceBetween but does not pin to sides but rather add equal spacing there as well
    * - IMPORTANT ⚠️️ only works with UIConstraintView where size is available
    * - Description: |--[]--[]--[]--[]--[]--|
    * ## Examples:
    * views.spaceAround(dir: .hor, parent: self)
    */
   public func spaceAround(dir:Axis, parent:UIView, inset:UIEdgeInsets = .init()){
      switch dir {
      case .hor:
         SpaceAroundUtil.spaceAround(horizontally:parent, views:self, inset:inset)
      case .ver:
         SpaceAroundUtil.spaceAround(vertically:parent, views:self, inset:inset)
      }
   }
}
/**
 * SpaceAround helper
 */
fileprivate class SpaceAroundUtil{
   /**
    * Horizontal
    */
   static func spaceAround(horizontally parent:UIView, views:[ConstraintKind.UIViewConstraintKind], inset:UIEdgeInsets) {
      let rect:CGRect = parent.bounds.inset(by: inset)
      let itemVoid:CGFloat = {
         let totW:CGFloat = views.reduce(0){$0 + ($1.size?.w.constant ?? 0)}/*find the totalW of all items*/
         let totVoid:CGFloat = rect.width - totW/*find totVoid by doing w - totw*/
         let numOfVoids:CGFloat = CGFloat(views.count + 1)/*then divide this voidSpace with .count - 1 and*/
         return totVoid / numOfVoids/*iterate of each item and inserting itemVoid in + width*/
      }()
      var x:CGFloat = rect.origin.x+itemVoid/*interim x*/
      views.forEach{ item in
         item.activateConstraint { view in
            let constraint = Constraint.anchor(item, to: parent, align: .left, alignTo: .left, offset:x)
            item.anchor?.x = constraint
            return constraint
         }
         x += (item.size?.w.constant ?? 0) + itemVoid
      }
   }
   /**
    * Vertical
    */
   static func spaceAround(vertically parent:UIView, views:[ConstraintKind.UIViewConstraintKind], inset:UIEdgeInsets) {
      let rect:CGRect = parent.bounds.inset(by: inset)
      let itemVoid:CGFloat = {
         let totH:CGFloat = views.reduce(0){$0 + ($1.size?.h.constant ?? 0)}/*find the totalW of all items*/
         let totVoid:CGFloat = rect.height - totH/*find totVoid by doing w - totw*/
         let numOfVoids:CGFloat = CGFloat(views.count + 1)/*then divide this voidSpace with .count - 1 and*/
         return totVoid / numOfVoids/*iterate of each item and inserting itemVoid in + width*/
      }()
      var y:CGFloat = rect.origin.y + itemVoid/*interim y*/
      views.forEach{ item in
         item.activateConstraint { view in
            let constraint = Constraint.anchor(item, to: parent, align: .top, alignTo: .top, offset:y)
            item.anchor?.y = constraint
            return constraint
         }
         y += (item.size?.h.constant ?? 0) + itemVoid
      }
   }
}
