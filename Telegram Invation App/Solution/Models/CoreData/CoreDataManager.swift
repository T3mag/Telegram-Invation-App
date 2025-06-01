import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    private init() {
    }
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func createNewEmptyLinks() async {
        let context = backgroundContext
        
        return await backgroundContext.perform { [unowned viewContext] in
            let link = Link(context: context)
            
            link.linkId = UUID()
            link.linkTitile = "Новая ссылка"
            link.countJoined = "вступлений пока нет"
            link.joinedPeoples = []
            
            do {
                try context.save()
                
                return viewContext.performAndWait {
                    do {
                        try viewContext.save()
                    } catch {
                        print("Ошибка сохранения viewConext: \(error)")
                    }
                }
            } catch {
                print("Ошибка сохранения backGroundConext: \(error)")
            }
        }
    }
    
    func addNewPeopleInLinks(link: Link, name: String, date: String, accentColorID: Int16, emojiPath: String, photoPath: String) async {
        let context = backgroundContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return await backgroundContext.perform { [unowned viewContext] in
            // Получаем objectID link из viewContext
            let linkID = link.objectID
            // Создаём прокси-Link в backgroundContext
            let linkInBg = context.object(with: linkID) as! Link
            
            let joinedPeople = JoinedPeoples(context: context)
            joinedPeople.name = name
            joinedPeople.dateJoined = date
            joinedPeople.peopleId = UUID()
            joinedPeople.accentColorID = accentColorID
            joinedPeople.emojiPath = emojiPath
            joinedPeople.photoPath = photoPath
            joinedPeople.link = linkInBg
            
            do {
                try context.save()
                
                return viewContext.performAndWait {
                    do {
                        try viewContext.save()
                    } catch {
                        print("Ошибка сохранения viewConext: \(error)")
                    }
                }
            } catch {
                print("Ошибка сохранения backGroundConext: \(error)")
            }
        }
    }
    
    func createNewEmptyPeopleInLinks(link: Link) async {
        let context = backgroundContext
        
        return await backgroundContext.perform { [unowned viewContext] in
            // Получаем objectID link из viewContext
            let linkID = link.objectID
            // Создаём прокси-Link в backgroundContext
            let linkInBg = context.object(with: linkID) as! Link
            
            let joinedPeople = JoinedPeoples(context: context)
            joinedPeople.name = "Новый чел"
            joinedPeople.dateJoined = "Тут Дата"
            joinedPeople.peopleId = UUID()
            joinedPeople.accentColorID = 1
            joinedPeople.emojiPath = ""
            joinedPeople.photoPath = ""
            joinedPeople.link = linkInBg
            
            do {
                try context.save()
                
                return viewContext.performAndWait {
                    do {
                        try viewContext.save()
                    } catch {
                        print("Ошибка сохранения viewConext: \(error)")
                    }
                }
            } catch {
                print("Ошибка сохранения backGroundConext: \(error)")
            }
        }
    }
    
    func deleteLink(link: Link) throws {
        viewContext.delete(link)
        
        if viewContext.hasChanges {
            try viewContext.save()
            print("Удаление прошло успешно")
        }
    }
    
    func deletePeopleJoinde(peopleJoinde: JoinedPeoples) throws {
        viewContext.delete(peopleJoinde)
        
        if viewContext.hasChanges {
            try viewContext.save()
            print("Удаление прошло успешно")
        }
    }
    
    func createPreparedFetchedResultController() -> NSFetchedResultsController<Link> {
        let userFetchRequest = Link.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "linkTitile", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]
        
        let resultController = NSFetchedResultsController(
            fetchRequest: userFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        return resultController
    }
    
    func createPreparedFetchedResultController(link: Link) -> NSFetchedResultsController<JoinedPeoples> {
        let userFetchRequest = JoinedPeoples.fetchRequest()
        userFetchRequest.predicate = NSPredicate(format: "link == %@", link)
        let sortDescriptor = NSSortDescriptor(key: "dateJoined", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]
        
        let resultController = NSFetchedResultsController(
            fetchRequest: userFetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        return resultController
    }
    
    private func obtaineSavedLink() -> [Link] {
        let linkFetchRequest = Link.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "linkTitile", ascending: false)
        linkFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? self.viewContext.fetch(linkFetchRequest)
        return result ?? []
    }
    
    private func obtaineSavedPeoples() -> [JoinedPeoples] {
        let linkFetchRequest = JoinedPeoples.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "name", ascending: false)
        linkFetchRequest.sortDescriptors = [sortDescriptors]
        let result = try? self.viewContext.fetch(linkFetchRequest)
        return result ?? []
    }
    
    func updateLinkInfo(linkId: UUID, newTitle: String, newDescription: String) async throws {
        
        let context = backgroundContext
        
        return await backgroundContext.perform { [unowned viewContext] in
            guard let link = self.obtaineSavedLink().first(where: { $0.linkId == linkId}) else {
                print("Не удалось найти link")
                return
            }
            
            link.linkTitile = newTitle
            link.countJoined = newDescription.setupCountString()
            
            do {
                try context.save()
                
                return viewContext.performAndWait {
                    do {
                        try viewContext.save()
                    } catch {
                        print("Ошибка сохранения viewConext: \(error)")
                    }
                }
            } catch {
                print("Ошибка сохранения backGroundConext: \(error)")
            }
        }
    }
    
    func updateJoindePeopleInfo(peopleId: UUID, newName: String, newDate: String, accentColorID: String, photoPath: String, emojiPath: String) async throws {
        let context = backgroundContext
        
        return await backgroundContext.perform { [unowned viewContext] in
            guard let people = self.obtaineSavedPeoples().first(where: { $0.peopleId == peopleId}) else {
                print("Не удалось найти link")
                return
            }
            
            people.name = newName
            people.dateJoined = newDate
            people.accentColorID = Int16(accentColorID) ?? 0
            people.emojiPath = emojiPath
            people.photoPath = photoPath
            
            do {
                try context.save()
                
                return viewContext.performAndWait {
                    do {
                        try viewContext.save()
                    } catch {
                        print("Ошибка сохранения viewConext: \(error)")
                    }
                }
            } catch {
                print("Ошибка сохранения backGroundConext: \(error)")
            }
        }
    }
}
