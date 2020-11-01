import Foundation
/**
 * UIView's that implement this protocol are able to store the anchor and size constraints
 * - Note: Storing Constraints is a must if you want to change the constraints at a later point in time, for isntance for animation
 * - Important: ⚠️️ Use anchorAndSize as a variable, anchor and size is part of legacy api, and will be deprecated
 */
public protocol ConstraintKind: AnyObject {
//   @available(*, deprecated, renamed: "anchorAndSize")
   var anchor: AnchorConstraint? { get set }
//   @available(*, deprecated, renamed: "anchorAndSize")
   var size: SizeConstraint? { get set }
   var anchorAndSize: Spatial.AnchorAndSize? { get set }
}
extension ConstraintKind {
   /**
    * Default anchor value (legacy api support)
    * - Important: ⚠️️ will be deprecated
    */
   public var anchor: AnchorConstraint? {
      get {
         self.anchorAndSize?.anchor
      } set {
         if let newValue = newValue { anchorAndSize?.anchor = newValue }
      }
   }
   /**
    * Default size value (legacy api support)
    * - Important: ⚠️️ will be deprecated
    */
   public var size: SizeConstraint? {
      get {
         self.anchorAndSize?.size
      } set {
         if let newValue = newValue { anchorAndSize?.size = newValue }
      }
   }
   /**
    * Default anchorAndSize value
    * - Important: ⚠️️ will be deprecated, once anchor and size is deprecated
    */
   public var anchorAndSize: Spatial.AnchorAndSize? {
      get {
         guard let anchor = anchor, let size = size else { return nil }
         return (anchor, size)
      } set {
         anchor = newValue?.anchor
         size = newValue?.size
      }
   }
}
