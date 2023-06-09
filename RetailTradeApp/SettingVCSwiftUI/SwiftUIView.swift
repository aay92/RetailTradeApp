//
//  SwiftUIView.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 22.03.2023.
//

import SwiftUI
import CoreData


struct SwiftUIView: View {

    @FetchRequest(entity: CurrentDate.entity(), sortDescriptors: [],
                  animation: .easeInOut(duration: 0.3)) private var purchaseItem: FetchedResults<CurrentDate>

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @Environment(\.managedObjectContext) var mocContext

    
    @State private var addExpanse: Bool = false
    @State private var presentShareSheet: Bool = false
    @State private var shareURL: URL = URL(string: "https://apple.com")!
    @State private var presentFilePicker: Bool = false
    @State private var checkOnEmptyBool: Bool = false

    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(){
        Rectangle()
            .fill(Gradient(colors: [.indigo, .purple]))
            .ignoresSafeArea()
            VStack(spacing: 50){
                Text("Сохранить или загрузить данные из библиотеки?")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(10)
                    .padding(.top, 100)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                HStack(){
                    Button("Сохранить данные", action: exportCoreData)
                        .frame(width: 180 ,height: 50)
                        .tint(.white)
                        .background(Color(.systemBlue))
                        .cornerRadius(20)
    
                    Button("Загрузить данные"){
                        checkOnEmpty()
//                      presentFilePicker.toggle()
                    }
                    .frame(width: 180 ,height: 50)
                    .tint(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(20)
                    .alert("У Вас есть данные, сохранить перед удалением?", isPresented: $checkOnEmptyBool) {
                        Button("Да", role: .none) {
                                exportCoreData()
                            }
                        Button("Нет", role: .none) {
                            presentFilePicker.toggle()
                        }
                    }
                }
                .sheet(isPresented: $presentShareSheet) {
                    deleteTempFile()
                    dismiss()
                } content: {CustomShareSheet(url: $shareURL)}
                ///File importer (for selecting JSON file from files app)
                    .fileImporter(isPresented: $presentFilePicker, allowedContentTypes: [.json]) { result in
                    switch result {
                    case .success(let success):
                        importJSON(success)
                        dismiss()
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
                Spacer()
            }
        }
    }
    ///checkOnEmpty
    func checkOnEmpty(){
        var isEmpty: Bool {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentDate")
                let count  = try context.count(for: request)
                return count == 0
            } catch {
                return true
            }
        }
        if isEmpty {
            checkOnEmptyBool = false
            presentFilePicker.toggle()
        }
        else {
            checkOnEmptyBool = true
        }
    }

    ///Importing json file and adding to core data
    func importJSON(_ url: URL){
        var items = [CurrentDate]()
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.userInfo[.managedObjectContext] = context
            items = try decoder.decode([CurrentDate].self, from: jsonData)
            /// since it's already loaded in context, simply save the context
        } catch {
            ///Do Action
            print(error.localizedDescription)
        }
        try? context.save()
        print("File Imported Successfully2: \(items.count)")
    }
    
    func deleteTempFile(){
        do {
            try FileManager.default.removeItem(at: shareURL)
            print("Removed Temp json file")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func exportCoreData(){
        
        do {
///Step 1
///Fetching all Core data Items for the Entity using Swift Way
            if let entityName = CurrentDate.entity().name {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let items = try context.fetch(request).compactMap {
                    $0 as? CurrentDate
                }
                ///Step 2
                ///Converting item to json string file
                let jsonData = try JSONEncoder().encode(items)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    ///saving into  temporary document and sharing it via shareSheet
                    if let tempURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let pathURL = tempURL.appending(component: "Export\(Date().formatted(date: .complete, time: .omitted)).json")
                        try jsonString.write(to: pathURL, atomically: true, encoding: .utf8)
                        ///saved successfully
                        shareURL = pathURL
                        presentShareSheet.toggle()
                    }
                }
            }
        } catch {
//            DO ACTION
            print(error.localizedDescription)
        }
    }

}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView().environment(\.managedObjectContext, )
//
//    }
//}

struct CustomShareSheet: UIViewControllerRepresentable {
    @Binding var url: URL
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
}


/*
class UserManager: NSObject {

    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "CurrentDate")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let url = Bundle.main.url(forResource: "Users", withExtension: "momd")!
            let storeDescription = NSPersistentStoreDescription(url: url)
            container.add(storeDescription)
        }
        super.init()
    }
    
    func loadUsersFromFile() -> [User] {
        guard let userData = UserData.load(from: .inMemory) else { return [] }
        return userData.users
    }
}

extension UserManager {
    class func load(from storeURL: URL) -> UserData? {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = nil
        
        let fetchRequest = NSFetchRequest<CurrentDate>()
        fetchRequest.entity = CurrentDate.entity()
        
        do {
            guard let storeData = try CurrentDate(context: managedObjectContext).load() else { return nil }
            return storeData
        } catch {
            managedObjectContext.
        }
*/
