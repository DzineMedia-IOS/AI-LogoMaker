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
    func saveImageFromURLToDocumentsDirectory(_ imageURL: String, withName name: String, completion: @escaping (String?) -> Void) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(name).jpg")
        
        // Check if the image already exists in the Documents Directory
        if fileManager.fileExists(atPath: fileURL.path) {
            completion(fileURL.path) // Return the file path if already exists
            return
        }
        
        // Convert the string to a URL
        guard let url = URL(string: imageURL) else {
            print("Invalid URL string: \(imageURL)")
            completion(nil)
            return
        }
        
        // Perform asynchronous download
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received from URL.")
                completion(nil)
                return
            }
            
            do {
                // Write the data to the Documents Directory
                try data.write(to: fileURL)
                completion(fileURL.path) // Return the file path after saving
            } catch {
                print("Error saving image to Documents Directory: \(error)")
                completion(nil)
            }
        }.resume()
    }

  

    // MARK: - Save Record
//    func saveRecord(prompt: String, imageURL: String) {
//        let imageName = UUID().uuidString
//        var imagePath: String?
//        saveImageFromURLToDocumentsDirectory(imageURL, withName: imageName) { [self] savedPath in
//            if let path = savedPath {
//                print("Image saved successfully at: \(path)")
//                imagePath = path
//                // Use the saved path as needed
//                let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
//                
//              
//                entity.setValue(prompt, forKey: "prompt")
//                entity.setValue(imageName, forKey: "imgPath")
//                
//                do {
//                    try context.save()
//                    print("Record saved successfully.")
//                } catch {
//                    print("Failed to save record: \(error)")
//                }
//            } else {
//                print("Failed to save image.")
//            }
//        }
//    }
    
    func saveRecord(prompt: String, imgPath: [String]) {
        // Convert the list of image URLs to a JSON string
        if let imageURLsData = try? JSONSerialization.data(withJSONObject: imgPath, options: []),
           let imageURLsString = String(data: imageURLsData, encoding: .utf8) {
            
            // Create a new entity and save it to Core Data
            let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
            
            entity.setValue(prompt, forKey: "prompt")
            entity.setValue(imageURLsString, forKey: "imgPath") // Save the JSON string
            
            do {
                try context.save()
                print("Record saved successfully with image URLs.")
            } catch {
                print("Failed to save record: \(error)")
            }
        } else {
            print("Failed to convert image URLs to JSON string.")
        }
    }

    
    // MARK: - Fetch Records
//    func fetchRecords() -> [Projects] {
//        let fetchRequest = NSFetchRequest<Projects>(entityName: entityName)
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            print("Failed to fetch records: \(error)")
//            return []
//        }
//    }
    
//    func fetchRecords() -> [Projects] {
//        let fetchRequest: NSFetchRequest<Projects> = Projects.fetchRequest()  // Use the fetchRequest method on Projects directly
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            print("Failed to fetch records: \(error)")
//            return []
//        }
//    }
    
    
    
    func fetchRecords() -> [Projects] {
        let fetchRequest = NSFetchRequest<Projects>(entityName: "Projects")
        do {
            let results = try context.fetch(fetchRequest)
            print("Fetched Records:")
            
            for project in results {
                // Access properties of the 'Projects' entity
                let prompt = project.value(forKey: "prompt") as? String ?? "No Prompt"
                let imgPathsString = project.value(forKey: "imgPath") as? String ?? "[]"
                
                print("Prompt: \(prompt)")
                
                // Decode the JSON string back into an array of URLs
                if let imgPathsData = imgPathsString.data(using: .utf8),
                   let imageURLs = try? JSONSerialization.jsonObject(with: imgPathsData, options: []) as? [String] {
                    print("Image URLs:")
                    for url in imageURLs {
                        print(url)
                    }
                } else {
                    print("Failed to decode image URLs.")
                }
            }
            
            return results
        } catch {
            print("Failed to fetch records: \(error)")
            return []
        }
    }


    
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
