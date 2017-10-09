//
//  MyListTableViewController.swift
//  Homework2
//
//  Created by Ayyanchira, Akshay Murari on 10/9/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import Alamofire

class MyListTableViewController: UITableViewController {

    
    var myData:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myData = ["Jackfruit","Mangoes", "Apples", "Chicckoo", "Bananas", "Orange"]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchData()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
//                print(feedArray)
                
                for feed in feedArray{
                    
                    //category parsing - Term
                    if let category = feed["category"] as? [String:Any],
                    let attributes = category["attributes"] as? [String:Any],
                        let term = attributes["term"] as? String{
                        print("category is \(term)")
                    }
                    
                    //Author name
                    if let artist = feed["artist"] as? [String:Any],
                        let label = artist["label"] as? String{
                            print("Author is \(label)")
                    }
                    
                    //Title
                    if let name = feed["name"] as? [String:Any],
                        let label = name["label"] as? String{
                        print("Title is \(label)")
                    }
                    
                    //URL
                    if let squareImage = feed["squareImage"] as? [Any],
                    let firstObject = squareImage[0] as? [String:Any],
                        let label = firstObject["label"] as? String{
                            let thumbnailURL = URL(string: label)!
                        print("Small image URL is \(String(describing: thumbnailURL))")
                    }
                    
                    //Price
                    if let price = feed["price"] as? [String:Any],
                     let amount = price["amount"] as? String{
                        print("Amount is \(amount)")
                    }
                   
                    //Release date
                    if let releaseDate = feed["releaseDate"] as? [String:Any],
                        let label = releaseDate["label"] as? String{
                        print("Release date is \(label)")
                    }
                    
//                    if let category = feed["category"] as? String,
//                        let price = feed["price"] as? String,
//                        let releaseDate = feed["releaseDate"] as? String,
//                        let squareImage = feed["squareImage"] as? URL,
//                        let artist = feed["artist"] as? String,
//                        let title = feed["name"] as? String{
//
//                        let feed:Product = Product(category: category , price: price as! Float, title: title , author: artist , releaseDate: releaseDate as! String, thumbnailURL: squareImage , otherImageURL: nil, productDescription: nil)
//
//                        print("object created for \(feed.title)")
//                    }
                }
        }
    }
    
    // MARK: - Table view data source

    @IBAction func reloadButtonPressed(_ sender: UIBarButtonItem) {
        tableView.reloadData()
        fetchData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myData!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)

        // Configure the cell...
        //cell.textLabel?.text = myData![indexPath.row]
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
