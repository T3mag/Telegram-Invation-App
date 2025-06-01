import Foundation
import UIKit
import CoreGraphics

struct Colors {
    
    /// Цвет для background дополнительных эллементов
    static let darkGray = UIColor(cgColor: CGColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1))
    /// Цвет текста в приложении
    static let light1Gray = UIColor(cgColor: CGColor(red: 135/256, green: 135/256, blue: 135/256, alpha: 1.0))
    /// Цвет кнопки настройки ссылки в приложении
    static let light2Gray = UIColor(cgColor: CGColor(red: 124/256, green: 124/256, blue: 124/256, alpha: 0.9))
    /// Цвет Разделительной линии
    static let light3Gray = UIColor(cgColor: CGColor(red: 124/256, green: 124/256, blue: 124/256, alpha: 0.9))
    /// Светло черный
    static let lightBlack = UIColor(cgColor: CGColor(red: 13/256, green: 13/256, blue: 13/256, alpha: 1))
    /// Голубой для кнопок "Копировать" и "Поделиться" и надписей
    static let lightBlue = UIColor(cgColor: CGColor(red: 50/255, green: 113/255, blue: 245/255, alpha: 1))
    /// Серый для выделения ячеек
    static let selectedGray = UIColor(cgColor: CGColor(red: 37/255, green: 36/255, blue: 39/255, alpha: 1))
    
    // Цвета пользователлей по accient id
    /// id = 0 - red
    static let red = UIColor.red
    /// id = 1 - orange
    static let orange = UIColor(red:1.00, green:0.73, blue:0.36, alpha:1)
    /// id = 2 - purple
    static let purple_violet = UIColor.purple
    /// id = 3 - красный
    static let green = UIColor.green
    /// id = 4 - cyan
    static let cyan = UIColor.cyan
    /// id = 5 - blue
    static let blue = UIColor.blue
    /// id = 6 - pink
    static let pink = UIColor.systemPink
}

