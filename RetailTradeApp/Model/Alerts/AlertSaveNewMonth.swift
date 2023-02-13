//
//  AlertSaveNewMonth.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 13.02.2023.
//

import UIKit

extension UIViewController {
        
    func AlertSaveNewMonth(completionHandle: @escaping(Bool)->Void){
        let alertController = UIAlertController(title: nil, message: "Сохранить данные этого месяца", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel){ _ in
            completionHandle(false)
        }

        let saveNewMonth = UIAlertAction(title: "Ok", style: .default){ _ in
            completionHandle(true)
        }
        
        alertController.addAction(cancel)
        alertController.addAction(saveNewMonth)

        present(alertController, animated: true)
        
    }
    
}
