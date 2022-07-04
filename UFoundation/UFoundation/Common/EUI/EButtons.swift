//
//  EButtons.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/4/18.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit

public class EButtons: UIButton {
    
    func parimy() -> UIButton {
        
        let button = UIButton(type: .custom)
                
        button.rx.tap.subscribe(onNext: {
            
        }, onError: { error in
            
        }, onCompleted: {
            
        }, onDisposed: {
            
        })
        return button
        
        
    }
   

}
