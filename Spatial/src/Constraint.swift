#if os(iOS)
import UIKit
public typealias AnchorConstraint = (x:NSLayoutConstraint,y:NSLayoutConstraint)
public typealias SizeConstraint = (w:NSLayoutConstraint,h:NSLayoutConstraint)
public typealias AnchorConstraintsAndSizeConstraints = (anchorConstraints:[AnchorConstraint],sizeConstraints:[SizeConstraint])
/**
 * Positional constraints
 * DESCRIPTION: (Aligning relative to another view (x,y))
 * Discussion: Snapkit and Carthography are too clever and caters to too many facets of autolayout. This library is just a simple extension that does basic autolayout while reducing the setup time in half.
 * TODO: ⚠️️ Not really an anchor, consider renaming to ConstraintAttribute or pin, or?
 * Discussion: anchor is a more appropriate name than, pin,pos,pt,edge,put,magnet,align,corner (anchor can represent both corner,edge and center)
 */
public class Constraint{
   /**
    * Creates a positional constraint
    * TODO: ⚠️️ Rename to pin 👌, to differentiate from anchor, point, origin, position?
    */
   public static func anchor(_ view:UIView, to:UIView, align:Alignment, alignTo:Alignment, offset:CGPoint = CGPoint(), useMargin:Bool = false) -> AnchorConstraint {/*,offset:CGPoint = CGPoint()*/
      let horConstraint = Constraint.anchor(view, to: to, align: align.horAlign, alignTo: alignTo.horAlign,offset:offset.x,useMargin:useMargin)
      let verConstraint = Constraint.anchor(view, to: to, align: align.verAlign, alignTo: alignTo.verAlign,offset:offset.y,useMargin:useMargin)
      return (horConstraint,verConstraint)
   }
   /**
    * Horizontal
    */
   public static func anchor(_ view:UIView, to:UIView, align:HorizontalAlign, alignTo:HorizontalAlign, offset:CGFloat = 0, useMargin:Bool = false) -> NSLayoutConstraint {/*,offset:CGPoint = CGPoint()*/
      return NSLayoutConstraint(item: view, attribute: Constraint.layoutAttr(align), relatedBy: .equal, toItem: to, attribute: Constraint.layoutAttr(alignTo,useMargin:useMargin), multiplier: 1.0, constant: offset)
   }
   /**
    * Vertical
    */
   public static func anchor(_ view:UIView, to:UIView, align:VerticalAlign, alignTo:VerticalAlign, offset:CGFloat = 0, useMargin:Bool = false) -> NSLayoutConstraint {/*,offset:CGPoint = CGPoint()*/
      return NSLayoutConstraint(item: view, attribute: Constraint.layoutAttr(align), relatedBy: .equal, toItem: to, attribute: Constraint.layoutAttr(alignTo,useMargin:useMargin), multiplier: 1.0, constant: offset)
   }
}
/**
 * Size constraints
 * NOTE: Has a lot of NSConstraint and NSAnchor info: https://stackoverflow.com/a/26181982/5389500
 * EXAMPLE: square.translatesAutoresizingMaskIntoConstraints = false (this enables you to set your own constraints)
 * EXAMPLE: contentView.layoutMargins = UIEdgeInsetsMake(12,12,12,12)//adds margin to the containing view
 * EXAMPLE: let pos = Constraint.anchor(square,to:canvas,targetAlign:.topleft,toAlign:.topleft)
 * EXAMPLE: let size = Constraint.size(square,to:canvas)
 * EXAMPLE: NSLayoutConstraint.activate([anchor.x,anchor.y,size.w,size.h])
 */
