//
//  SavingAndGettingData.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 08.06.2023.
//

import Foundation
import UIKit
import CoreData
import MobileCoreServices

class SavingAndGettingData: BaseController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var shareURL: URL = URL(string: "https://apple.com")!
    
    private lazy var savingButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Сохранить данные ", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(savingData), for: .touchUpInside)
        button.makeSystem(button)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private lazy var loadingButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Загрузить данные ", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loadingData), for: .touchUpInside)
        button.makeSystem(button)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private func deleteTempFile(tempURL: URL){
        do {
            try FileManager.default.removeItem(at: tempURL)
            print("Removed Temp json file")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc private func savingData(){
        
        let eventRequestCurrentDate: NSFetchRequest<CurrentDate> = CurrentDate.fetchRequest()
        do {
            let messageData = try context.fetch(eventRequestCurrentDate)
            let jsonData = try JSONEncoder().encode(messageData)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let activity = UIActivityViewController(activityItems: [reqJSONStr as Any], applicationActivities: nil)
            present(activity, animated: true, completion: nil)
        } catch {
            print("Нет данных в savingData \(error.localizedDescription)")
        }
    }
    
    
    @objc private func loadingData(){
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.text, .json])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .overFullScreen
        documentPicker.allowsMultipleSelection = true
        present(documentPicker, animated: true)
    }
}

extension SavingAndGettingData {
    override func setupViews(){
        
    }
    override func constraintViews(){
        
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        view.addViewWithoutTAMIC(stack)
        stack.addArrangedSubview(savingButton)
        stack.addArrangedSubview(loadingButton)
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: 50),
            stack.topAnchor.constraint(equalTo: view.topAnchor,constant: height / 2.4),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        ])
        
    }
    override func configureAppereance(){
        view.backgroundColor = R.Color.background
    }
}
extension SavingAndGettingData: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        var items = [CurrentDatum]()
        guard let documentsUrl: URL = urls.first else { return print("Нет urls")}
        print("selected document: \(documentsUrl)")
        guard let documentData = try? Data(contentsOf: urls.first!) else { return print("Нет urls в documentData")}
        guard let json = try? JSONDecoder().decode([CurrentDatum].self, from: documentData) else { return print("Нет json")}
        items = json
        
        items.forEach {
            print("json: \(String(describing: $0.currentAmount))")
            print("json: \(String(describing: $0.currentProfit))")
            print("json: \(String(describing: $0.currentGross))")
            
            var newItemModel = CurrentDate(context: context)
            newItemModel.currentProfit =  Int32(Int($0.currentProfit!))
            newItemModel.currentGross = Int32(Int($0.currentGross!))
            
            do { try context.save() } catch { print("Не сохранилася context.save") }
        }
        dismiss(animated: true)
    }
}

