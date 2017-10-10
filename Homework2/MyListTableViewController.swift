//
//  MyListTableViewController.swift
//  Homework2
//
//  Created by Ayyanchira, Akshay Murari on 10/9/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class MyListTableViewController: UITableViewController {

    
    var productArray:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productArray = NSMutableArray()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchData() {
        let url = URL(string: "http://dev.theappsdr.com/apis/summer_2016_ios/data.json")
        Alamofire.request(url!)
            .responseJSON {response in
                
                //error checking
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                //response check
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                //parse
                guard let feedArray = json["feed"] as? [[String: Any]]  else {
                    print("Could not get todo title from JSON")
                    return
                }
                
                for feed in feedArray{
                    
                    var category = "", title = "", author = "", releaseDate = ""
                    var thubnailURL:URL? = nil, otherImageURL:URL? = nil
                    var price:Float?
                    var description:String? = nil
                    //category parsing - Term
                    if let categoryDict = feed["category"] as? [String:Any],
                    let attributes = categoryDict["attributes"] as? [String:Any],
                        let term = attributes["term"] as? String{
                        category = term
                    }
                    
                    //Author name
                    if let artist = feed["artist"] as? [String:Any],
                        let label = artist["label"] as? String{
                            author = label
                    }
                    
                    //Title
                    if let name = feed["name"] as? [String:Any],
                        let label = name["label"] as? String{
                        title = label
                    }
                    
                    //URL
                    if let squareImage = feed["squareImage"] as? [Any],
                    let firstObject = squareImage[0] as? [String:Any],
                        let label = firstObject["label"] as? String{
                        thubnailURL = URL(string: label)!
                    }
                    
                    //Price
                    if let priceDict = feed["price"] as? [String:Any],
                     let amount = priceDict["amount"] as? Float{
                        price = amount
                    }
                   
                    //Release date
                    if let releaseDateDict = feed["releaseDate"] as? [String:Any],
                        let label = releaseDateDict["label"] as? String{
                        releaseDate = label
                    }
                    
                    //description
                    if let summaryDict = feed["summary"] as? [String:Any],
                        let label = summaryDict["label"] as? String{
                        description = label
                    }
                    
                    //other image url
                    if let otherImageArray = feed["otherImage"] as? [Any],
                        let firstObject = otherImageArray[0] as? [String:Any],
                        let label = firstObject["label"] as? String{
                        otherImageURL = URL(string: label)!
                    }
                    
                    
                    let product = Product(category: category, price: price!, title: title, author: author, releaseDate: releaseDate, thumbnailURL: thubnailURL!, otherImageURL: otherImageURL, productDescription: description)
                    
                    self.productArray?.add(product)
                }
                
                self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    @IBAction func reloadButtonPressed(_ sender: UIBarButtonItem) {
        productArray?.removeAllObjects()
        fetchData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (productArray?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MyCustomTableViewCell
        let product = productArray![indexPath.row] as! Product
        cell.authorLabel.text = product.author
        cell.titleLabel.text = product.title
        
        cell.thumbnailImageView.sd_setImage(with: product.thumbnailURL, completed: nil)
        
        
        cell.priceLabel.text = String(format: "$%.2f", product.price)
        cell.releaseDateLabel.text = product.releaseDate
        
        
        

        // Configure the cell...
        //cell.textLabel?.text = myData![indexPath.row]
        return cell
    }
 

}
