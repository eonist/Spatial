import UIKit

class MainView: UIView {
   lazy var cardView: CardView = createCardView()
//   lazy var spacingTestView: UIView = createSpacingTestView()
//   lazy var minMaxTestView: UIView = createMinMaxView()
//   lazy var testView: UIView = createTestView()
//   lazy var sizeTestingView: SizeTestingView = createSizeTestingView()
   override init(frame: CGRect) {
      super.init(frame: frame)
      _ = cardView
//      _ = spacingTestView
//      _ = minMaxTestView
//      _ = testView
//      _ = sizeTestingView
   }
   /**
    * Boilerplate
    */
   @available(*, unavailable)
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
