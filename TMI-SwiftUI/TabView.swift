
import SwiftUI

struct TMI_TabView: View {
    
    
    var body: some View {
    
        let homeImg = UIImage(named: "icon-home")
        let plusImg = UIImage(named: "icon-plus")
        let myImg = UIImage(named: "icon-my")
        
        TabView {
            FeedView()
                .tabItem{
                    Image(uiImage: homeImg!)
                }
            WritingView()
                .tabItem{
                    Image(uiImage: plusImg!)
                }
            MyView()
                .tabItem{
                    Image(uiImage: myImg!)
                }
        }
        .accentColor(Color.black)
    }
}
struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TMI_TabView()
    }
}
