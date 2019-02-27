#if os(iOS)
import UIKit
/**
 * Single
 */
public extension ConstraintKind where Self:UIView{
   /**
    * Cobinational types and closure signatures
    * - Note: This could be useful in a global domain, for now just access it by: ConstraintKind.UIViewConstraintKind
    */
   public typealias UIViewConstraintKind = UIView & ConstraintKind
   public typealias AnchorAndSize = (anchor:AnchorConstraint, size:SizeConstraint)
}
/**
 * Bulk
 */
extension Array where Element:ConstraintKind.UIViewConstraintKind{
   public typealias AnchorAndSizeClosure = (_ views:[UIView]) -> AnchorConstraintsAndSizeConstraints
   public typealias SizesClosure = (_ views:[UIView]) -> [SizeConstraint]
   public typealias AnchorClosure = (_ views:[UIView]) -> [AnchorConstraint]
   public typealias AxisClosure = (_ views:[UIView]) -> [NSLayoutConstraint]
   
}
#endif
