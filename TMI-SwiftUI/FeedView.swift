
import SwiftUI
import AuthenticationServices
import Alamofire
import SnapKit
import SkeletonView
import UIKit

struct FeedView: View {
    
    @StateObject var vm = FeedViewModel()
    
    var body: some View {
        
        let headerImg = UIImage(named: "Feed-Header")
        let bestImg = UIImage(named: "icon-best")
        let followingImg = UIImage(named: "icon-following")
        
        let TMIs = vm.TMIs
        let Best_TMIs = vm.Best_TMIs
        
        ScrollView{
            VStack{
                Image(uiImage: headerImg!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.leading,.trailing], Global_Padding / 2)
                
                BestHeaderView()
                
                BestView(Best_TMIs: Best_TMIs)
                
                FollowingListHeaderView()
                
                FollowingListView(TMIs: TMIs)
            }
        }.animation(.default)
    }
}

struct TMIView: View {
    var tmi: TMI
    var emojiSize = UIScreen.screenWidth * 0.15
    @State var isTapped = false
    @State var HeightRatio = 0.1
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(tmi.color.suColor)
                .cornerRadius(20)
            HStack{
                Text(tmi.emoji)
                    .frame(width: emojiSize, height: emojiSize, alignment: .center)
                    .font(.system(size: 40))
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(20)
                
                
                ZStack{
                    Text(tmi.description)
                        .font(.system(size: 15))
                        .frame(width: UIScreen.screenWidth * 0.5, alignment: .leading)
                }
                VStack{
                    HStack{
                        Spacer()
                        Text("언어")
                            .padding([.top,.trailing], 20)
                            .font(.system(size: 10))
                    }
                    Spacer()
                }
            }
        }
        .frame(height: UIScreen.screenHeight * HeightRatio)
        .onTapGesture {
            print("tap \(tmi.emoji)")
            
            if(isTapped){
                isTapped = false
                HeightRatio = 0.1
            }
            else{
                isTapped = true
                HeightRatio = 0.2
            }
        }
    }
}

struct BestHeaderView: View {
    var body: some View {
        HStack{
            Text("Best")
                .frame(height: 0)
                .padding()
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .font(.custom("SpoqaHanSansNeo-Bold", size: 15))
                .padding([.leading,.top])
            Spacer()
        }
    }
}

struct BestView: View {
    let Best_TMIs : [TMI]
    
    var body: some View {
        ForEach(Best_TMIs, id: \.self) { tmi in
            TMIView(tmi: tmi)
                .listRowSeparator(.hidden)
                .padding([.top,.leading,.trailing])
        }
    }
}


struct FollowingListHeaderView: View {
    var body: some View {
        HStack{
            Text("Following")
                .frame(height: 0)
                .padding()
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .font(.custom("SpoqaHanSansNeo-Bold", size: 15))
                .padding([.leading,.top])
            Spacer()
        }
    }
}

struct FollowingListView: View {
    let TMIs : [TMI]
    
    var body: some View {
        ForEach(TMIs, id: \.self) { tmi in
            TMIView(tmi: tmi)
                .listRowSeparator(.hidden)
                .padding([.top,.leading,.trailing])
        }
    }
}


struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

