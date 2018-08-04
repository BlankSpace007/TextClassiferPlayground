import AppKit

class DragView: NSImageView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    convenience init(){
        self.init(frame: NSRect.zero)
        self.image = NSImage.init(named: "drog_icon")
    self.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])

    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    
    
}


extension DragView:NSDraggingSource{
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return NSDragOperation.copy
    }
    
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        print("drag operation entered")
        
        return NSDragOperation.copy;
    }
    
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let fileURL = NSURL.init(from: sender.draggingPasteboard)
        let filePath:String = fileURL?.path ?? ""
        print("文件路径为：\(filePath)")
        TextClassifer.begin(filePath)
        return true
    }
    
    
    
}
