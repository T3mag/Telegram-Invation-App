import UIKit

struct Images {
    
    /// Параметр настройки ellipsisCircleFill (системного изображения "кружочка с 3 точками")
    static private let ellipsisCircleFillImageConfigure = UIImage.SymbolConfiguration(
        pointSize: 25, weight: .regular)
    
    /// Параметр настройки plus  (системного изображения "Плюс")
    static private let plusImageConfigure = UIImage.SymbolConfiguration(
        pointSize: 23, weight: .regular)
    
    /// Параметр настройки plus  (системного изображения "Плюс")
    static private let linkСircleFillImageConfigure = UIImage.SymbolConfiguration(
        pointSize: 40, weight: .regular)
    
    /// Изображение ellipsisCircleFill (системного изображения "кружочка с 3 точками")
    static let elipsisCircleFillImage = UIImage(systemName: "ellipsis.circle.fill",
                               withConfiguration: ellipsisCircleFillImageConfigure)
    
    /// Изображение plus  (системного изображения "Плюс")
    static let plusImage = UIImage(systemName: "plus",
                                   withConfiguration: plusImageConfigure)
    
    /// Изображение link.circle.fill  (системного изображения "кружок с цепью")
    static let linkCircleFill = UIImage(named: "link.Circle.Fill")
}
