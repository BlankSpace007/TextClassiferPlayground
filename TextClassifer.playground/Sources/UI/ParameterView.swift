import AppKit

class ParameterView:NSView{
    
    private var textLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = false
        label.wantsLayer = true
        label.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        label.stringValue = "textColumn:"
        label.isBordered = false
        return label
    }()
    
    private var labelLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = false
        label.wantsLayer = true
        label.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        label.stringValue = "labelColumn:"
        label.isBordered = false
        return label
    }()
    
    private var textDetailLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = true
        label.wantsLayer = true
        label.isBordered = false
        label.stringValue = "text"
        return label
    }()
    
    private var labelDetailLabel:NSTextField = {
        var label = NSTextField()
        label.isEditable = true
        label.wantsLayer = true
        label.isBordered = false
        label.stringValue = "label"
        return label
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    convenience init() {
        self.init(frame: NSRect.zero)
        self.wantsLayer = true
        self.layer?.cornerRadius = 5
        self.layer?.masksToBounds = true
        self.layer?.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1).cgColor
        self.layer?.borderColor = NSColor.lightGray.cgColor
        self.layer?.borderWidth = 1
        
        self.addSubview(self.textLabel)
        self.addSubview(self.labelLabel)
        self.addSubview(self.textDetailLabel)
        self.addSubview(self.labelDetailLabel)
        
        self.textLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().multipliedBy(2/3.0)
            make.width.equalTo(80)
        }
        
        self.labelLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().multipliedBy(4/3.0)
            make.width.equalTo(80)
        }
        
        self.textDetailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.textLabel.snp.right)
            make.centerY.equalTo(self.textLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(self.textLabel.snp.height)
        }
        
        self.labelDetailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.labelLabel.snp.right)
            make.centerY.equalTo(self.labelLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(self.textLabel.snp.height)
        }
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func getLabelValue() -> (textValue:String, labelValue:String) {
        let tuple:(textValue:String,labelValue:String) = (self.textDetailLabel.stringValue,self.labelDetailLabel.stringValue)
        return tuple
    }
}
