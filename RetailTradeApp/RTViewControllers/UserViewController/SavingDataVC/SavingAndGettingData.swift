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

enum CaseChooseData: String, CaseIterable {
    case currentDateEnum = "Текущий месяц";
    case productEntityEnum = "Все продажи";
    case modelOverviewEnum = "Все масяца";
}

class SavingAndGettingData: BaseController {
    
    var caseChoose = CaseChooseData.currentDateEnum
    
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
        button.makeSystem(button)
        button.backgroundColor = .systemBlue
        button.showsMenuAsPrimaryAction = true
        button.menu = makeDropDownMenu()
//        button.addTarget(self, action: #selector(loadingData), for: .touchUpInside)
        return button
    }()
    
    ///Меню из двух пунктов
    func makeDropDownMenu() -> UIMenu {
        let currentDateEnum = UIAction(title: CaseChooseData.currentDateEnum.rawValue, image: UIImage(systemName: "clock")) { _ in
            self.caseChoose = .currentDateEnum
            self.loadingData()
        }
        let modelOverviewEnum = UIAction(title: CaseChooseData.modelOverviewEnum.rawValue, image: UIImage(systemName: "calendar")) { _ in
            self.caseChoose = .modelOverviewEnum
            self.loadingData()
        }
        let productEntityEnum = UIAction(title: CaseChooseData.productEntityEnum.rawValue, image: UIImage(systemName: "list.bullet.circle")) { _ in
            self.caseChoose = .productEntityEnum
            self.loadingData()
        }
        return UIMenu(title: "", children: [modelOverviewEnum, productEntityEnum, currentDateEnum])
    }
    
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
        let eventRequestProductEntity: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        let eventRequestModelOverview: NSFetchRequest<ModelOverview> = ModelOverview.fetchRequest()

        do {
//            let pathOne: String = "Данные с главного меню.txt"
//            let pathTwo: String = "Все продажи.txt"
//            let pathThrid: String = "Все месяца.txt"

            let messageDataCurrentDate = try context.fetch(eventRequestCurrentDate)
            let jsonDataCurrentDate = try JSONEncoder().encode(messageDataCurrentDate)
            let reqJSONStrCurrentDate = String(data: jsonDataCurrentDate, encoding: .utf8)
            
            let messageDataProductEntity = try context.fetch(eventRequestProductEntity)
            let jsonDataProductEntity = try JSONEncoder().encode(messageDataProductEntity)
            let reqJSONStrProductEntity = String(data: jsonDataProductEntity, encoding: .utf8)
            
            let messageDataModelOverview = try context.fetch(eventRequestModelOverview)
            let jsonDataModelOverview = try JSONEncoder().encode(messageDataModelOverview)
            let reqJSONStrModelOverview = String(data: jsonDataModelOverview, encoding: .utf8)

            let activity = UIActivityViewController(activityItems: [
                reqJSONStrCurrentDate as Any,
                reqJSONStrProductEntity as Any,
                reqJSONStrModelOverview as Any
                                                                   ], applicationActivities: [])
            activity.popoverPresentationController?.sourceView = self.view
            activity.popoverPresentationController?.sourceRect = self.view.frame
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
//MARK: - UIDocumentPickerDelegate
extension SavingAndGettingData: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        switch caseChoose {
        case .currentDateEnum:
            getDataCurrentDatum(urls: urls)
            break
        case .modelOverviewEnum:
            getDataModelOverview(urls: urls)
            break
        case .productEntityEnum:
            getDataProductEntity(urls: urls)
            break
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - getDataProductEntity, getDataCurrentDatum, getDataModelOverview
extension SavingAndGettingData {
    
    func getDataProductEntity(urls: [URL]) {
        guard let documentsUrl: URL = urls.first else { return print("Нет urls") }
        guard let documentData = try? Data(contentsOf: urls.first!) else { return print("Нет urls в documentData") }
        guard let json = try? JSONDecoder().decode([CurrentDatumProductEntity].self, from: documentData) else { return print("Нет json") }
        json.forEach {
//            print("json: \(String(describing: $0.priceGross))")
//            print("json: \(String(describing: $0.priceProfit))")
//            print("json: \(String(describing: $0.data))")
//            print("json: \(String(describing: $0.image))")

            let newItemModel = ProductEntity(context: context)
            newItemModel.name = $0.name
            newItemModel.priceGross =  Int32(Int($0.priceGross!))
            newItemModel.priceProfit = Int32(Int($0.priceProfit!))
            newItemModel.data = $0.data
            newItemModel.image = $0.image
        }
        do { try context.save() } catch { print("Не сохранилася context.save в CurrentDate") }
        dismiss(animated: true)
    }
    
    func getDataCurrentDatum(urls: [URL]) {
        guard let documentsUrl: URL = urls.first else { return print("Нет urls") }
        guard let documentData = try? Data(contentsOf: urls.first!) else { return print("Нет urls в documentData") }
        guard let json = try? JSONDecoder().decode([CurrentDatum].self, from: documentData) else { return print("Нет json") }
        json.forEach {
            print("json: \(String(describing: $0.currentAmount))")
            print("json: \(String(describing: $0.currentProfit))")
            print("json: \(String(describing: $0.currentGross))")
            
            let newItemModel = CurrentDate(context: context)
            newItemModel.currentProfit =  Int32(Int($0.currentProfit!))
            newItemModel.currentGross = Int32(Int($0.currentGross!))
        }
        do { try context.save() } catch { print("Не сохранилася context.save в CurrentDate") }
        dismiss(animated: true)
    }
    
    func getDataModelOverview(urls: [URL]){
        guard let documentsUrl: URL = urls.first else { return print("Нет urls") }
        guard let documentData = try? Data(contentsOf: urls.first!) else { return print("Нет urls в documentData") }
        guard let json = try? JSONDecoder().decode([CurrentDatumModelOverview].self, from: documentData) else { return print("Нет json") }
        json.forEach {
            print("json: \(String(describing: $0.nameMonth))")
            print("json: \(String(describing: $0.totalGross))")
            print("json: \(String(describing: $0.totalProfit))")
            print("json: \(String(describing: $0.totalAmount))")
            
            let newItemModel = ModelOverview(context: context)
            newItemModel.totalAmount =  Int32(Int($0.totalAmount!))
            newItemModel.totalGross = Int32(Int($0.totalGross!))
            newItemModel.totalProfit = Int32(Int($0.totalProfit!))
            newItemModel.nameMonth = String($0.nameMonth!)
            
        }
        do { try context.save() } catch { print("Не сохранилася context.save в ModelOverview") }
        dismiss(animated: true)
    }
}