extension Constraint{
   /**
    * creates a dimensional constraint
    * TODO: ⚠️️ Rename to dimension 👌, to differentiate from the Apple name convention of frame, size, bound etc
    * EXAMPLE: let widthConstraint = Constraint.size(square,to:canvas,axis:.horizontal).w
    */
   public static func size(_ view:UIView, to:UIView) -> SizeConstraint{
      let widthConstraint = Constraint.width(view,to:to)
      let heightConstraint = Constraint.height(view,to:to)
      return (widthConstraint,heightConstraint)
   }
   /**
    * EXAMPLE: let sizeConstraint = Constraint.size(square,size:CGSize(100,100))
    */
   public static func size(_ view:UIView, size:CGSize, multiplier:CGSize = CGSize(width:1,height:1)) -> SizeConstraint{
      let widthConstraint = Constraint.width(view, width: size.width, multiplier: multiplier.width)
      let heightConstraint = Constraint.height(view, height: size.height, multiplier: multiplier.height)
      return (widthConstraint,heightConstraint)
   }
   /**
    * Creates a width constraint (based on a CGFloat width)
    */
   public static func width(_ view:UIView, width:CGFloat, multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: width)//NSLayoutAttribute
   }
   /**
    * Creates a height constraint (based on a CGFloat height)
    */
   public static func height(_ view:UIView,height:CGFloat,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: height)//NSLayoutAttribute
   }
   /**
    * Creates a width constraint (based on another views width constraint)
    */
   public static func width(_ view:UIView,to:UIView,offset:CGFloat = 0,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: to, attribute: .width, multiplier: multiplier, constant: offset)//NSLayoutAttribute.notAnAttribute
   }
   /**
    * Creates a height constraint (based on another views width constraint)
    */
   public static func height(_ view:UIView,to:UIView,offset:CGFloat = 0,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: to, attribute: .height, multiplier: multiplier, constant: offset)//NSLayoutAttribute.notAnAttribute
   }
   /**
    * New
    * NOTE: Useful if you want to set a width of an object to the height of another object
    * NOTE: You can also use it on it's own view to copy width to height for instance
    * TODO: ⚠️️ Consider renaming this to side ?
    * EXAMPLE: let widthConstraint = Constraint.length(square,viewAxis:.horizontal,axis:.vertical)
    */
   public static func length(_ view:UIView,to:UIView,viewAxis:Axis,toAxis:Axis,offset:CGFloat = 0,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      let viewAttr:NSLayoutConstraint.Attribute = viewAxis == .horizontal ? .width : .height
      let toAttr:NSLayoutConstraint.Attribute = toAxis == .horizontal ? .width : .height
      return NSLayoutConstraint(item: view, attribute: viewAttr, relatedBy: .equal, toItem: to, attribute: toAttr, multiplier: multiplier, constant: offset)//NSLayoutAttribute.notAnAttribute
   }
}
/**
 * Internal helper methods
 */
extension Constraint{
   /**
    * x (internal)
    */
   private static func layoutAttr(_ align:HorizontalAlign,useMargin:Bool = false) -> NSLayoutConstraint.Attribute{
      switch align{
      case .left: return useMargin ? NSLayoutConstraint.Attribute.leftMargin : NSLayoutConstraint.Attribute.left //fatalError("err")
      case .right: return useMargin ? NSLayoutConstraint.Attribute.rightMargin : NSLayoutConstraint.Attribute.right
      case .centerX: return useMargin ? NSLayoutConstraint.Attribute.centerXWithinMargins : NSLayoutConstraint.Attribute.centerX
      }
   }
   /**
    * y (internal)
    */
   private static func layoutAttr(_ align:VerticalAlign, useMargin:Bool = false) -> NSLayoutConstraint.Attribute{
      switch align{
      case .top: return useMargin ? NSLayoutConstraint.Attribute.topMargin : NSLayoutConstraint.Attribute.top
      case .bottom: return useMargin ? NSLayoutConstraint.Attribute.bottomMargin : NSLayoutConstraint.Attribute.bottom
      case .centerY: return useMargin ? NSLayoutConstraint.Attribute.centerYWithinMargins : NSLayoutConstraint.Attribute.centerY
      }
   }
}
/**
 * AutoLayout Sugar for UIView
 */
extension UIView{
   /*We keep AnchorsAndSizes in a tuple, because applyConstraints wouldn't work with just an array*/
   public typealias AnchorsAndSizes = (anchors:[NSLayoutConstraint],sizes:[NSLayoutConstraint])//can this go to [UIView].AnchorsAndSizes  ?
   public typealias ConstraintClosure = (_ view:UIView) -> [NSLayoutConstraint]
   /**
    * EXAMPLE:
    * camTopBar.activateConstraint{ view in
    *      let anchor = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft)
    *      let size = Constraint.size(view, size: CGSize.init(width: UIScreen.main.bounds.width, height: TopBar.topBarHeight))
    *      return [anchor.x,anchor.y,size.w,size.h]
    * }
    */
   public func activateConstraint(closure:ConstraintClosure) {
      self.translatesAutoresizingMaskIntoConstraints = false
      let constraints:[NSLayoutConstraint] = closure(self)/*the constraints is returned from the closure*/
      NSLayoutConstraint.activate(constraints)
   }
}
/**
 * AutoLayout Sugar for UIView's
 * EXAMPLE:
 * [label1,label2,label3].activateConstraint { views in
 *      let anchors = []
 *      let sizes = []
 *      return (anchors, sizes)
 * }
 * NOTE: ⚠️️ You have to zip together anchors in some cases
 */
extension Array where Element:UIView{
   public typealias ConstraintClosure = (_ views:[UIView]) -> AnchorConstraintsAndSizeConstraints
   public func activateConstraint(closure:ConstraintClosure) {
      self.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
      let constraints:[NSLayoutConstraint] = {
         let constraints:AnchorConstraintsAndSizeConstraints = closure(self)
         let anchors = constraints.anchorConstraints.reduce([]) { $0 + [$1.x,$1.y] }
         let sizes = constraints.sizeConstraints.reduce([]) { $0 + [$1.w,$1.h] }
         return anchors + sizes
      }()
      NSLayoutConstraint.activate(constraints)
   }
}
// self.enumerated().forEach { (view, i) in
//    view.activateConstraint{ v in
//       let anchor = constraints[i].anchor
//       let size = constraints[i].size
//       return [anchor.x,anchor.y,size.w,size.h]
//    }
// }
#endif
