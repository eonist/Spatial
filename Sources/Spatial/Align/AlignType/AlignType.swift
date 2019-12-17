import Foundation
/**
 * Single align type
 * - Fixme: ⚠️️ Reference AlignType in HorAlign and VerAlign, and prob use CenterX,CenterY naming instead
 * - Note: Use .rawValue if you want to get the string "topLeft"
 * - Note: Could also just do: no type enum and: Swift.print("\(String(describing: TestEnum.three))") // three
 */
public enum AlignType: String {
   case left, right, top, bottom, centerHor, centerVer
}
