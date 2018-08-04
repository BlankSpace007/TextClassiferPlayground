import Foundation
import CreateML


class TextClassifer {
    
    
    class func begin(_ path:String) {
        
        do{
            let data = try MLDataTable(contentsOf: URL(fileURLWithPath: path))
            let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)
            let sentimentClassifier =  try MLTextClassifier(trainingData: trainingData, textColumn: "text",labelColumn: "label")
            // Training accuracy as a percentage
            let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100
            
            // Validation accuracy as a percentage
            let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
            
            print("训练正确率：\(trainingAccuracy)  验证正确率：\(validationAccuracy)")
            
            let evaluationMetrics = sentimentClassifier.evaluation(on: testingData)
            let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

            print("测试正确率：\(evaluationAccuracy)" )
        }catch {
            print("数据格式或者标签不正确")
        }
        
        
        
        
        
//        do{
//                  }catch {
//            print("xxxx")
//        }
//        
    }
}
