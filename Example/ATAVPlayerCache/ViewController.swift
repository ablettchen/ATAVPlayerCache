//
//  ViewController.swift
//  ATAVPlayerCache
//
//  Created by ablett on 12/27/2019.
//  Copyright (c) 2019 ablett. All rights reserved.
//

import UIKit
import ATAVPlayerCache

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenSize = UIScreen.main.bounds.size
        let size = CGSize.init(width: 100, height: 50)
        let button = UIButton.init(frame: CGRect.init(x: (screenSize.width - size.width) / 2, y: (screenSize.height - size.height) / 2, width: size.width, height: size.height))
        view.addSubview(button)
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
    }
    
    @objc func play() {
        let vc = PlayerViewController()
        vc.playFinished = { () in
            vc.dismiss(animated: true) {}
        }
        let string = "https://resource.beilezx.com/Upload/Homework/2019/1230/15777032971577703297000-38.98923888376788.mp4"
        vc.confPlayer(with: string)
        self.present(vc, animated: true) {
            vc.player?.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

