//
//  ContentView.swift
//  TMI-SwiftUI
//
//  Created by Jason on 2021/12/16.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import AuthenticationServices
import Alamofire


struct LoginView: View {
    
    @State var isLogin = false
    
    var body: some View {
        
        let LogoImg = UIImage(named: "icon-login")
        let AppleBtnImg = UIImage(named: "apple-login")
        let KakaoBtnImg = UIImage(named: "kakao-login")
        
        setLoginView(LogoImg, AppleBtnImg, KakaoBtnImg)
    }
}

extension LoginView{
    fileprivate func setLoginView(_ LogoImg: UIImage?, _ AppleBtnImg: UIImage?, _ KakaoBtnImg: UIImage?) -> some View {
        return NavigationView{
            VStack {
                Image(uiImage: LogoImg!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(UIScreen.screenWidth * 0.25)
                    .offset(x: 0, y: Global_Padding)
                
                
                Button(action: {print("tap")}) {
                    Image(uiImage: AppleBtnImg!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(Global_Padding)
                }
                
                Button(action: {clickKakaoLogin()}){
                    Image(uiImage: KakaoBtnImg!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(Global_Padding)
                        .offset(x: 0, y: -Global_Padding)
                }
                .fullScreenCover(isPresented: $isLogin) { TMI_TabView() }
            }
            .offset(x: 0, y: -2 * Global_Padding)
        }
    }
    
    func clickKakaoLogin(){
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                _ = oauthToken
                let accessToken = oauthToken?.accessToken
                
                print("accessToken:\(accessToken)")
                
                self.getDataFromKaKaoLogin(accessToken: accessToken!){ data in
                    loginUsr.id = "KAKAO_\(data.id)"
                    loginUsr.name = data.properties.nickname
                    loginUsr.profileImg = data.properties.profile_image
                    print("loginUsr : \(loginUsr)")
                }
                self.isLogin = true
            }
        }
    }
    
    func getDataFromKaKaoLogin(accessToken : String, completionHandler : @escaping (UserResponse)->Void) {
        
        var data : UserResponse!
        let url = "https://kapi.kakao.com/v2/user/me"
        let headers : HTTPHeaders = [ "Authorization" : "Bearer \(accessToken)"]
        
        AF.request(url,headers: headers) //로그인한 사용자 정보 가져오기
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    print("DEBUG>> Success \(response) ")
                    data = response
                    
                case .failure(let error):
                    print("DEBUG>> Error : \(error.localizedDescription)")
                }
                completionHandler(data)
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
