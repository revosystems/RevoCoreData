import Foundation
import CoreData

class DaikiriCoreData {
    
    public static var shared:DaikiriCoreData = DaikiriCoreData()
    
    public var useTestDatabase = false
    
    public var context:NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    lazy var projectDatabaseName : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    
    var databaseName: String {
        useTestDatabase ? "test" : projectDatabaseName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: databaseName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    public init(){
    
    }

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //=======================================================
    // MARK: - Transactions
    //=======================================================
    public func beginTransaction(){
        if context.undoManager == nil {
            context.undoManager = UndoManager()
        }
        context.undoManager!.beginUndoGrouping()
    }
    public func commit() {
        context.undoManager!.endUndoGrouping()
        context.undoManager!.removeAllActions()
    }
    
    public func rollback() {
        context.undoManager!.endUndoGrouping()
        context.undoManager!.undo()
    }

    public func transaction(callback:() throws -> Void){
        beginTransaction()
        do{
            try callback()
            commit()
        } catch {
            rollback()
        }
    }
}
