import UIKit
import CoreData

class InvationLinksInfoViewController: UIViewController, InvationLinksInfoViewModelOutput {

    var viewModel: InvationLinksInfoViewModelInput?
    let contentView = InvationLinksInfoView()
    var link: Link?
    var tableViewHeader: invationLinksTableHeader?
    var fetchedResultController: NSFetchedResultsController<JoinedPeoples>?
    
    init(link: Link) {
        super.init(nibName: nil, bundle: nil)
        self.link = link
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
        tableViewHeader = invationLinksTableHeader(frame: CGRect(x: 0,
            y: 0, width: Int(self.contentView.frame.width), height: 238))
        tableViewHeader?.titleLabel.text = link?.linkTitile ?? ""
        tableViewHeader?.delegateHeader = self
        
        contentView.invationLinksInfoTableView.tableHeaderView = tableViewHeader
        contentView.invationLinksInfoTableView.delegate = self
        contentView.invationLinksInfoTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSafeAreaInsets = .zero
        
        guard let chekedLink = link else {
            print("Не установлен link")
            return
        }
        
        fetchedResultController = viewModel?.getPreparedFetchedResultControllerForJoindePeople(link: chekedLink)
        fetchedResultController?.delegate = self
        updateTableWithCachedData()
    }
    
    func updateInfo() -> String {
        return link?.linkTitile ?? ""
    }
    
    func updateTableWithCachedData() {
        do {
            try fetchedResultController?.performFetch()
            contentView.invationLinksInfoTableView.reloadData()
        } catch {
            print("Запрос к Fetch провален. Ошибка: \(error)")
        }
    }
}

extension InvationLinksInfoViewController: InvationLinkHeaderDelegate, SetupInfoViewControllerDelete, ReloadViewControllerDelegate {
    func reload() {
        updateTableWithCachedData()
        contentView.invationLinksInfoTableView.reloadData()
    }
    
    func addNewPeople() {
        guard let chekedLink = link else {
            print("Не установлен link")
            return
        }
        
        let newViewController = SetupInfoAssembly.screenBuilderForAdd(link: chekedLink, typeSetup: .addNewPeople, delegate: self)
        
        if let presentationController = newViewController.presentationController
            as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.present(newViewController, animated: true)
    }
    
    func updateLinkAndPhotoJoined(link: String, peopleCount: String = "", peoplesName: [String] = []) {
        let attributedText = NSAttributedString(
            string: link,
            attributes: [
                .kern: -0.3, // уменьшает расстояние между символами
                .font: UIFont.systemFont(ofSize: 19),
                .foregroundColor: UIColor.white
            ]
        )
        tableViewHeader?.invationLinkLabel.attributedText = attributedText
        tableViewHeader?.reloadInputViews()
    }
    
    func opeSetingView(type: TypeSetupInfoScreen) {
        let newViewController = SetupInfoAssembly.screenBuilderForLink(typeSetup: type, delegate: self)
        
        if let presentationController = newViewController.presentationController
            as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        self.present(newViewController, animated: true)
    }
    
    func closeScreen() {
        dismiss(animated: true)
    }
}

extension InvationLinksInfoViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print(indexPath?.row)
        guard let chekerIndexPath = indexPath else {
            print("\(indexPath) не обнаружен")
            return
        }
        
        let myIndexPath = IndexPath(row: chekerIndexPath.row, section: 1)
        switch type {
        case .update:
            if let cell = contentView.invationLinksInfoTableView.cellForRow(at: myIndexPath) as? PeopleJoinedByLinksTableViewCell {
                let object: JoinedPeoples = controller.object(at: indexPath!) as! JoinedPeoples
                cell.configure(peopleJoind: object)
            }
            contentView.invationLinksInfoTableView.reloadRows(at: [myIndexPath], with: .automatic)
            contentView.invationLinksInfoTableView.reloadData()
        case .insert:
            contentView.invationLinksInfoTableView.insertRows(at: [myIndexPath], with: .automatic)
            contentView.invationLinksInfoTableView.reloadData()
        case .delete:
            contentView.invationLinksInfoTableView.deleteRows(at: [myIndexPath], with: .automatic)
            contentView.invationLinksInfoTableView.reloadData()
        case .move:
            contentView.invationLinksInfoTableView.reloadData()
        @unknown default:
            print("Произошла неизвестная ошибка")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        contentView.invationLinksInfoTableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        contentView.invationLinksInfoTableView.beginUpdates()
    }
}

