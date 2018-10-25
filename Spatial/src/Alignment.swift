import Foundation
/**
 * TODO: ⚠️️ add none?
 */
public enum Alignment:String{/*Both axises*/
    case topLeft = "topLeft"
    case topCenter = "topCenter"
    case topRight = "topRight"
    case bottomLeft = "bottomLeft"
    case bottomCenter = "bottomCenter"
    case bottomRight = "bottomRight"
    case centerLeft = "centerLeft"
    case centerRight = "centerRight"
    case centerCenter = "centerCenter"
}
public enum Axis:String{/*axis alignment*/
    case horizontal = "horizontal"
    case vertical = "vertical"
}
public enum AlignType:String{/*Single axis*/
    case left = "left"
    case right = "right"
    case top = "top"
    case bottom = "bottom"
    case centerHor = "centerHorizontal"
    case centerVer = "centerVertical"
}
public enum HorizontalAlign:String{
    case left = "left"
    case right = "right"
    case centerX = "center"/*use centerX or else .dot syntax fails*/
}
public enum VerticalAlign:String{
    case top = "top"
    case bottom = "bottom"
    case centerY = "centerY"/*use centerY or else .dot syntax fails*/
}
/**
 * Helper util
 */
extension Alignment{
    public var horAlign:HorizontalAlign {
        switch self {
        case .topLeft,.centerLeft,.bottomLeft: return .left
        case .topRight,.bottomRight,.centerRight: return .right
        case .bottomCenter,.topCenter,.centerCenter: return .centerX
        }
    }
    public var verAlign:VerticalAlign {
        switch self {
        case .topRight,.topCenter,.topLeft: return .top
        case .bottomCenter,.bottomRight,.bottomLeft: return .bottom
        case .centerRight,.centerLeft,.centerCenter: return .centerY
        }
    }
}
