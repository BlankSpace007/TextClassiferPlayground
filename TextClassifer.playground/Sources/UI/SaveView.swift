import AppKit

class SaveView: NSView {
    
    private var filePath:String! = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true).last
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    convenience init() {
        self.init(frame: NSRect.zero)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1).cgColor
        self.layer?.borderColor = NSColor.lightGray.cgColor
        self.layer?.borderWidth = 1
        self.layer?.cornerRadius = 5
        self.layer?.masksToBounds = true
        
        self.addSubview(self.authLabel)
        self.addSubview(self.authDeatilLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.descriptionDeatilLabel)
        self.addSubview(self.versionLabel)
        self.addSubview(self.versionDetailLabel)
        self.addSubview(self.whereLabel)
        self.addSubview(self.button)

        
        self.authLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        self.authDeatilLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.authLabel.snp.centerY)
            make.left.equalTo(self.authLabel.snp.right)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.authLabel.snp.bottom).offset(10)
            make.left.equalTo(self.authLabel.snp.left)
            make.right.equalTo(self.authLabel.snp.right)
        }
        
        self.descriptionDeatilLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.descriptionLabel.snp.centerY)
            make.left.equalTo(self.descriptionLabel.snp.right)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        self.versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(self.descriptionLabel.snp.left)
            make.right.equalTo(self.descriptionLabel.snp.right)
        }
        
        self.versionDetailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.versionLabel.snp.centerY)
            make.left.equalTo(self.versionLabel.snp.right)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        self.whereLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.versionLabel.snp.bottom).offset(10)
            make.left.equalTo(self.versionLabel.snp.left)
            make.right.equalTo(self.versionLabel.snp.right)
        }
        
        self.button.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.whereLabel.snp.centerY)
            make.left.equalTo(self.whereLabel.snp.right)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
    }
    
    private var authLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = false
        label.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        label.isBordered = false
        label.alignment = NSTextAlignment.right
        label.stringValue = "Author:"
        return label
    }()
    
    private var authDeatilLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.white
        label.placeholderString = "(可选)"
        return label
    }()
    
    private var descriptionLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = false
        label.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        label.isBordered = false
        label.alignment = NSTextAlignment.right
        label.stringValue = "Description:"
        return label
    }()
    
    private var descriptionDeatilLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.white
        label.placeholderString = "(可选)"
        return label
    }()
    
    
    private var  versionLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = false
        label.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        label.isBordered = false
        label.alignment = NSTextAlignment.right
        label.stringValue = "Version:"
        return label
    }()
    
    private var versionDetailLabel:NSTextField = {
        var label = NSTextField()
        label.placeholderString = "(可选)"
        label.backgroundColor = NSColor.white
        return label
    }()
    
    private var  whereLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = false
        label.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        label.isBordered = false
        label.alignment = NSTextAlignment.right
        label.stringValue = "Where:"
        return label
    }()
    
    
    private lazy var button:NSButton = {
        var button = NSButton.init(title: "Document", target: self, action: #selector(choiceFolder))
        return button
    }()
    
    @objc func choiceFolder()  {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true

        panel.begin { (result) in
            if result == NSApplication.ModalResponse.OK {
                self.filePath = panel.directoryURL?.path
            }
        }
       
    }
    
    func getResult() -> (author:String, description:String , version:String,filePath:String) {
        
        let result:(author:String, description:String , version:String,filePath:String) = (self.authDeatilLabel.stringValue,self.descriptionDeatilLabel.stringValue,self.versionDetailLabel.stringValue,self.filePath)
        return result
    }
}



