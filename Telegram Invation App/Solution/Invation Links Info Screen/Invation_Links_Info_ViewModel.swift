import UIKit
import CoreData

/// Протокол через который мы получаем доступ в внутрь GroupInvationViewModel
protocol InvationLinksInfoViewModelInput: AnyObject {
    func getPreparedFetchedResultControllerForJoindePeople(link: Link) -> NSFetchedResultsController<JoinedPeoples>
    func addNewEmptyPeopleInLink(link: Link) async
    func deletPeopleJoined(peopleJoinde: JoinedPeoples)
}
/// Протокол позволяет получить доступ к view, но только к указаным функциям
protocol InvationLinksInfoViewModelOutput: AnyObject {
    
}

class InvationLinksInfoViewModel: InvationLinksInfoViewModelInput {
    
    private var coreDataManger = CoreDataManager.shared
    weak var view: InvationLinksInfoViewModelOutput?
    
    func deletPeopleJoined(peopleJoinde: JoinedPeoples) {
        try? coreDataManger.deletePeopleJoinde(peopleJoinde: peopleJoinde)
    }
    
    func getPreparedFetchedResultControllerForJoindePeople(link: Link) -> NSFetchedResultsController<JoinedPeoples> {
        return coreDataManger.createPreparedFetchedResultController(link: link)
    }
    
    func addNewEmptyPeopleInLink(link: Link) async {
        await coreDataManger.createNewEmptyPeopleInLinks(link: link)
    }
}