extension InvationLinksInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 13
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        // Сбрасываем системный tint (размытый фон)…
        header.tintColor = .clear         // или .clear
        // …и при необходимости настраиваем contentView
        header.contentView.backgroundColor = .clear
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fetchSection = fetchedResultController?.sections?.first else {
            print("ошибка")
            return 0
        }
        
        if section == 0 {
            return 1
        } else {
            return fetchSection.numberOfObjects
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let joinedMainCell = tableView.dequeueReusableCell(
                withIdentifier: "joinedCell", for: indexPath) as? PeopleJoinedByLinksTableViewCell else { fatalError()
            }
            joinedMainCell.configureMainCell(name: "T3mag", date: "Дата", accentColorId: 5, photoPath: "", emojiPath: "")
            return joinedMainCell
        } else {
            guard let joinedCell = tableView.dequeueReusableCell(
                withIdentifier: "joinedCell", for: indexPath) as? PeopleJoinedByLinksTableViewCell else { fatalError()
            }
            let myIndexPath = IndexPath(row: indexPath.row, section: 0)
            guard let peopleJoined = fetchedResultController?.object(at: myIndexPath) else {
                fatalError()
            }
            joinedCell.configure(peopleJoind: peopleJoined)
            return joinedCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cellHeader = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "cellHeader") as? CellHeaderView else {
            fatalError()
        }
        
        if section == 0 {
            cellHeader.configure(with: "CСЫЛКА СОЗДАНА")
            return cellHeader
        } else {
            guard let fetchSection = fetchedResultController?.sections?.first else {
                print("ошибка")
                fatalError()
            }
            
            cellHeader.configure(with: "\(fetchSection.numberOfObjects) ПРИСОЕДИНИЛИСЬ")
            return cellHeader
        }
    }
    
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil) { suggestedActions in
            let myIndexPath = IndexPath(row: indexPath.row, section: 0)
            if indexPath.section != 0 {
                /// Возможность редактировать
                let edit = UIAction(title: "Редактировать",
                                    image: UIImage(systemName: "pencil")) { action in
                    
                    guard let selectedCell = self.fetchedResultController?.object(at: myIndexPath) else {
                        print("объект не был найден")
                        return
                    }
                    
                    let newViewController = SetupInfoAssembly.screenBuilderForPropleJoined(peopleJoined: selectedCell)
                    
                    if let presentationController = newViewController.presentationController
                        as? UISheetPresentationController {
                        presentationController.detents = [.medium()]
                    }
                    
                    self.present(newViewController, animated: true)
                }
                
                // Возможность удалять
                let delete = UIAction(title: "Удалить",
                                      image: UIImage(systemName: "trash"),
                                      attributes: .destructive) { action in
                    guard let selectedPeopleJoined = self.fetchedResultController?.object(at: myIndexPath) else {
                        print("объект не был найден")
                        return
                    }
                    self.viewModel?.deletPeopleJoined(peopleJoinde: selectedPeopleJoined)
                }
                
                // Собираем UIMenu
                return UIMenu(title: "", children: [edit, delete])
            }
            
            return UIMenu()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        if indexPath.section == 0 {
            Task {
                guard let link = self.link else {
                    print("LinkId не существет")
                    return
                }
                await viewModel?.addNewEmptyPeopleInLink(link: link)
                self.updateTableWithCachedData()
            }
        }
    }
}
