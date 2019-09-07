//
//  ViewController.swift
//  SSEmptyView
//
//  Created by shashanksingla on 09/06/2019.
//  Copyright (c) 2019 shashanksingla. All rights reserved.
//

import UIKit
import SSEmptyView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SSEmptyView(frame: self.view.frame, image: "icn_notification", titleText: "Test", subText: "This is the emptyview.")
        self.view.addSubview(view)
        view.showRefreshButton = true
        view.delegate = self
    }
}

extension ViewController: EmptyViewDelegate {
    func viewDidRefreshTapped() {
        print("View refreshed........")
    }
}

