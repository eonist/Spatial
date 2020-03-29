import UIKit
import With
/**
 * Create
 */
extension TestView {
   /**
    * Title
    */
   func createDescLabel() -> UILabel {
      with(.init()) {
         let text = "title"
         $0.text = "title"
         $0.font = .boldSystemFont(ofSize: 20.0)
         $0.textColor = .black
         $0.textAlignment = .left
         self.addSubview($0)
         $0.backgroundColor = UIColor.green.withAlphaComponent(0.5)
         $0.layer.borderWidth = 0.5
         $0.layer.borderColor = UIColor.black.cgColor
         let size: CGSize = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 18.0)])
         $0.anchorAndSize(to: self, width: size.width, align: .centerLeft, alignTo: .centerLeft, offset: .init(x: 20, y: 0) )
      }
   }
   /**
    * TextField
    */
   func createInputTextField() -> UITextField {
      with(.init()) {
         $0.font = .systemFont(ofSize: 16)
         $0.textColor = .gray
         $0.textAlignment = .right
         $0.tintColor = .blue
         $0.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
         $0.layer.borderWidth = 0.5
         $0.layer.borderColor = UIColor.green.cgColor
         self.self.addSubview($0)
         $0.activateConstraints { view in
            let y = Constraint.anchor(view, to: self, align: .centerY, alignTo: .centerY)
            let left = Constraint.anchor(view, to: descLabel, align: .left, alignTo: .right)
            left.priority = .init(rawValue: 250)
            let right = Constraint.anchor(view, to: self, align: .right, alignTo: .right, offset: -20)
            return [y, left, right]
         }
      }
   }
}
