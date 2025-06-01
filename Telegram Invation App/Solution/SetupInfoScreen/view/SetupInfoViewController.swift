
import UIKit

protocol SetupInfoViewControllerDelete: AnyObject {
    func updateLinkAndPhotoJoined(link: String, peopleCount: String, peoplesName: [String])
}

protocol ReloadViewControllerDelegate: AnyObject {
    func reload()
}

class SetupInfoViewController: UIViewController, SetupInfoViewModelOutput {

    var viewModel: SetupInfoViewModelInput?
    let contentView = SetupInfoView()
    var delegate: SetupInfoViewControllerDelete?
    var delegateReload: ReloadViewControllerDelegate?
    
    private var link: Link?
    private var joinedPeople: JoinedPeoples?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(typeSetup: TypeSetupInfoScreen, delegate: SetupInfoViewControllerDelete) {
        super.init(nibName: nil, bundle: nil)
        contentView.typeSetup = typeSetup
        self.delegate = delegate
        setStartInformation(typeSetup: typeSetup)
    }

    init(link: Link, typeSetup: TypeSetupInfoScreen, delegate: ReloadViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        contentView.typeSetup = typeSetup
        self.link = link
        setStartInformation(typeSetup: typeSetup)
        print(delegate)
        delegateReload = delegate
    }
    
    init(link: Link, typeSetup: TypeSetupInfoScreen) {
        super.init(nibName: nil, bundle: nil)
        contentView.typeSetup = typeSetup
        self.link = link
        setStartInformation(typeSetup: typeSetup)
    }
    
    init(joinedPeople: JoinedPeoples, typeSetup: TypeSetupInfoScreen) {
        super.init(nibName: nil, bundle: nil)
        contentView.typeSetup = typeSetup
        self.joinedPeople = joinedPeople
        setStartInformation(typeSetup: typeSetup)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        contentView.viewController = self
        view = contentView
    }
    
    func updatePeopleJoined(newName: String, newDate: String, accentColorID: String, photoPath: String, emojiPath: String) {
        guard let peopleId = joinedPeople?.peopleId else {
            print("joinedPeople не существует")
            return
        }
        viewModel?.updatePeopleInfo(peopleID: peopleId, newName: newName, newDate: newDate, accentColorID: accentColorID, photoPath: photoPath, emojiPath: emojiPath)
        self.dismiss(animated: true)
    }
    
    func updateLinkInfo(newTitle: String, newDescription: String) {
        guard let linkId = link?.linkId else {
            print("link не существует")
            return
        }
        viewModel?.updateLinkInfo(linkId: linkId, newTitle: newTitle, newDescription: newDescription)
        self.dismiss(animated: true)
    }
    
    func updateLinkAndPhotoJoined(link: String, countPeople: String, peoplesName: String) {
        let peoples = peoplesName.split(separator: ", ")
        let strings: [String] = peoples.map { String($0) }
        
        delegate?.updateLinkAndPhotoJoined(link: link, peopleCount: countPeople, peoplesName: strings)
        self.dismiss(animated: true)
        
    }
    
    func createNewPeoples(peoplesName: String, datesList: String) {
        guard let myLink = link else {
            print("link не существует")
            return
        }
        
        let parser = DateFormatter()
        parser.dateFormat = "d.MM.yyyy HH:mm:ss"
        parser.locale = Locale(identifier: "en_US_POSIX")   // гарантировано правильный разбор фиксированных форматов :contentReference[oaicite:0]{index=0}

        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy 'в' HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")     // русские названия месяцев :contentReference[oaicite:1]{index=1}

        
        let peoples = peoplesName.split(separator: ", ")
        let peoplesMaping: [String] = peoples.map { String($0) }
        
        let dates = datesList.split(separator: ", ")
        let datesMaping: [String] = dates.map { String($0) }
        let myDates: [String] = datesMaping.map { dateString in
            // либо парсим в Date, либо берём «нулевую» дату, чтобы не падать
            let date = parser.date(from: dateString) ?? Date(timeIntervalSince1970: 0)
            return formatter.string(from: date)
        }
        
        self.viewModel?.createAndSavePeoplesJoined(link: myLink, dates: myDates, peoplesJoined: peoplesMaping)
        delegateReload?.reload()
        self.dismiss(animated: true)
    }
    
    func setStartInformation(typeSetup: TypeSetupInfoScreen) {
        contentView.setupLayout()
        switch typeSetup {
        case .setupLink:
            contentView.setupOneTextField(text: "Введите название ссылки")
            contentView.setupTwoTextField(text: "Введите число присоеденившихся")
            
        case .setupLinkViewAndNumberOfJoined:
            contentView.setupOneTextField(text: "Введите название ссылки")
            contentView.setupTwoTextField(text: "Введите кол-во присоеденившихся")
            contentView.setupThreeTextField(text: "Список людей. Формат: ', ' ")
            
            
        case .setupJoindePeople:
            contentView.setupOneTextField(text: "Введите имя человека")
            contentView.setupTwoTextField(text: "Введите даты присоединения")
            contentView.setupThreeTextField(text: "Введите accentColorId")
            contentView.setupTherdTextField(text: "Введите photoPath")
            contentView.setupFithTextField(text: "Введите emojiPath")
        
        case .setupLinkView:
            contentView.setupOneTextField(text: "Введите название ссылки")
            
        case .addNewPeople:
            contentView.setupOneTextField(text: "Введите nickName людей черзе ,")
            contentView.setupTwoTextField(text: "Введите даты черзе ,")
        default:
            print("ХЗ")
        }
    }
}
