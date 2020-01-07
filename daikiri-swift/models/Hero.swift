import Foundation
import CoreData

class Hero : Daikiri {
    @objc let name:String
    @objc let age:Int
      
    init(_ name:String, age:Int){
        self.name = name
        self.age = age
        super.init(managed:nil)
        self.id = 10
    }
    
    required init(managed: NSManagedObject?) {
        self.name = "Spiderman"
        self.age = 16
        super.init(managed: managed)
    }
    
}
