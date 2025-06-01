
import TDLibKit
import Foundation
import UIKit
import Combine


class TelegramTDLibController {
    
    static let shared = TelegramTDLibController()
    
    // НЕ БЕЗОПАСНО (зато быстро)
    // Данный вариант является временным и будет заменен на keyChain
    private let api_id = 0
    private let api_hash = ""
    private let encryptionKeyData = Data()
    
    let manager = TDLibClientManager(logger: StdOutLogger())
    private var client: TDLibClient?
    private let encryptionKey = Data()
    
    @Published var authorizationState: AuthorizationState?
    
    init () {
        client = getTdlibNewClient()
    }
    
    func getAuthorizationState() -> AuthorizationState? {
        var authorizationState: AuthorizationState?
        
        try? client?.getAuthorizationState { result in
            switch result {
            case .success(let state):
                authorizationState = state
            case .failure(let error):
                print(error)
                authorizationState = nil
            }
        }
        return authorizationState
    }
    
    func closeClient() {
        do {
            try client?.close { result in
                switch result {
                case .success(_):
                    print("Все данные записаны")
                case .failure(let error):
                    print("Error - \(error)")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getTdlibNewClient() -> TDLibClient {
        let newClient = manager.createClient(updateHandler: {
            do {
                let update = try $1.decoder.decode(Update.self, from: $0)
                switch update {
                case .updateAuthorizationState(let auth):
                    switch auth.authorizationState {
                    case .authorizationStateWaitTdlibParameters:
                        self.asyncSetupTDLibParametrs()
                        self.authorizationState = .authorizationStateWaitTdlibParameters
                    case .authorizationStateWaitPhoneNumber:
                        self.authorizationState = .authorizationStateWaitPhoneNumber
                    case .authorizationStateWaitCode(let code):
                        self.authorizationState = .authorizationStateWaitCode(code)
                    case .authorizationStateWaitPassword(let password):
                        self.authorizationState = .authorizationStateWaitPassword(password)
                    case .authorizationStateWaitEmailAddress(_):
                        print("Жду мыло")
                    case .authorizationStateWaitEmailCode(_):
                        print("Жду код с мыла")
                    case .authorizationStateReady:
                        self.authorizationState = .authorizationStateReady
                    default:
                        print("\(update)")
                    }
                default:
                    print(update)
                }
            } catch {
                print("Error in update handler \(error.localizedDescription)")
            }
        })
        return newClient
    }
    
    func asyncSetupTDLibParametrs() {
        let docsURL = FileManager
                    .default
                    .urls(for: .documentDirectory, in: .userDomainMask)
                    .first!

        let dbURL = docsURL.appendingPathComponent("tdlib-db")
        let filesURL = docsURL.appendingPathComponent("tdlib-files")
        
        Task {
            do {
                try await client?.setTdlibParameters(apiHash: api_hash, apiId: api_id,
                                                     applicationVersion: "5.0",
                                                     databaseDirectory: dbURL.path,
                                                     databaseEncryptionKey: encryptionKeyData,
                                                     deviceModel: UIDevice.current.model,
                                                     filesDirectory: filesURL.path,
                                                     systemLanguageCode: "ru",
                                                     systemVersion: UIDevice.current.systemVersion,
                                                     useChatInfoDatabase: true,
                                                     useFileDatabase: true,
                                                     useMessageDatabase: true, useSecretChats: true, useTestDc: false)
            } catch {
                print(error)
            }
        }
    }
    
    func asyncSetAuthenticationNumber(number: String) {
        Task {
            do {
                try await client?.setAuthenticationPhoneNumber(phoneNumber: number, settings: nil)
            } catch {
                print(error)
            }
        }
    }
    
    func asyncSetAuthenticationCode(code: String) {
        Task {
            do {
                try await client?.checkAuthenticationCode(code: code)
            } catch {
                print(error)
            }
        }
    }
    
    func asyncSetAuthenticationPassword(password: String) {
        Task {
            do {
                try await client?.checkAuthenticationPassword(password: password)
            } catch {
                print(error)
            }
        }
    }
    
    func getEmojiStatusById(emojiStatusId: TdInt64, completion: @escaping(Result<String,Swift.Error>)->Void) {
        Task {
            do {
                
                guard let sticker = try await client?.getCustomEmojiStickers(customEmojiIds: [emojiStatusId]) else {
                    let error = NSError(
                        domain: "searchPublicChat",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Не удалось получить чат или юзера"]
                    )
                    print(error)
                    completion(.failure(error))
                    return
                }
                
                guard let downloadedFile = try await client?.downloadFile(
                    fileId: sticker.stickers.first?.sticker.id,
                    limit: 1,
                    offset: 0,
                    priority: 32,
                    synchronous: true) else {
                    let error = NSError(
                        domain: "downloadedFile",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Не удалось загрузить фото"]
                    )
                    completion(.failure(error))
                    return
                }
                completion(.success(downloadedFile.local.path))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getUserFullInfo(nickname: String , compleation: @escaping (Result<Chat, Swift.Error>) -> Void) {
        Task {
            do {
                guard let chatInfo = try await client?.searchPublicChat(username: nickname) else {
                    let error = NSError(
                        domain: "searchPublicChat",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Не удалось получить чат или юзера"]
                    )
                    compleation(.failure(error))
                    return
                }
                
                guard let fullChatInfo = try await client?.getChat(chatId: chatInfo.id) else {
                    let error = NSError(
                        domain: "getChat",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Не удалось получить всю информацию"]
                    )
                    compleation(.failure(error))
                    return
                }
                
                compleation(.success(fullChatInfo))
            } catch {
                compleation(.failure(error))
            }
        }
    }
    
    func downloadImage(chatPhotoInfo: ChatPhotoInfo?, completion: @escaping (Result<File, Swift.Error>) -> Void) {
        Task {
            do {
                guard let photo = chatPhotoInfo else {
                    let error = NSError(
                        domain: "photoCheckNil",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Фото нету"]
                    )
                    completion(.failure(error))
                    return
                }
                
                guard let downloadedFile = try await client?.downloadFile(
                    fileId: photo.small.id,
                    limit: 1,
                    offset: 0,
                    priority: 32,
                    synchronous: true) else {
                    let error = NSError(
                        domain: "downloadedFile",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Не удалось загрузить фото"]
                    )
                    completion(.failure(error))
                    return
                }
                completion(.success(downloadedFile))
                
            } catch {
                completion(.failure(error))
            }
        }
    }
}

