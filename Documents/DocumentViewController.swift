

import UIKit

class DocumentCreatorViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var body: UITextView!
    
    var currentDoc: Document?
    
    let documentsLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveDocument))
        
        name.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        
        if let currentDoc = currentDoc {
            name.text = currentDoc.title
            body.text = currentDoc.body
        } else {
            name.text = ""
            body.text = ""
        }
    }
    
    @objc
    func saveDocument() {
        if name.text == "" {
            print("Name field must be populated")
            return
        }
        
        if body.text == "" {
            print("Body of document must be populated")
            return
        }
        if let name = name.text, let body = body.text {
            let document = Document(title: name, body: body, dateModified: Date(), size: 60)

            let writeLocation = documentsLocation.appendingPathComponent("\(document.title).json")
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let JSON = try encoder.encode(document)
                try JSON.write(to: writeLocation)
            } catch let err {
                print("Error Saving \(document.title)", err)
            }
            
            print("Saved Successfully")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    func textFieldDidChange() {
        self.navigationItem.title = name.text
    }
}


