//
//  UserManager.swift
//  GoWild
//
//  Created by SA - Haider Ali on 28/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import ObjectMapper

final class UserManager : Mappable {
    
    var accessToken: String?
    var id : String?
    var firstName : String?
    var lastName : String?
    var birthDate : String?
    var gender : String?
    var username : String?
    var email : String?
    var phoneNo : String?
    var aboutMe : String?
    var picture : String?
    var frontImage: String?
    var backImage: String?
    var status : UserStatusManager?
    var role : UserRoleManager?
    var addressOne : String?
    var addressTwo : String?
    var baseURL : String?
    var selfieVerified : Bool?
    
    //    init?(map: Map) {
    //
    //    }
    
    static let shared = UserManager()
    
    init() {
        
    }
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    convenience init(dic:[String:Any]) {
        let map = Map.init(mappingType: .fromJSON, JSON: dic)
        self.init(map:map)!
    }
    
    func deleteUser(){
        
        accessToken = ""
        id = nil
        firstName = ""
        lastName = ""
        birthDate = ""
        gender = ""
        username = ""
        email = ""
        phoneNo = ""
        aboutMe = ""
        picture = ""
        frontImage = ""
        backImage = ""
        status = nil
        role = nil
        addressOne = ""
        addressTwo = ""
        baseURL = ""
        selfieVerified = false
        
        saveUser(user: self)
    }
    
    func loadUser() {
        let userDef = UserDefaults.standard
        if ((userDef.string(forKey: Constants.USER_DATA)) != nil) {
            let uString = UserDefaults.standard.value(forKey: Constants.USER_DATA) as! String
            let mapper = Mapper<UserManager>()
            let userObj = mapper.map(JSONString: uString)
            let map = Map.init(mappingType: .fromJSON, JSON: (userObj?.toJSON())!)
            self.mapping(map:map)
        }
    }
    
    func saveUser(user: UserManager) {
        UserDefaults.standard.set(user.toJSONString()!, forKey: Constants.USER_DATA)
        UserDefaults.standard.synchronize()
        loadUser()
    }
    
    func isLoggedIn() -> Bool {
        return id != nil ? true : false
    }
    
    func getBaseURL() -> String{
        self.baseURL ?? ""
    }
    
    func getFullName() -> String{
        return "\(UserManager.shared.firstName ?? "") \(UserManager.shared.lastName ?? "")"
    }
    
    func getAccessToken() -> String{
        return "Bearer \(UserManager.shared.accessToken ?? "")"
    }
    
    func mapping(map: Map) {
        
        accessToken <- map["accessToken"]
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        birthDate <- map["birthDate"]
        gender <- map["gender"]
        username <- map["username"]
        email <- map["email"]
        phoneNo <- map["phoneNo"]
        aboutMe <- map["aboutMe"]
        picture <- map["picture"]
        frontImage <- map["frontImage"]
        backImage <- map["backImage"]
        status <- map["status"]
        role <- map["role"]
        addressOne <- map["addressOne"]
        addressTwo <- map["addressTwo"]
        baseURL <- map["base_url"]
        selfieVerified <- map["selfie_verified"]
        
    }
    
}

final class UserPictureManager: Mappable{
    
    var id : String?
    var path : String?
    var size : Int?
    var mimetype : String?
    var fileName : String?
    
    init(id: String?,path: String?,size: Int?,mimetype: String?,fileName: String?) {
        self.id = id
        self.path = path
        self.size = size
        self.mimetype = mimetype
        self.fileName = fileName
    }
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        path <- map["path"]
        size <- map["size"]
        mimetype <- map["mimetype"]
        fileName <- map["fileName"]
    }
    
}

final class UserStatusManager: Mappable{
    
    var id : String?
    var statusName : String?
    var isActive : Bool?
    
    init(id: String?,statusName: String?,isActive: Bool?) {
        self.id = id
        self.statusName = statusName
        self.isActive = isActive
    }
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        statusName <- map["statusName"]
        isActive <- map["isActive"]
    }
    
}

final class UserRoleManager: Mappable{
    
    var id : String?
    var name : String?
    
    init(id: String?,name: String?) {
        self.id = id
        self.name = name
    }
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
}



//MARK: - EXTENSION FOR CONVERT USER METHODS -

extension UserManager{
    
    func convertUser(user: CurrentUserResponse) -> UserManager{
        let currentUser = UserManager()
        currentUser.accessToken = UserManager.shared.accessToken
        currentUser.id = user.id ?? UserManager.shared.id
        currentUser.firstName = user.firstName ?? UserManager.shared.firstName
        currentUser.lastName = user.lastName ?? UserManager.shared.lastName
        currentUser.birthDate = user.birthDate ?? UserManager.shared.birthDate
        currentUser.gender = user.gender ?? UserManager.shared.gender
        currentUser.username = user.username ?? UserManager.shared.username
        currentUser.email = user.email ?? UserManager.shared.email
        currentUser.phoneNo = user.phoneNo ?? UserManager.shared.phoneNo
        currentUser.aboutMe = user.aboutMe ?? UserManager.shared.aboutMe
        currentUser.picture = user.userPhoto ?? UserManager.shared.picture
        currentUser.frontImage = user.frontImage ?? UserManager.shared.frontImage
        currentUser.backImage = user.backImage ?? UserManager.shared.backImage
        currentUser.status = self.convertStatus(status: user.userStatus) ?? UserManager.shared.status
        currentUser.role = self.convertRole(role: user.role) ?? UserManager.shared.role
        currentUser.addressOne = user.addressOne ?? UserManager.shared.addressOne
        currentUser.addressTwo = user.addressTwo ?? UserManager.shared.addressTwo
        currentUser.baseURL = user.baseURL ?? ConfigurationManager.shared.getBackendString()
        currentUser.selfieVerified = user.selfieVerified ?? false
        return currentUser
    }
    
    private func convertPicture(photo: CurrentUserPicture?) -> UserPictureManager?{
        if let photo = photo{
            return UserPictureManager(id: photo.id, path: photo.path, size: photo.size, mimetype: photo.mimetype, fileName: photo.fileName)
        }else{
            return nil
        }
    }
    
    private func convertStatus(status: CurrentUserStatus?) -> UserStatusManager?{
        if let status = status{
            return UserStatusManager(id: status.id, statusName: status.statusName, isActive: status.isActive)
        }else{
            return nil
        }
    }
    
    private func convertRole(role: CurrentUserRole?) -> UserRoleManager?{
        if let role = role{
            return UserRoleManager(id: role.id, name: role.name)
        }else{
            return nil
        }
    }
    
}
