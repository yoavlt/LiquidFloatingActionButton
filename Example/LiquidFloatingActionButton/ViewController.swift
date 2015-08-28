//
//  ViewController.swift
//  LiquidFloatingActionButton
//
//  Created by Takuma Yoshida on 08/25/2015.
//  Copyright (c) 2015 Takuma Yoshida. All rights reserved.
//

import UIKit
import LiquidFloatingActionButton

class ViewController: UIViewController, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate {
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        floatingActionButton = LiquidFloatingActionButton(frame: floatingFrame)
        floatingActionButton.dataSource = self
        floatingActionButton.delegate = self
        floatingActionButton.color = UIColor.orangeColor()
        let cellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            return LiquidFloatingCell(icon: UIImage(named: iconName)!)
        }
        
        cells.append(cellFactory("ic_cloud"))
        cells.append(cellFactory("ic_system"))
        cells.append(cellFactory("ic_place"))
        cells.append(cellFactory("ic_art"))
        cells.append(cellFactory("ic_brush"))
        cells.append(cellFactory("ic_art"))
        cells.append(cellFactory("ic_brush"))

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
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        println("did Tapped! \(index)")
        floatingActionButton.close()
    }

}