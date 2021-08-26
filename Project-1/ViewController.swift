//
//  ViewController.swift
//  Project-1
//
//  Created by Chloe Fermanis on 7/8/21.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()

    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Storm Viewer"
        //navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Day 40: Challenge 1: load NSSL images in background.
        performSelector(inBackground: #selector(loadImages), with: nil)
    }
    
    // Day 40: Challenge 1: load NSSL images in background.
    @objc func loadImages() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items.sorted() {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.numberOfImages = pictures.count
            vc.selectedImageNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func shareTapped() {
        
        let svc = UIActivityViewController(activityItems: [title], applicationActivities: [])
        svc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(svc, animated: true)
    }
    
}

