import UIKit
import TDLibKit
import CoreData

/// Протокол через который мы получаем доступ в внутрь GroupInvationViewModel
protocol GroupInvationViewModelInput: AnyObject {
    func getPreparedFetchedResultController() -> NSFetchedResultsController<Link>
    func createNewInvationLink() async
    func deleteLink(link: Link)
    func getUserPhotoByNickName(nickName: String, compleation: @escaping (Result<AvatarInfo, Swift.Error>) -> Void)
}
/// Протокол позволяет получить доступ к view, но только к указаным функциям
protocol GroupInvationViewModelOutput: AnyObject { }

class GroupInvationViewModel: GroupInvationViewModelInput {
    
    weak var view: GroupInvationViewModelOutput?
    private let coreDataManager = CoreDataManager.shared
    private let tDLibController = TelegramTDLibController.shared
    
    func getPreparedFetchedResultController() -> NSFetchedResultsController<Link> {
        return coreDataManager.createPreparedFetchedResultController()
    }
    
    func createNewInvationLink() async {
        await coreDataManager.createNewEmptyLinks()
    }
    
    func deleteLink(link: Link) {
        do {
            try coreDataManager.deleteLink(link: link)
        } catch {
            print("Произошла ошибка при удалении: \(error)")
        }
    }
    
    func getUserPhotoByNickName(nickName: String, compleation: @escaping (Result<AvatarInfo, Swift.Error>) -> Void) {
        tDLibController.getUserFullInfo(nickname: nickName) { result in
            switch result {
            case .success(let success):
                if success.photo != nil {
                    self.tDLibController.downloadImage(chatPhotoInfo: success.photo) { result in
                        switch result {
                        case .success(let success):
                            let avatarInfo = AvatarInfo(photoPath: success.local.path,
                                                        accentColor: nil,
                                                        title: nil)
                            
                            compleation(.success(avatarInfo))
                        case .failure(let failure):
                            print("Ошибка загрузки фото: \(failure)")
                            compleation(.failure(failure))
                        }
                    }
                } else {
                    let avatarInfo = AvatarInfo(photoPath: nil,
                                                accentColor: success.accentColorId,
                                                title: success.title)
                    compleation(.success(avatarInfo))
                }
            case .failure(let failure):
                compleation(.failure(failure))
                print("Ошибка получения пользователя: \(failure)")
            }
        }
    }
}
