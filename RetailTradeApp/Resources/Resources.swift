//
//  R.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit

enum R {
    
    //MARK: - All colors in app
    enum Color {
        static let active = UIColor(hexString: "#553881")
        static let inactive = UIColor(hexString: "#FFFFFE")
        static let separator = UIColor(hexString: "#48494E")
        static let tabBatColor = UIColor(hexString: "#12141A")
        static let tabBatColorActive = UIColor(hexString: "#aa70ff")

        
        static let backgroundDetailVC = UIColor(hexString: "#9462DF")
        static let background = UIColor(hexString: "#101116")
        //        static let secondary = UIColor(hexString: "#F0F3FF")
        //        static let subTitleGray = UIColor(hexString: "#9BA4B0")
    }
    
    //MARK: - All strings in app
    enum Strings {
        
        enum Overview {
            static let allWorkouts = "All Workouts"
            static let textNavBar = "Today"
        }
        
        enum AllData {
            static let navBarLeftStart = "Start   "
            static let navBarLeftPause = "Pause"
        }
        
        enum Setting {
            static let navBarLeftStart = "Start   "
            static let navBarLeftPause = "Pause"
        }
    }
    
    enum TabBar {
        static func title(for Tab: Tabs) -> String {
            switch Tab {
            case .overview:
                return "Главный экран"
            case .allData:
                return "Все продажи"
            case .allMonth:
                return "Доходы по месяцам"
            case .setting:
                return "Настройки"
            
            }
            
        }
    }
    
    //MARK: - All images in app
    
    enum Images {
        enum TabBar {
            static func icon(for tab: Tabs) -> UIImage? {

                switch tab {
                case .overview:
                    return UIImage(named: "wallet")
                case .allData:
                    return UIImage(named: "squares")
                case .setting:
                    return UIImage(named: "gear")
                case .allMonth:
                    return UIImage(systemName: "calendar")?.resizeImageTo(size: CGSize(width: 20, height: 17))
                }
            }
        }
    }
        
        //MARK: - All common files in app
        enum Common {
            static let downArrow = UIImage(named: "DownArrow")
            static let add = UIImage(named: "Add")
            
        }
        
        //MARK: - All fonts in app
        enum Fonts {
            static func helvelticaRegular(with size: CGFloat)-> UIFont {
                UIFont(name: "Helvetica", size: size) ?? UIFont()
            }
        }
}

