import UIKit

import Tagging

class TaggingViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Const {
        static let tagableTableViewCell = "TagableTableViewCell"
        static let taggedTableViewCell = "TaggedTableViewCell"
    }
    
    // MARK: - Properties
    
    private var matchedList: [String] = [] {
        didSet {
            tagableTableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
    private var taggedList: [TaggingModel] = [] {
        didSet {
            taggedTableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
    
    // MARK: - UI Components
    
    @IBOutlet weak var tagging: Tagging! {
        didSet {
            tagging.accessibilityIdentifier = "Tagging"
            tagging.textView.accessibilityIdentifier = "TaggingTextView"
            tagging.borderColor = UIColor.darkGray.cgColor
            tagging.borderWidth = 1.0
            tagging.cornerRadius = 20
            tagging.textInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            tagging.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            tagging.defaultAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            tagging.symbolAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            tagging.taggedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.underlineStyle: NSNumber(value: 1)]
            tagging.dataSource = self
            
            tagging.symbol = "#"
            tagging.tagableList = ["DOOMFIST", "GENJI", "MCCREE", "PHARAH", "REAPER", "SOLDIER:76", "SOMBRA", "TRACER", "BASTION", "HANZO", "JUNKRAT", "MEI", "TORBJORN", "WIDOWMAKER", "D.VA", "ORISA", "REINHARDT", "ROADHOG", "WINSTON", "ZARYA", "ANA", "BRIGITTE", "LUCIO", "MERCY", "MOIRA", "SYMMETRA", "ZENYATTA"]
        }
    }
    @IBOutlet weak var tagableTableView: UITableView! {
        didSet {
            tagableTableView.accessibilityIdentifier = "TagableTableView"
            tagableTableView.dataSource = self
            tagableTableView.delegate = self
            tagableTableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.tagableTableViewCell)
        }
    }
    @IBOutlet weak var taggedTableView: UITableView! {
        didSet {
            taggedTableView.accessibilityIdentifier = "TaggedTableView"
            taggedTableView.allowsSelection = false
            taggedTableView.dataSource = self
            taggedTableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.taggedTableViewCell)
        }
    }
    
    // MARK: - Overridden: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tagging"
    }
    
}

// MARK: - TaggingDataSource

extension TaggingViewController: TaggingDataSource {
    
    func tagging(_ tagging: Tagging, didChangedTagableList tagableList: [String]) {
        matchedList = tagableList
    }
    
    func tagging(_ tagging: Tagging, didChangedTaggedList taggedList: [TaggingModel]) {
        self.taggedList = taggedList
    }
    
}

// MARK: - UITableViewDataSource

extension TaggingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableView == tagableTableView else {
            return tagging.taggedList.count
        }
        
        return matchedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard tableView == tagableTableView else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Const.taggedTableViewCell, for: indexPath)
            let model = taggedList[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.text = "\(model.text) - \(model.range)"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.tagableTableViewCell, for: indexPath)
        cell.textLabel?.text = matchedList[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension TaggingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView == tagableTableView else {return}
        
        tagging.updateTaggedList(allText: tagging.textView.text, tagText: matchedList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

