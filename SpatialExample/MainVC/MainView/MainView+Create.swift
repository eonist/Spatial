import UIKit
import With

extension MainView {
   /**
    * Create the FlowView
    * - Abstract: tests rounded corners, distribution of items etc
    */
   func createCardView() -> CardView {
      let view: CardView = .init()//.init(frame: .init(origin: .zero, size: screenSize))
      self.addSubview(view)
      let offset: CGPoint = .init(x:CardView.margin.left, y:CardView.margin.top)
      let sizeOffset: CGSize = .init(width: -(CardView.margin.left + CardView.margin.right), height: -(CardView.margin.top + CardView.margin.bottom))
      view.anchorAndSize(to: self, offset: offset, sizeOffset: sizeOffset)
      return view
   }
   /**
    * Create spacing test view
    * - Abstract tests: distributeAndSize, spaceBetween, spaceAround etc
    */
   func createSpacingTestView() -> SpacingTestView {
      let view: SpacingTestView = .init()
      self.addSubview(view)
      view.backgroundColor = .green
      //      view.applyAnchorAndSize(to: self)
      view.anchorAndSize(to: self)
      return view
   }
   /**
    * Test minimums
    */
   func createMinMaxView() -> MinMaxTestView {
      let view: MinMaxTestView = .init()
      self.addSubview(view)
      view.backgroundColor = .lightGray
      view.anchorAndSize(to: self, height: 120)
      return view
   }
   /**
    *
    */
   func createTestView() -> TestView {
      let view: TestView = .init()
      self.addSubview(view)
      view.backgroundColor = .lightGray
      view.anchorAndSize(to: self, height: 120)
      return view
   }
   /**
    * sizeTestingView
    * - Abstract: Creates an inner box with padding of 24px
    */
   func createSizeTestingView() -> SizeTestingView {
      return with(.init()) {
         addSubview($0)
         $0.anchorAndSize(to: self)
      }
   }
}
