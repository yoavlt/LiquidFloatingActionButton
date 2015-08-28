//
//  ViewController.swift
//  LiquidFloatingActionButton
//
//  Created by Takuma Yoshida on 08/25/2015.
//  Copyright (c) 2015 Takuma Yoshida. All rights reserved.
//

import UIKit
import LiquidFloatingActionButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let floatingActionButton = LiquidFloatingActionButton(frame: floatingFrame, direction: .Line)
        floatingActionButton.addCellImage(UIImage(named: "ic_cloud")!) { _ in println("touched cloud") }
        floatingActionButton.addCellImage(UIImage(named: "ic_system")!) { _ in println("touched ic system") }
        floatingActionButton.addCellImage(UIImage(named: "ic_place")!) { _ in println("touched ic place") }
        floatingActionButton.addCellImage(UIImage(named: "ic_art")!) { _ in println("touched art") }
        floatingActionButton.addCellImage(UIImage(named: "ic_brush")!) { _ in println("touched brush") }
        floatingActionButton.addCellImage(UIImage(named: "ic_art")!) { _ in println("touched art") }
        floatingActionButton.addCellImage(UIImage(named: "ic_brush")!) { _ in println("touched brush") }
        
        
        self.view.addSubview(floatingActionButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}