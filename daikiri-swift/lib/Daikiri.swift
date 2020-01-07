import Foundation
import CoreData
import RevoFoundation

class Daikiri : NSObject {
    
    var id:Int?
    
    static var entityName : String {
        String(describing: type(of: Self.self)).replace(".Type", "")
    }
    
    private var context : NSManagedObjectContext {
        DaikiriCoreData.shared.context
    }
    
    public static var query:QueryBuilder{
        QueryBuilder(entityName)
    }
    
    public func create() {
        let entity  = NSEntityDescription.entity(forEntityName: Self.entityName, in:context)!
        let managed = NSManagedObject(entity:entity, insertInto: context)
        toManaged(managed)
    }
    
    public func update() -> Bool {
        /*guard let previous = find(id) else {
            return false;
        }

        previous.destroy()
        save()*/
        return true
    }
    
    public func delete() {
        
    }
    
    private func toManaged(_ managed:NSManagedObject){
        var mirror:Mirror? = Mirror(reflecting: self)
        repeat{
            for case let (label?, value) in mirror!.children {
                print(label + " => \(value)")
                managed.setValue(value, forKey: label)
            }
            mirror = mirror?.superclassMirror
        } while mirror != nil
    }
    
    private func fromManaged(_ managed:NSManagedObject){
        var mirror:Mirror? = Mirror(reflecting: self)
        repeat{
            for case let (label?, value) in mirror!.children {
                print(label + " => \(value)")
                self.setValue(managed.value(forKey: label), forKey: label)
            }
            mirror = mirror?.superclassMirror
        } while mirror != nil
    }
    
    // MARK: - Query
    
    public static func find(_ id:Int) -> Daikiri? {
        //query.whereField(id, is:id).first()
        return nil
    }
    
    public func all() -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Self.entityName)
        do{
            return try context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
}
