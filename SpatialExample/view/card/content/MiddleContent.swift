
import UIKit

class MiddleContent:UIView{
   override init(frame: CGRect) {
      super.init(frame: frame)
//      self.layer.cornerRadius = 24
      self.backgroundColor = .yellow
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

//let height = self.frame.height - margin.top.bottom-topbarheight-bottombarheight
//add it
//make bottombar align to bottom of contentview
//look at weatherApp gesture code
