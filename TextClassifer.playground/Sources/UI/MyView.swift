import Foundation
import AppKit
import CreateML


public class MyView:NSView{
    
    private var isTrainEnd:Bool = false
    private var sentimentClassifier : MLTextClassifier?
    private var topView:NSView = {
        var view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
        view.layer?.cornerRadius = 5
        view.layer?.masksToBounds = true
        return view
    }()
    
    private var parameterView:ParameterView = {
        var view = ParameterView()
        return view
    }()
    
    private var resultView:ResultView = {
        var view = ResultView()
        return view
    }()
    
    private var saveView:SaveView = {
        var view = SaveView()
        return view
    }()
    
    private var iconImageView:NSImageView = {
        var imageView = NSImageView()
        imageView.image = NSImage.init(named: "icon")
        return imageView
    }()
    
    private lazy var dragView:DragView = {
        var dragView = DragView()
        dragView.delegate = self
        return dragView
    }()
    
    private var titleLabel:NSTextField = {
       var tf = NSTextField()
        tf.stringValue = "Text Classifier"
        tf.isEditable = false
        tf.backgroundColor = NSColor.lightGray
        tf.font = NSFont.systemFont(ofSize: 20)
        tf.isBordered = false
        return tf
    }()
    
    private lazy var saveButton:NSButton = {
        var button = NSButton.init(title: "保存", target: self, action: #selector(saveAction))
        return button
    }()
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    convenience init(){
        self.init(frame: NSRect.init(x: 0, y: 0, width: 250, height: 500))
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1).cgColor
        self.addSubview(self.topView)
        self.topView.addSubview(self.iconImageView)
        self.topView.addSubview(self.titleLabel)
        self.addSubview(self.parameterView)
        self.addSubview(self.dragView)
        self.addSubview(self.resultView)
        self.addSubview(self.saveView)
        self.addSubview(self.saveButton)
        self.saveButton.isHidden = true
        
        self.topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(60)
        }
        
        
        self.iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.left.equalToSuperview().offset(15)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.parameterView.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left)
            make.right.equalTo(self.topView.snp.right)
            make.top.equalTo(self.topView.snp.bottom).offset(10)
            make.height.equalTo(100)
        }
        
        self.dragView.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left)
            make.right.equalTo(self.topView.snp.right)
        make.top.equalTo(self.parameterView.snp.bottom).offset(0)
            make.height.equalTo(self.dragView.snp.width)
        }
        
        self.resultView.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left)
            make.right.equalTo(self.topView.snp.right)
            make.top.equalTo(self.dragView.snp.bottom).offset(20)
            make.height.equalTo(0)
        }
        
        self.saveView.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left)
            make.right.equalTo(self.topView.snp.right)
            make.top.equalTo(self.resultView.snp.bottom).offset(10)
            make.height.equalTo(0)
        }
        self.saveButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left)
            make.right.equalTo(self.topView.snp.right)
            make.top.equalTo(self.saveView.snp.bottom).offset(10)
            make.height.equalTo(30)
            
        }
    }
    
    
    public required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}


extension MyView:DragDelegate{
    
    func endDrag(_ filePath: String) {
        
        let tuple:(textValue:String, labelValue:String) = self.parameterView.getLabelValue()
        print(tuple)
        let classifer = TextClassifer()
        classifer.delegate = self
        classifer.begin(filePath,tuple.textValue, tuple.labelValue)
        
    }
}


extension MyView:TextClassiferDelegate{
    
    func trainEnd(_ trainingAccuracy: Double, _ validationAccuracy: Double, _ evaluationAccuracy: Double, _ sentimentClassifier: MLTextClassifier) {
        self.sentimentClassifier = sentimentClassifier as MLTextClassifier
        self.resultView.setResulit(trainingAccuracy, validationAccuracy, evaluationAccuracy)
        
        self.isTrainEnd = true
        self.saveButton.isHidden = false
        self.needsUpdateConstraints = true
        self.updateConstraintsForSubtreeIfNeeded()

    }
}


extension MyView{
    public override func updateConstraints() {
        if isTrainEnd {
            self.dragView.snp.remakeConstraints { (make) in
                make.left.equalTo(self.topView.snp.left)
                make.right.equalTo(self.topView.snp.right)
                make.top.equalTo(self.parameterView.snp.bottom).offset(0)
                make.height.equalTo(0)
            }
            self.saveView.snp.updateConstraints { (make) in
                make.height.equalTo(150)
            }
            self.resultView.snp.updateConstraints { (make) in
                make.height.equalTo(100)
            }
        }
        super.updateConstraints()
    }
}


extension MyView{
    @objc func saveAction(){

        let tuple:(author:String, description:String , version:String,filePath:String) = self.saveView.getResult()
        do {
            let metadata = MLModelMetadata(author: tuple.author,
                                           shortDescription: tuple.description,
                                           version: tuple.version)
            let path = tuple.filePath+"/textClassifier.mlmodel"
            try self.sentimentClassifier!.write(to: URL(fileURLWithPath:path), metadata: metadata)
        } catch  {
            print("保存失败")
        }
    }
}
