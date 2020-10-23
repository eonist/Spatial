import Foundation
/**
 * UIView's that implement this protocol are able to store the anchor and size constraints
 * - Note: Storing Constraints is a must if you want to change the constraints at a later point in time
 * - Fixme: ⚠️️ make these variables into one: var anchorAndSize: AnchorAndSize
 */
public protocol ConstraintKind: AnyObject {
   var anchor: AnchorConstraint? { get set }
   var size: SizeConstraint? { get set }
}
