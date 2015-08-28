//
//  ViewController.swift
//  LiquidFloatingActionButton
//
//  Created by Takuma Yoshida on 08/25/2015.
//  Copyright (c) 2015 Takuma Yoshida. All rights reserved.
//

import UIKit
import LiquidFloatingActionButton

class ViewController: UIViewController, LiquidFloatingActionButtonDataSource {
    
    var cells: [LiquidFloatingCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let floatingActionButton = LiquidFloatingActionButton(frame: floatingFrame)
        floatingActionButton.dataSource = self
        let cellFactory: (String, String) -> LiquidFloatingCell = { (iconName, debugString) in
            let cell = LiquidFloatingCell(icon: UIImage(named: iconName)!) { _ in println(debugString) }
            return cell
        }
        
        cells.append(cellFactory("ic_cloud", "touched cloud"))
        cells.append(cellFactory("ic_system", "touched system"))
        cells.append(cellFactory("ic_place", "touched place"))
        cells.append(cellFactory("ic_art", "touched art"))
        cells.append(cellFactory("ic_brush", "touched brush"))
        cells.append(cellFactory("ic_art", "touched art"))
        cells.append(cellFactory("ic_brush", "touched brush"))

        self.view.addSubview(floatingActionButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }

}