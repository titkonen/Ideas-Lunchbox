import UIKit

protocol NoteDelegate {
    func saveNewNote(title: String, date: Date, text: String)
}

class NoteDetailController: UIViewController {
    
    // MARK: PROPERTIES
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY hh:mm"
        return dateFormatter
    }()
    
    var noteData: Note! {
        didSet {
            textView.text = noteData.title
            textView2.text = noteData.text ///Preview
            dateLabel.text = dateFormatter.string(from: noteData.date ?? Date())
        }
    }
    
    var delegate: NoteDelegate?
    
    fileprivate var textView: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Add your title in here"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    fileprivate var textView2: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Add your additional text here"
        textField.isEditable = true
        textField.textColor = .black
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.isSelectable = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.text = dateFormatter.string(from: Date())
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        
//        func textViewDidBeginEditing(_ textView: UITextView) {
//            if textView.textColor == UIColor.lightGray {
//                textView.text = nil
//                textView.textColor = UIColor.black
//            }
//        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.noteData == nil {
            delegate?.saveNewNote(title: textView.text, date: Date(), text: textView2.text)
        } else {
            /// updates title text
            guard let newText = self.textView.text else {
                return
            }
            /// Updates Description text
            guard let newPreview = self.textView2.text else {
                return
            }
            CoreDataManager.shared.saveUpdatedNote(note: self.noteData, newText: newText, newPreview: newPreview)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let items: [UIBarButtonItem] = [
////            UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
////            UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
//        ]
//
//        self.toolbarItems = items
//
//        let topItems: [UIBarButtonItem] = [
//            UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
//            UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
//        ]
//
//        self.navigationItem.setRightBarButtonItems(topItems, animated: false)
    }
    
    // MARK: FUNCTIONS
    fileprivate func setupUI() {
        view.addSubview(dateLabel)
        view.addSubview(textView)
        view.addSubview(textView2)
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -640).isActive = true
        
        textView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 280).isActive = true
        textView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140).isActive = true
                
        
    }
    
    /// Text field testing

    
}
