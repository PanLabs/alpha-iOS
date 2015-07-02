//
//  DirectoryListTableViewController.swift
//  alpha
//
//  Created by Corey Howell on 6/29/15.
//  Copyright (c) 2015 Corey Howell. All rights reserved.
//

import UIKit
import RebekkaTouch

var _session: Session!

class DirectoryListTableViewController: UITableViewController {
    
    var resourceItems: [ResourceItem] = []
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        println("Unwinding")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var configuration = SessionConfiguration()
        //configuration.host = "ftp://ftp.mozilla.org:21"
        configuration.host = "ftp://ftp.rollsoft.net:21"
        configuration.username = "rollsoft"
        configuration.password = "Punkinpi3"
        configuration.encoding = NSUTF8StringEncoding
        _session = Session(configuration: configuration)
        _session.list("public_html") {
            (resources, error) -> Void in
            self.resourceItems = resources!
            self.tableRefresh()
            println(self.resourceItems)
            println("List directory with result:\n\(resources!), error: \(error)\n\n")
        }
//
//        let path = "ohHi"
//        let filePath = "/Users/chowell/Library/Developer/CoreSimulator/Devices/F3682A11-B8C2-419E-847C-03AD0A470251/data/Containers/Data/Application/09ADB12E-17C5-4FDB-90CD-2E0D1695560E/Documents/SaveFile.png"
//        let URL = NSURL(string: filePath)
//        _session.upload(URL!, path: path) {
//            (result, error) -> Void in
//            println("Upload file with result:\n\(result), error: \(error)\n\n")
//        }
        
//        if let URL = NSBundle.mainBundle().URLForResource("testUpload", withExtension: "png") {
//            let path = "ohHi"
//            _session.upload(URL, path: path) {
//                (result, error) -> Void in
//                println("Upload file with result:\n\(result), error: \(error)\n\n")
//            }
//        }
        
        //loadInitialData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func tableRefresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return resourceItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tempCell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell") as! UITableViewCell
        let resourceItem = resourceItems[indexPath.row]

        // Downcast from UILabel? to UILabel
        let cell = tempCell.textLabel as UILabel!
        cell.text = resourceItem.name
        
        return tempCell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
