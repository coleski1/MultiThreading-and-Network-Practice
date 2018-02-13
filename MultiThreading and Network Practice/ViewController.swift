//
//  ViewController.swift
//  MultiThreading and Network Practice
//
//  Created by Cole Turner on 2/12/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func generateNumbers(_ sender: UIButton) {
        var lowestNum = Int.max
        DispatchQueue.global(qos: .userInitiated).async {
            var count = 0
            var randomNumbers:[Int] = []
            while count < 10000000 {
                count+=1
                let randomNum = Int(arc4random_uniform(UInt32.max))
                randomNumbers.append(randomNum)
            }
            for x in randomNumbers {
                if x <= lowestNum {
                    lowestNum = x
                }
            }
            DispatchQueue.main.async {
                sender.setTitle(String(lowestNum), for: .normal)
            }
        }
    }
    let scriptURL = URL(string:"http://downloads.nest.com/nest_logo.png")
    
    
    @IBAction func imageLoader(_ sender: UIButton) {
        DispatchQueue.global(qos: .userInitiated).async {
            let session = URLSession(configuration: .default)
            let getImageFromURL = session.dataTask(with: self.scriptURL!) { (data, response, error) in
                if let e = error {
                    print("Error occured: \(e)")
                } else {
                    if (response as? HTTPURLResponse) != nil {
                        if let imageData = data {
                            let tempImage = UIImage(data: imageData)
                            DispatchQueue.main.async{
                                self.image.image = tempImage
                            }
                        } else {
                            print("corrupt file")
                        }
                    } else {
                        print("server isn't responding")
                    }
                }
            }
            getImageFromURL.resume()
        }
    }
    @IBOutlet weak var image: UIImageView!
}

