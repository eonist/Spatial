import UIKit

class MainView:UIView {
   lazy var cardView:CardView = createCardView()
   lazy var spacingTestView:UIView = createSpacingTestView()
//   override init(frame: CGRect) {
//      super.init(frame: frame)
//
//   }
   override func layoutSubviews() {
      super.layoutSubviews()
      _ = cardView
      //      _ = spacingTestView
   }
//   required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
