//
//  AlertCheckOnEmpty.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 30.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
//    completionHandle: @escaping(Bool)->Void
    func AlertCheckOnEmpty(title: String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel){ _ in
//            completionHandle(false)
        }
        
        let saveNewMonth = UIAlertAction(title: "Ok", style: .default){ _ in
//            completionHandle(true)
        }
        
        alertController.addAction(cancel)
        alertController.addAction(saveNewMonth)
        
        
        present(alertController, animated: true)
    }
}
