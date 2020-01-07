import Foundation
import CoreData

class QueryBuilder{
    
    let entityName : String
    
    let predicates     = [NSPredicate]()
    let sortPredicates = [NSPredicate]()
    
    var skip:Int?
    var take:Int?
    
    public init(_ entityName:String){
        self.entityName = entityName
    }
    
    public func whereField(_ field:String, is:Any) -> QueryBuilder {
        return self
    }
    
    private func doQuery() -> [NSFetchRequestResult]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        
        if let skip = skip {
            request.fetchOffset = skip
        }
        
        if let take = take {
            request.fetchLimit = take
        }
        
        var results: [NSFetchRequestResult]? = nil
        DaikiriCoreData.shared.context.performAndWait {
            do{
                results = try DaikiriCoreData.shared.context.fetch(request) as? [NSFetchRequestResult]
            } catch {
                let nserror = error as NSError
                fatalError("Error fetching objects: \(nserror), \(nserror.userInfo)");
            }
        }
        return results!;
    }
    
    public func get() -> [Any]{
        []
    }
    
    public func first() -> Any{
        []
    }
    
    
}
