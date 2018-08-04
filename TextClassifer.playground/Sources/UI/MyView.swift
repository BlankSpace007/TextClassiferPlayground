import Foundation
import AppKit


public class MyView:NSView{
    
    private var topView:NSView = {
        var view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
        view.layer?.cornerRadius = 5
        view.layer?.masksToBounds = true
        return view
    }()
    
    private var iconImageView:NSImageView = {
        var imageView = NSImageView()
        imageView.image = NSImage.init(named: "icon")
        return imageView
    }()
    
    private var dragView:DragView = {
        var dragView = DragView()
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
        self.addSubview(self.dragView)
        
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
        
        self.dragView.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView.snp.left)
            make.right.equalTo(self.topView.snp.right)
            make.top.equalTo(self.topView.snp.bottom).offset(0)
            make.height.equalTo(self.dragView.snp.width)
        }
    }
    
    
    public required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
