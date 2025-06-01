
import UIKit

/// Протокол через который мы получаем доступ в внутрь GroupInvationViewModel
protocol SetupInfoViewModelInput: AnyObject {
    func updateLinkInfo(linkId: UUID, newTitle: String, newDescription: String)
    func updatePeopleInfo(peopleID: UUID, newName: String, newDate: String, accentColorID: String, photoPath: String, emojiPath: String)
    func createAndSavePeoplesJoined(link: Link, dates: [String], peoplesJoined: [String])
}
/// Протокол позволяет получить доступ к view, но только к указаным функциям
protocol SetupInfoViewModelOutput: AnyObject {
    
}

class SetupInfoViewModel: SetupInfoViewModelInput {
    
    weak var view: SetupInfoViewModelOutput?
    private let coreDataManager = CoreDataManager.shared
    private let tDLibController = TelegramTDLibController.shared
    
    func updateLinkInfo(linkId: UUID, newTitle: String, newDescription: String) {
        Task {
            try await coreDataManager.updateLinkInfo(linkId: linkId, newTitle: newTitle, newDescription: newDescription)
        }
    }
    
    func updatePeopleInfo(peopleID: UUID, newName: String, newDate: String, accentColorID: String, photoPath: String, emojiPath: String) {
        Task {
            try await coreDataManager.updateJoindePeopleInfo(peopleId: peopleID, newName: newName, newDate: newDate, accentColorID: accentColorID, photoPath: photoPath, emojiPath: emojiPath)
        }
    }
    
    func createAndSavePeoplesJoined(link: Link, dates: [String], peoplesJoined: [String]) {
        for counter in 0...peoplesJoined.count - 1 {
            let peoplesJoin = peoplesJoined[counter]
            
            let date: String
            
            if peoplesJoined.count == dates.count {
                date = dates[counter]
            } else {
                date = dates.first ?? ""
            }
            
            tDLibController.getUserFullInfo(nickname: peoplesJoin) { result in
                switch result {
                case .success(let user):
                    if user.photo != nil {
                        self.tDLibController.downloadImage(chatPhotoInfo: user.photo) { result in
                            switch result {
                            case .success(let photoPath):
                                switch user.emojiStatus?.type {
                                case .emojiStatusTypeCustomEmoji(let custom):
                                    let customEmojiId = custom.customEmojiId
                                    self.tDLibController.getEmojiStatusById(emojiStatusId: customEmojiId) {result in
                                        switch result {
                                        case .success(let success):
                                            Task {
                                                await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                            name: user.title, date: date,
                                                            accentColorID: Int16(user.accentColorId),
                                                            emojiPath: success, photoPath: photoPath.local.path)
                                            }
                                        case .failure(_):
                                            Task {
                                                await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                            name: user.title, date: date,
                                                            accentColorID: Int16(user.accentColorId),
                                                            emojiPath: "", photoPath: photoPath.local.path)
                                            }
                                        }
                                    }
                                case .emojiStatusTypeUpgradedGift(_):
                                    Task {
                                        await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                    name: user.title, date: date,
                                                    accentColorID: Int16(user.accentColorId),
                                                    emojiPath: "", photoPath: photoPath.local.path)
                                    }
                                case .none:
                                    Task {
                                        await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                    name: user.title, date: date,
                                                    accentColorID: Int16(user.accentColorId),
                                                    emojiPath: "", photoPath: photoPath.local.path)
                                    }
                                }
                            case .failure(_):
                                switch user.emojiStatus?.type {
                                case .emojiStatusTypeCustomEmoji(let custom):
                                    let customEmojiId = custom.customEmojiId
                                    self.tDLibController.getEmojiStatusById(emojiStatusId: customEmojiId) {result in
                                        switch result {
                                        case .success(let success):
                                            Task {
                                                await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                            name: user.title, date: date,
                                                            accentColorID: Int16(user.accentColorId),
                                                            emojiPath: success, photoPath: "")
                                            }
                                        case .failure(_):
                                            Task {
                                                await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                            name: user.title, date: date,
                                                            accentColorID: Int16(user.accentColorId),
                                                            emojiPath: "", photoPath: "")
                                            }
                                        }
                                    }
                                case .emojiStatusTypeUpgradedGift(let upgrade):
                                    let upgradeEmojiId = upgrade.modelCustomEmojiId
                                    Task {
                                        await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                    name: user.title, date: date,
                                                    accentColorID: Int16(user.accentColorId),
                                                    emojiPath: "", photoPath: "")
                                    }
                                case .none:
                                    Task {
                                        await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                    name: user.title, date: date,
                                                    accentColorID: Int16(user.accentColorId),
                                                    emojiPath: "", photoPath: "")
                                    }
                                }
                            }
                        }
                    } else {
                        switch user.emojiStatus?.type {
                        case .emojiStatusTypeCustomEmoji(let custom):
                            let customEmojiId = custom.customEmojiId
                            self.tDLibController.getEmojiStatusById(emojiStatusId: customEmojiId) {result in
                                switch result {
                                case .success(let success):
                                    Task {
                                        await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                    name: user.title, date: date,
                                                    accentColorID: Int16(user.accentColorId),
                                                    emojiPath: success, photoPath: "")
                                    }
                                case .failure(let failure):
                                    Task {
                                        await self.coreDataManager.addNewPeopleInLinks(link: link,
                                                    name: user.title, date: date,
                                                    accentColorID: Int16(user.accentColorId),
                                                    emojiPath: "", photoPath: "")
                                    }
                                }
                            }
                        case .emojiStatusTypeUpgradedGift(let upgrade):
                            let upgradeEmojiId = upgrade.modelCustomEmojiId
                            Task {
                                await self.coreDataManager.addNewPeopleInLinks(link: link,
                                            name: user.title, date: date,
                                            accentColorID: Int16(user.accentColorId),
                                            emojiPath: "", photoPath: "")
                            }
                        case .none:
                            Task {
                                await self.coreDataManager.addNewPeopleInLinks(link: link,
                                            name: user.title, date: date,
                                            accentColorID: Int16(user.accentColorId),
                                            emojiPath: "", photoPath: "")
                            }
                        }
                    }
                case .failure(let error):
                    print("----------------------------------------------------------------------")
                    print(error)
                }
            }
        }
    }
}

