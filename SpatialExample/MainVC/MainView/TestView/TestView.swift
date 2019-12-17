import UIKit
import With
/**
 * Out of order
 */
class TestView: UIView {
   lazy var descLabel: UILabel = createDescLabel()
   lazy var inputTextField: UITextField = createInputTextField()
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.backgroundColor = .purple
      _ = descLabel
      descLabel.text = "Desc"
      _ = inputTextField
      inputTextField.text = "Some details about"
   }
   /**
    * Boilerplate
    */
   @available(*, unavailable)
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
