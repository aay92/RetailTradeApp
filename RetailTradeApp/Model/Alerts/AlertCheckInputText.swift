//
//  AlertCheckInputText.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 14.06.2023.
//

import UIKit

extension UIViewController {
    
    func AlertCheckInputText(title: String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let saveNewMonth = UIAlertAction(title: "Oк", style: .default){ _ in
            //            completionHandle(true)
        }
        alertController.addAction(saveNewMonth)
        present(alertController, animated: true)
    }
}
