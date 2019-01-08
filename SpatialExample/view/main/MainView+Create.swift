import UIKit
import Spatial
extension MainView{
   /**
    * Create the FlowView
    */
   func createCardView() -> CardView{
//      let screenSize:CGSize = self.frame.size
      let view:CardView = CardView()//.init(frame: .init(origin: .zero, size: screenSize))
      self.addSubview(view)
      view.anchorAndSize(to: self/*, width: screenSize.width, height: screenSize.height*/)
      return view
   }
   /**
    * Create spacing test view
    */
   func createSpacingTestView() -> SpacingTestView{
      let view:SpacingTestView = .init()
      self.addSubview(view)
      view.backgroundColor = .green
      view.anchorAndSize(to: self)
      return view
   }
}
