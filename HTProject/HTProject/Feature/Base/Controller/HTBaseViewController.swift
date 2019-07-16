//
//  HTBaseViewController.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  基类

import UIKit

class HTBaseViewController: UIViewController {
    
    //MARK: ---------- LifeCycle ----------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = HT_Color_FFFFFF
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("---\(self.classForCoder)---\(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        debugPrint("---\(self.classForCoder)---\(#function)")
    }
    
    deinit {
        debugPrint("---\(self.classForCoder)---\(#function)")
    }
    
    //MARK: ---------- CustomizeFuntions ----------
    
}

