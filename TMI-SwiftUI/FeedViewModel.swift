//
//  FeedViewModel.swift
//  TMI-SwiftUI
//
//  Created by Jason on 2021/12/17.
//
import Foundation
import FirebaseDatabase
import UIKit

class FeedViewModel:ObservableObject {
    @Published var isLoading: Bool
    @Published var TMIs: [TMI]
    @Published var Best_TMIs: [TMI]
    
    init(){
        print("====FeedViewModel====")
        print("<init>")
        self.isLoading = false
        
        self.TMIs = [TMI(id: UUID(), topic: "", emoji: "", title: "", description: "", writer: User(), color: UIColor.gray),
                     TMI(id: UUID(), topic: "", emoji: "", title: "", description: "", writer: User(), color: UIColor.gray),
                     TMI(id: UUID(), topic: "", emoji: "", title: "", description: "", writer: User(), color: UIColor.gray),
                     TMI(id: UUID(), topic: "", emoji: "", title: "", description: "", writer: User(), color: UIColor.gray),
                     TMI(id: UUID(), topic: "", emoji: "", title: "", description: "", writer: User(), color: UIColor.gray)]
        
        self.Best_TMIs = [TMI(id: UUID(), topic: "", emoji: "", title: "", description: "", writer: User(), color: UIColor.gray)]
        
        GetData(){ result in
            self.isLoading = true
            self.TMIs = result
            self.Best_TMIs = [result[0]]
        }
    }
    
    func GetData(completionHandler : @escaping ([TMI])->Void){
        print("====FeedViewModel====")
        print("<GetData>")
        
        let db = Database.database().reference()
        var result : [TMI] = []
        
        db.child("needTo").getData(){ error, snapshot in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            let TMIs_raw = snapshot.value as? NSDictionary
            
            for key in TMIs_raw!.allKeys{
                let value = TMIs_raw![key] as? NSDictionary
                
                let emoji = value!["emoji"] as! String
                let description = value!["content"] as! String
                let color = self.GetColor(emoji: emoji)
                
                
                let tmi = TMI(topic: "", emoji: emoji, title: "", description: description, writer: User(), color: color)
                result.append(tmi)
            }
            completionHandler(result)
        }
    }
    
    func GetColor(emoji: String) -> UIColor {
        
        let emojiLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20 ))
        emojiLabel.text = emoji
        let avgColor = emojiLabel.toImage?.averageColor
        print("emoji : \(emoji)")
        print("avgcolor : \(avgColor)")
        return avgColor ?? UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0))
        
    }
}
