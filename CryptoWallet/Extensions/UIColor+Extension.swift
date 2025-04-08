import UIKit

extension UIColor {
    //Основной бэк цвет адаптивный тёмный/светлый
    static var backgroundMain: UIColor {
        return UIColor(named: "Background/main" ) ?? systemBackground
    }
    //Основной цвет текста светлый/темный
    static var textPrimary: UIColor {
        return UIColor(named: "Text/primary" ) ?? .label
    }
    //Основной бэк хэдера
    static var accentPink: UIColor {
        return UIColor(named: "Background/pink" ) ?? systemPink
    }
    //основной текст цвета в хэдере
    static var textHeader: UIColor {
        return UIColor(named: "Text/header" ) ?? .label
    }
}
