import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
   @IBOutlet weak var window: NSWindow!
   /**
    * Creates the view
    */
   lazy var view: NSView = createView()
   func applicationDidFinishLaunching(_ aNotification: Notification) {
      _ = view
   }
}
extension AppDelegate {
   func createView() -> NSView {
      let contentRect = window.contentRect(forFrameRect: window.frame)/*size of win sans titlebar*/
      let view: MainView = .init(frame: contentRect)
      window.contentView = view
      view.layer?.backgroundColor = NSColor.white.cgColor
      return view
   }
}
open class MainView: NSView {
   override open var isFlipped: Bool { true }/*TopLeft orientation*/
   /**
    * - Note: animating to new alignments also works 
    */
   override public init(frame: CGRect) {
      super.init(frame: frame)
      Swift.print("hello world")
      self.wantsLayer = true/*if true then view is layer backed*/
      let box = Box()
      addSubview(box)
      box.applyAnchorAndSize(to: self, width: 100, height: 100)
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
         View.animate({
            box.update(offset: .init(x: 100, y: 0), align: .topLeft, alignTo: .topLeft)
         }, onComplete: { Swift.print("done") }, dur: 0.2)
      }
      //
   }
   /**
    * Boilerplate
    */
   public required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
/**
 * Test box
 */
final class Box: NSView, ConstraintKind {
   var anchorAndSize: AnchorAndSize?
   override init(frame frameRect: NSRect = .zero) {
      super.init(frame: frameRect)
      wantsLayer = true
      layer?.backgroundColor = NSColor.systemPurple.cgColor
   }
   /**
    * Boilerplate
    */
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
