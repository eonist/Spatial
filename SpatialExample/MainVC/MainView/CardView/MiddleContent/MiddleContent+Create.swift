import UIKit

extension MiddleContent {
   /**
    * Create items
    */
   func createItemViews() -> [ItemView] {
      let itemViews: [ItemView] = (0..<5).map {_ in
         let itemView: ItemView = .init(frame: .zero)
         self.addSubview(itemView)
         return itemView
      }
      itemViews.distributeAndSize(dir: .ver, width: self.frame.width, height: 48, spacing: 12, offset: 24)
      return itemViews
   }
}
