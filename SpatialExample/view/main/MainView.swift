import UIKit

class MainView:UIView {
   lazy var cardView:CardView = createCardView()
   lazy var spacingTestView:UIView = createSpacingTestView()
   override init(frame: CGRect) {
      super.init(frame: frame)
       _ = cardView
//      _ = spacingTestView
   }
   required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
