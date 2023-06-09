//
//  SavingAndGettingData.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 08.06.2023.
//

import UIKit
import CoreData
import MobileCoreServices
import UniformTypeIdentifiers

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
        var getCoreDate = [CurrentDate]()
        let eventRequestCurrentDate: NSFetchRequest<CurrentDate> = CurrentDate.fetchRequest()
        
        do {
            getCoreDate = try! context.fetch(eventRequestCurrentDate)
            let jsonData = try JSONEncoder().encode(getCoreDate)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let tempURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let pathURL = tempURL.appending(component: "CurrentData\(Date().formatted(date: .complete, time: .omitted)).json")
                    try jsonString.write(to: pathURL, atomically: true, encoding: .utf8)
                    shareURL = pathURL
                    print("getCoreDate pathURL: \(pathURL)")
                    let activity = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
                    activity.popoverPresentationController?.sourceView = self.view
                    self.present(activity, animated: true)
                }
                
                try FileManager.default.removeItem(atPath: jsonString)
            }
        } catch {
            print("Не сохранилась getCoreDate")
        }
    }
    
    @objc private func loadingData(){
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.json, .text])
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
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        dismiss(animated: true)
        
        var items = [CurrentDate]()

            guard url.startAccessingSecurityScopedResource() else {
                return
            }
        
        do {
            let jsonData = try Data(contentsOf: url)
//            decoder.userInfo[.managedObjectContext] = context
            items = try JSONDecoder().decode([CurrentDate].self, from: jsonData)
            for i in items {
                var newItem = CurrentDate(entity: <#T##NSEntityDescription#>, insertInto: <#T##NSManagedObjectContext?#>)
            }
            /// since it's already loaded in context, simply save the context
            print("File Imported Successfully2: \(items.count)")

        } catch {
            ///Do Action
            print(error.localizedDescription)
        }
//        try? context.save()
        print("File Imported Successfully2: \(items.count)")
            defer {
                url.stopAccessingSecurityScopedResource()
            }
    }
}


