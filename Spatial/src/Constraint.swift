#if os(iOS)
import UIKit
/**
 * Aligning relative to another view (x,y)
 * Discussion: Snapkit and Carthography are too clever and caters to too many facets of autolayout. This library is just a simple extension that does basic autolayout while reducing the setup time in half.
 * TODO: ⚠️️ The examples in this class is a bit outdated and needs an update ⚠️️
 * NOTE: Has a lot of NSConstraint and NSAnchor info: https://stackoverflow.com/a/26181982/5389500
 * Discussion: anchor is a more appropriate name than, pin,pos,pt,edge,put,magnet,align,corner (anchor can represent both corner,edge and center)
 * EXAMPLE: square.translatesAutoresizingMaskIntoConstraints = false (this enables you to set your own constraints)
 * EXAMPLE: contentView.layoutMargins = UIEdgeInsetsMake(12,12,12,12)//adds margin to the containing view
 * EXAMPLE: let pos = Constraint.anchor(square,to:canvas,targetAlign:.topleft,toAlign:.topleft)
 * EXAMPLE: let size = Constraint.size(square,to:canvas)
 * EXAMPLE: NSLayoutConstraint.activate([anchor.x,anchor.y,size.w,size.h])
 */
public class Constraint{
   /**
    * Creates a positional constraint
    */
   public static func anchor(_ view:UIView,to:UIView,align:Alignment,alignTo:Alignment,offset:CGPoint = CGPoint(), useMargin:Bool = false) -> (x:NSLayoutConstraint,y:NSLayoutConstraint) {/*,offset:CGPoint = CGPoint()*/
      let horConstraint = Constraint.anchor(view, to: to, align: align.horAlign, alignTo: alignTo.horAlign,offset:offset.x,useMargin:useMargin)
      let verConstraint = Constraint.anchor(view, to: to, align: align.verAlign, alignTo: alignTo.verAlign,offset:offset.y,useMargin:useMargin)
      return (horConstraint,verConstraint)
   }
   /**
    * creates a dimensional constraint
    * EXAMPLE: let widthConstraint = Constraint.size(square,to:canvas,axis:.horizontal).w
    */
   public static func size(_ view:UIView, to:UIView) -> (w:NSLayoutConstraint,h:NSLayoutConstraint){
      let widthConstraint = Constraint.width(view,to:to)
      let heightConstraint = Constraint.height(view,to:to)
      return (widthConstraint,heightConstraint)
   }
   /**
    * EXAMPLE: let sizeConstraint = Constraint.size(square,size:CGSize(100,100))
    */
   public static func size(_ view:UIView, size:CGSize, multiplier:CGSize = CGSize(width:1,height:1)) -> (w:NSLayoutConstraint,h:NSLayoutConstraint){
      let widthConstraint = Constraint.width(view, width: size.width, multiplier: multiplier.width)
      let heightConstraint = Constraint.height(view, height: size.height, multiplier: multiplier.height)
      return (widthConstraint,heightConstraint)
   }
}
//size
extension Constraint{
   /**
    * New
    */
   public static func width(_ view:UIView, width:CGFloat, multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: width)//NSLayoutAttribute
   }
   /**
    * New
    */
   public static func height(_ view:UIView,height:CGFloat,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: height)//NSLayoutAttribute
   }
   /**
    * Creates a size constraint
    * EXAMPLE: let widthConstraint = Constraint.width(square,to:canvas,axis:.horizontal)
    */
   public static func width(_ view:UIView,to:UIView,offset:CGFloat = 0,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: to, attribute: .width, multiplier: multiplier, constant: offset)//NSLayoutAttribute.notAnAttribute
   }
   /**
    * New
    */
   public static func height(_ view:UIView,to:UIView,offset:CGFloat = 0,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: to, attribute: .height, multiplier: multiplier, constant: offset)//NSLayoutAttribute.notAnAttribute
   }
   /**
    * New
    * NOTE: Useful if you want to set a width of an object to the height of another object
    * NOTE: You can also use it on it's own view to copy width to height for instance
    */
   public static func length(_ view:UIView,to:UIView,viewAxis:Axis,toAxis:Axis,offset:CGFloat = 0,multiplier:CGFloat = 1) -> NSLayoutConstraint{
      let viewAttr:NSLayoutConstraint.Attribute = viewAxis == .horizontal ? .width : .height
      let toAttr:NSLayoutConstraint.Attribute = toAxis == .horizontal ? .width : .height
      return NSLayoutConstraint(item: view, attribute: viewAttr, relatedBy: .equal, toItem: to, attribute: toAttr, multiplier: multiplier, constant: offset)//NSLayoutAttribute.notAnAttribute
   }
}
//anchor
extension Constraint{
   //x hor
   public static func anchor(_ view:UIView, to:UIView, align:HorizontalAlign, alignTo:HorizontalAlign, offset:CGFloat = 0, useMargin:Bool = false) -> NSLayoutConstraint {/*,offset:CGPoint = CGPoint()*/
      return NSLayoutConstraint(item: view, attribute: Constraint.layoutAttr(align), relatedBy: .equal, toItem: to, attribute: Constraint.layoutAttr(alignTo,useMargin:useMargin), multiplier: 1.0, constant: offset)
   }
   //y ver
   public static func anchor(_ view:UIView, to:UIView, align:VerticalAlign, alignTo:VerticalAlign, offset:CGFloat = 0, useMargin:Bool = false) -> NSLayoutConstraint {/*,offset:CGPoint = CGPoint()*/
      return NSLayoutConstraint(item: view, attribute: Constraint.layoutAttr(align), relatedBy: .equal, toItem: to, attribute: Constraint.layoutAttr(alignTo,useMargin:useMargin), multiplier: 1.0, constant: offset)
   }
   //    static func anchor(_ view:UIView, align:Alignment, offset:CGPoint = CGPoint()) -> (x:NSLayoutConstraint,y:NSLayoutConstraint){
   //        let x = NSLayoutConstraint(item: view, attribute: Constraint.layoutAttr(align.horAlign), relatedBy: .equal, toItem: nil, attribute: Constraint.layoutAttr(align.horAlign), multiplier: 1.0, constant: offset.x)
   //        let y = NSLayoutConstraint(item: view, attribute: Constraint.layoutAttr(align.verAlign), relatedBy: .equal, toItem: nil, attribute: Constraint.layoutAttr(align.verAlign), multiplier: 1.0, constant: offset.y)
   //        return (x,y)
   //    }
}
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
 * Utils when working with constraints
 */
