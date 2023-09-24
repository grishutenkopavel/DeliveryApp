//
//  ViewController.swift
//  
//
//  Created by Павел Гришутенко on 21.09.2023.
//

import UIKit

public protocol Controller: AnyObject {
    var navigationDelegate: NavDelegate { get set }
}


open class ViewController: UIViewController, Controller {
    public var navigationDelegate: NavDelegate
    
    public init(navigationDelegate: NavDelegate) {
        self.navigationDelegate = navigationDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        navigationDelegate.deinit()
    }
}
