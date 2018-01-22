//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Qian Yang on 1/22/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//
import UIKit
class PeopleViewController: UITableViewController {
    // Hardcoded data for now
    var people = [String] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://swapi.co/api/people/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
              
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! [NSDictionary]
                        print(resultsArray[0].value(forKey: "name")!)
                        
                        for i in 0...resultsArray.count - 1 {
                            let person = resultsArray[i].value(forKey: "name") as! String
                            self.people.append(person)
                        }
//                        print(self.people)
    //   DOWNCAST AN ANYOBJECT TO SPECIFIC TYPE     NSArray
//                        NSMutableArray
//                        NSDictionary
//                        NSMutableDictionary
//                        print(resultsArray.count)
//                        print(resultsArray[0])
//                        print(resultsArray.firstObject)
                    }
                }
                DispatchQueue.main.async { 
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        })
        task.resume()
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]// return the cell so that it can be rendered
        return cell
    }
}


