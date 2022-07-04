//
//  LGPerson.swift
//  UFoundation
//
//  Created by dong on 2.3.22.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire



extension LGPersonArray: HttpDecodable {
    
    static func parse(json: Any) -> LGPersonArray? {
        if let json = json as? JSON {
            
            var array: [LGPerson] = []
            
            for unit in json["data"].arrayValue {
                let model =  LGPerson(fromDictionary: unit)
                array.append(model)
            }
            var m = LGPersonArray()
            m.list = array
            return m
        }
        return nil
    }
}

struct LGPersonArray {
    
    var list: [LGPerson] = []
    
}

struct LGPerson {
    
    var activeTab : String?
    var alias : String!
    var check : String!
    var checked : Int!
    var children : [Children]!
    var createOrgId : String!
    var enableMenu : Int!
    var extLinkParam : String!
    var hasChildren : String!
    var href : String!
    var id : String!
    var isAllowTenant : String!
    var isExtLink : String!
    var isOpenWindow : String!
    var isParent : String!
    var load : String!
    var menuIcon : String!
    var menuUrl : String!
    var name : String!
    var open : Int!
    var parentId : String!
    var path : String!
    var pkVal : String!
    var sn : String!
    var sysMethods : [String]!
    var tabsStyle : String!
    var templateUrl : String!
    var type : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: JSON){
        activeTab = dictionary["activeTab"].string
        alias = dictionary["alias"].string
        check = dictionary["check"].string
        checked = dictionary["checked"] as? Int
        children = [Children]()
        if let childrenArray = dictionary["children"].array {
            for dic in childrenArray{
                let value = Children(fromDictionary: dic)
                children.append(value)
            }
        }
        createOrgId = dictionary["createOrgId"].string
        enableMenu = dictionary["enableMenu"] as? Int
        extLinkParam = dictionary["extLinkParam"].string
        hasChildren = dictionary["hasChildren"].string
        href = dictionary["href"].string
        id = dictionary["id"].string
        isAllowTenant = dictionary["isAllowTenant"].string
        isExtLink = dictionary["isExtLink"].string
        isOpenWindow = dictionary["isOpenWindow"].string
        isParent = dictionary["isParent"].string
        load = dictionary["load"].string
        menuIcon = dictionary["menuIcon"].string
        menuUrl = dictionary["menuUrl"].string
        name = dictionary["name"].string
        open = dictionary["open"] as? Int
        parentId = dictionary["parentId"].string
        path = dictionary["path"].string
        pkVal = dictionary["pkVal"].string
        sn = dictionary["sn"].string
        sysMethods = dictionary["sysMethods"] as? [String]
        tabsStyle = dictionary["tabsStyle"].string
        templateUrl = dictionary["templateUrl"].string
        type = dictionary["type"].string
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if activeTab != nil{
            dictionary["activeTab"] = activeTab
        }
        if alias != nil{
            dictionary["alias"] = alias
        }
        if check != nil{
            dictionary["check"] = check
        }
        if checked != nil{
            dictionary["checked"] = checked
        }
        if children != nil{
            var dictionaryElements = [[String:Any]]()
            for childrenElement in children {
                dictionaryElements.append(childrenElement.toDictionary())
            }
            dictionary["children"] = dictionaryElements
        }
        if createOrgId != nil{
            dictionary["createOrgId"] = createOrgId
        }
        if enableMenu != nil{
            dictionary["enableMenu"] = enableMenu
        }
        if extLinkParam != nil{
            dictionary["extLinkParam"] = extLinkParam
        }
        if hasChildren != nil{
            dictionary["hasChildren"] = hasChildren
        }
        if href != nil{
            dictionary["href"] = href
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isAllowTenant != nil{
            dictionary["isAllowTenant"] = isAllowTenant
        }
        if isExtLink != nil{
            dictionary["isExtLink"] = isExtLink
        }
        if isOpenWindow != nil{
            dictionary["isOpenWindow"] = isOpenWindow
        }
        if isParent != nil{
            dictionary["isParent"] = isParent
        }
        if load != nil{
            dictionary["load"] = load
        }
        if menuIcon != nil{
            dictionary["menuIcon"] = menuIcon
        }
        if menuUrl != nil{
            dictionary["menuUrl"] = menuUrl
        }
        if name != nil{
            dictionary["name"] = name
        }
        if open != nil{
            dictionary["open"] = open
        }
        if parentId != nil{
            dictionary["parentId"] = parentId
        }
        if path != nil{
            dictionary["path"] = path
        }
        if pkVal != nil{
            dictionary["pkVal"] = pkVal
        }
        if sn != nil{
            dictionary["sn"] = sn
        }
        if sysMethods != nil{
            dictionary["sysMethods"] = sysMethods
        }
        if tabsStyle != nil{
            dictionary["tabsStyle"] = tabsStyle
        }
        if templateUrl != nil{
            dictionary["templateUrl"] = templateUrl
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }
    
}






struct Children{
    
    var activeTab : String?
    var alias : String?
    var check : String?
    var checked : Int?
    var children : [JSON]?
    var createOrgId : String?
    var enableMenu : Int?
    var extLinkParam : String?
    var hasChildren : String?
    var href : String?
    var id : String?
    var isAllowTenant : String?
    var isExtLink : String?
    var isOpenWindow : String?
    var isParent : String?
    var load : String?
    var menuIcon : String?
    var menuUrl : String?
    var name : String?
    var open : Int?
    var parentId : String?
    var path : String?
    var pkVal : String?
    var sn : String?
    var sysMethods : [JSON]?
    var tabsStyle : String?
    var templateUrl : String?
    var type : String?
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: JSON){
        activeTab = dictionary["activeTab"].string
        alias = dictionary["alias"].string
        check = dictionary["check"].string
        checked = dictionary["checked"].int
        children = dictionary["children"].array
        createOrgId = dictionary["createOrgId"].string
        enableMenu = dictionary["enableMenu"].int
        extLinkParam = dictionary["extLinkParam"].string
        hasChildren = dictionary["hasChildren"].string
        href = dictionary["href"].string
        id = dictionary["id"].string
        isAllowTenant = dictionary["isAllowTenant"].string
        isExtLink = dictionary["isExtLink"].string
        isOpenWindow = dictionary["isOpenWindow"].string
        isParent = dictionary["isParent"].string
        load = dictionary["load"].string
        menuIcon = dictionary["menuIcon"].string
        menuUrl = dictionary["menuUrl"].string
        name = dictionary["name"].string
        open = dictionary["open"].int
        parentId = dictionary["parentId"].string
        path = dictionary["path"].string
        pkVal = dictionary["pkVal"].string
        sn = dictionary["sn"].string
        sysMethods = dictionary["sysMethods"].array
        tabsStyle = dictionary["tabsStyle"].string
        templateUrl = dictionary["templateUrl"].string
        type = dictionary["type"].string
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if activeTab != nil{
            dictionary["activeTab"] = activeTab
        }
        if alias != nil{
            dictionary["alias"] = alias
        }
        if check != nil{
            dictionary["check"] = check
        }
        if checked != nil{
            dictionary["checked"] = checked
        }
        if children != nil{
            dictionary["children"] = children
        }
        if createOrgId != nil{
            dictionary["createOrgId"] = createOrgId
        }
        if enableMenu != nil{
            dictionary["enableMenu"] = enableMenu
        }
        if extLinkParam != nil{
            dictionary["extLinkParam"] = extLinkParam
        }
        if hasChildren != nil{
            dictionary["hasChildren"] = hasChildren
        }
        if href != nil{
            dictionary["href"] = href
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isAllowTenant != nil{
            dictionary["isAllowTenant"] = isAllowTenant
        }
        if isExtLink != nil{
            dictionary["isExtLink"] = isExtLink
        }
        if isOpenWindow != nil{
            dictionary["isOpenWindow"] = isOpenWindow
        }
        if isParent != nil{
            dictionary["isParent"] = isParent
        }
        if load != nil{
            dictionary["load"] = load
        }
        if menuIcon != nil{
            dictionary["menuIcon"] = menuIcon
        }
        if menuUrl != nil{
            dictionary["menuUrl"] = menuUrl
        }
        if name != nil{
            dictionary["name"] = name
        }
        if open != nil{
            dictionary["open"] = open
        }
        if parentId != nil{
            dictionary["parentId"] = parentId
        }
        if path != nil{
            dictionary["path"] = path
        }
        if pkVal != nil{
            dictionary["pkVal"] = pkVal
        }
        if sn != nil{
            dictionary["sn"] = sn
        }
        if sysMethods != nil{
            dictionary["sysMethods"] = sysMethods
        }
        if tabsStyle != nil{
            dictionary["tabsStyle"] = tabsStyle
        }
        if templateUrl != nil{
            dictionary["templateUrl"] = templateUrl
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }
    
}
