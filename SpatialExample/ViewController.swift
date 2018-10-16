import UIKit


//card
   //RoundedCorners ✅
   //12 margin ✅
   //bottom 👈
      //dayText
      //weatherSymbolGraphic
      //tempText
   //top ✅
      //make mask ✅
      //Country,city
   //content 👈
      //centerGraphic
         //WeatherSymbolGraphic
         //DegreeText
         //weatherTypeText
//add card interaction
   //interuptle
   //
//make .pin and .stretch 👈

class ViewController: UIViewController {
   lazy var mainView:MainView = createMainView()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      _ = mainView
      self.view.backgroundColor = .purple
   }
   override var prefersStatusBarHidden:Bool {return true}/*hides statusbar*/
}
