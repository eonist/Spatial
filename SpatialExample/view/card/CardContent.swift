
import UIKit

class CardMainView:UIView{
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.layer.cornerRadius = 24
      self.backgroundColor = .green
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