extension NSLayoutConstraint{
   /**
    * Returns all constraints of kinds
    * EXAMPLE: NSLayoutConstraint.ofKind(rect.immediateConstraints, kinds: [.width,.height]) //width, height
    */
   public static func ofKind(_ constraints:[NSLayoutConstraint], kinds:[NSLayoutConstraint.Attribute]) -> [NSLayoutConstraint]{
      return kinds.map { kind in
         return constraints.filter { constraint in
            return constraint.firstAttribute == kind
         }
         }.flatMap({$0})//flattens 2d array to 1d array
   }
}
extension UIView {
   /**
    * Deactivates immediate constraints that target this view (self + superview)
    * TODO: ⚠️️ Consider removing this
    */
   public func deactivateImmediateConstraints(){
      NSLayoutConstraint.deactivate(self.immediateConstraints)
   }
   /**
    * Deactivates all constrains that target this view
    * TODO: ⚠️️ Consider removing this
    */
   public func deactiveAllConstraints(){
      NSLayoutConstraint.deactivate(self.allConstraints)
   }
   /**
    * Gets self.constraints + superview?.constraints for this particular view
    * NOTE: You can use immediateConstraints when you don't want to crawl entire hierarchies.
    * TODO: ⚠️️ Consider removing this
    */
   public var immediateConstraints:[NSLayoutConstraint]{
      let constraints = self.superview?.constraints.filter{
         $0.firstItem as? UIView === self /*|| $0.secondItem as? UIView === self*/ //<- this removes constraints that other views might have to this view
         } ?? []
      return self.constraints + constraints
   }
   /**
    * Crawls up superview hierarchy and gets all constraints that affect this view
    * TODO: ⚠️️ Consider removing this
    */
   public var allConstraints:[NSLayoutConstraint] {
      var view: UIView? = self
      var constraints:[NSLayoutConstraint] = []
      while let currentView = view {
         constraints += currentView.constraints.filter {
            return $0.firstItem as? UIView === self || $0.secondItem as? UIView === self //<- this removes constraints that other views might have to this view
         }
         view = view?.superview
      }
      return constraints
   }
}
/**
 * Convenient
 */
extension UIView{
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
#endif

