//
//  CoreDataManager.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/6/24.
//


import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let entityName = "Projects"
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ai_logo") // Replace with your Core Data model name
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Image from URL to Documents Directory
    func saveImageFromURLToDocumentsDirectory(_ imageURL: String, withName name: String) -> String? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(name).jpg")
        
        // Check if the image already exists in the Documents Directory
        if fileManager.fileExists(atPath: fileURL.path) {
            return fileURL.path // Return the file path if already exists
        }
        
        // Convert the string to a URL
        guard let url = URL(string: imageURL) else {
            print("Invalid URL string: \(imageURL)")
            return nil
        }
        
        do {
            // Download the image data from the URL
            let imageData = try Data(contentsOf: url)
            
            // Write the data to the Documents Directory
            try imageData.write(to: fileURL)
            return fileURL.path // Return the file path after saving
        } catch {
            print("Error saving image from URL to Documents Directory: \(error)")
            return nil
        }
    }

    // MARK: - Save Record
    func saveRecord(prompt: String, imageURL: String) {
        let imageName = UUID().uuidString
           
           guard let imgPath = saveImageFromURLToDocumentsDirectory(imageURL, withName: imageName) else {
               print("Failed to save image.")
               return
           }
       
//        let newImageEntity = Projects(context: CoreDataManager.shared.context)
//        newImageEntity.prompt = prompt
//        newImageEntity.imgPath = imgPath
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)

        entity.setValue(prompt, forKey: "prompt")
        entity.setValue(imgPath, forKey: "imgPath")
        
        do {
            try context.save()
            print("Record saved successfully.")
        } catch {
            print("Failed to save record: \(error)")
        }
    }
    
    // MARK: - Fetch Records
    func fetchRecords() -> [Projects] {
        let fetchRequest = NSFetchRequest<Projects>(entityName: entityName)
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch records: \(error)")
            return []
        }
    }
    
//    func fetchRecords() -> [Projects] {
//        let fetchRequest: NSFetchRequest<Projects> = Projects.fetchRequest()  // Use the fetchRequest method on Projects directly
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            print("Failed to fetch records: \(error)")
//            return []
//        }
//    }

    
    // MARK: - Load Image from Documents Directory
    func loadImage(fromPath path: String) -> UIImage? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) {
            return UIImage(contentsOfFile: path)
        }
        return nil
    }
    
    // MARK: - Delete Record
    func deleteRecord(_ record: NSManagedObject) {
        // Remove image from Documents Directory
        if let imgPath = record.value(forKey: "imgPath") as? String {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: imgPath) {
                do {
                    try fileManager.removeItem(atPath: imgPath)
                } catch {
                    print("Failed to delete image file: \(error)")
                }
            }
        }
        
        // Remove Core Data record
        context.delete(record)
        do {
            try context.save()
            print("Record deleted successfully.")
        } catch {
            print("Failed to delete record: \(error)")
        }
    }
    
    func deleteAllProjects() {
        let fetchRequest: NSFetchRequest<Projects> = Projects.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            for project in results {
                context.delete(project)
            }
            
            // Save the context to persist the changes
            try context.save()
            print("All projects have been deleted.")
        } catch {
            print("Error deleting projects: \(error.localizedDescription)")
        }
    }
}
