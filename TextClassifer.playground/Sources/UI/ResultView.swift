import AppKit

class ResultView: NSView {
    private var titleLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.lightGray
        label.textColor = NSColor.white
        label.isBordered = false
        label.isEditable = false
        label.stringValue = "Model accuracy"
        label.font = NSFont.systemFont(ofSize: 12)
        return label
    }()
    
    private var trainAccuracyLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.lightGray
        label.textColor = NSColor.white
        label.isBordered = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 20)
        label.alignment = NSTextAlignment.center
        return label
    }()
    
    private var validationAccuracyLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.lightGray
        label.textColor = NSColor.white
        label.isBordered = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 20)
        label.alignment = NSTextAlignment.center
        return label
    }()
    
    private var evaluationAccuracyLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.lightGray
        label.textColor = NSColor.white
        label.isBordered = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 20)
        label.alignment = NSTextAlignment.center
        return label
    }()
    
    private var trainLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.lightGray
        label.textColor = NSColor.white
        label.isBordered = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 11)
        label.alignment = NSTextAlignment.center
        label.stringValue = "Training"
        return label
    }()
    
    private var validationLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.lightGray
        label.textColor = NSColor.white
        label.isBordered = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 11)
        label.alignment = NSTextAlignment.center
        label.stringValue = "Validation"
        return label
    }()
    
    private var evaluationLabel:NSTextField = {
        var label = NSTextField()
        label.backgroundColor = NSColor.lightGray
        label.textColor = NSColor.white
        label.isBordered = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 11)
        label.alignment = NSTextAlignment.center
        label.stringValue = "Evaluation"
        return label
    }()
    
    convenience init() {
        self.init(frame: NSRect.zero)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.layer?.cornerRadius = 5
        self.layer?.masksToBounds  = true
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.trainAccuracyLabel)
        self.addSubview(self.trainLabel)
        self.addSubview(self.validationAccuracyLabel)
        self.addSubview(self.validationLabel)
        self.addSubview(self.evaluationAccuracyLabel)
        self.addSubview(self.evaluationLabel)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
        }
        
        self.trainAccuracyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.centerY.equalToSuperview()
        }
        
        self.trainLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.trainAccuracyLabel.snp.centerX)
            make.top.equalTo(self.trainAccuracyLabel.snp.bottom).offset(5)
            
        }
        
        self.validationAccuracyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.validationLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.validationAccuracyLabel.snp.centerX)
            make.top.equalTo(self.validationAccuracyLabel.snp.bottom).offset(5)
            
        }
        
        self.evaluationAccuracyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().multipliedBy(3/2.0)
            make.centerY.equalToSuperview()
        }
        
        self.evaluationLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.evaluationAccuracyLabel.snp.centerX)
            make.top.equalTo(self.evaluationAccuracyLabel.snp.bottom).offset(5)
            
        }
    }
    
    func  setResulit(_ trainAccuracy:Double,_ validationAccuracy:Double,_ evaluationAccuracy:Double)
    {
        self.trainAccuracyLabel.stringValue = "\(Int(trainAccuracy))%"
        self.validationAccuracyLabel.stringValue = "\(Int(validationAccuracy))%"
        self.evaluationAccuracyLabel.stringValue = "\(Int(evaluationAccuracy))%"

    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
