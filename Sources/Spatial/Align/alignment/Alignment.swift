import Foundation
/**
 * Alignment types (Both axises)
 * - Fixme: ⚠️️ Add none?
 * - Fixme: ⚠️️ Make own Carthage framework named Align?
 * - Note: use Alignment.topLeft.rawValue if you want to get the string "topLeft"
 */
public enum Alignment: String {
    case topLeft, topCenter, topRight, bottomLeft, bottomCenter, bottomRight, centerLeft, centerRight, centerCenter
}
