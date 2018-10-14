import UIKit
@testable import Spatial

class ViewController: UIViewController {
   //⚠️️ Use Constraint at first ⚠️️ ✅
   //no TOPBAR OR UI, see Flowlayout, Summon ✅
   //topBar (gray) ✅
   lazy var topBar:TopBar = createTopBar()
      //bt1,btn2,btn3,btn4 (circlular) ✅
   //mainContent (purple) 👈
      //tableView
         //rounded cells, 4 cells, 4 colors
            //later
            //Random between 1 and 3 hor cells
            //flexBoxLike Cells
   //bottombar (magenta)
      //sendBtn,receiveBtn (rounded,green)
   override func viewDidLoad() {
      super.viewDidLoad()
//      Spatial.test()
      _ = topBar
      self.view.backgroundColor = .orange
   }
//   override var prefersStatusBarHidden:Bool {return true}/*hides statusbar*/
}


extension ViewController{
   /**
    * Creates topBar
    */
   func createTopBar() -> TopBar{
      let topBar:TopBar = .init(frame: .zero)
      self.view.addSubview(topBar)
      topBar.activateConstraint { view in
         let anchor = Constraint.anchor(view, to: self.view, align: .topLeft, alignTo: .topLeft)
         let size = Constraint.size(view, size: CGSize.init(width: UIScreen.main.bounds.width, height: TopBar.topBarHeight))
         return [anchor.x,anchor.y,size.w,size.h]
      }
      return topBar
   }
}
