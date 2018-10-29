import Foundation
/**
 * TODO: ⚠️️ add none?
 * TODO: ⚠️️ remove string
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
/**
 * TODO: ⚠️️ remove string
 */
public enum Axis:String{/*axis alignment*/
    case horizontal = "horizontal"
    case vertical = "vertical"
}
/**
 * TODO: ⚠️️ Reference AlignType in HorAlign and VerAlign, and prob use CenterX,CenterY naming instead
 * TODO: ⚠️️ remove string
 */
public enum AlignType:String{/*Single axis*/
    case left = "left"
    case right = "right"
    case top = "top"
    case bottom = "bottom"
    case centerHor = "centerHorizontal"
    case centerVer = "centerVertical"
}
/**
 * TODO: ⚠️️ remove string
 */
public enum HorizontalAlign:String{
    case left = "left"
    case right = "right"
    case centerX = "centerX"/*use centerX or else .dot syntax fails*/
}
/*
 * TODO: ⚠️️ remove string
 */
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
public enum AxisType{/*axis type*/
   case start//left,top
   case middle//centerX,centerY
   case end//right,bottom
}
extension AlignType{
    public var axis:Axis {
        switch self {
        case .top,.bottom,.centerVer: return .vertical
        case .left,.right,.centerHor: return .horizontal
        }
    }
    public var axisType:AxisType {
        switch self {
        case .top,.left: return .start
        case .centerHor, .centerVer: return .middle
        case .bottom,.right: return .end
        }
    }
}
