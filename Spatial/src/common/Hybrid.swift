#if os(iOS)
import UIKit
public typealias View = UIView
public typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import Cocoa
public typealias View = LayerView
public typealias EdgeInsets = NSDirectionalEdgeInsets
#endif
