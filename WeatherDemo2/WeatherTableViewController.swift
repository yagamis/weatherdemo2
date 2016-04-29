//
//  WeatherTableViewController.swift
//  WeatherDemo2
//
//  Created by 小波 on 16/4/29.
//  Copyright © 2016年 xiaobo. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var sectionTitles = ["","一周天气预报","天气简报","其他数据"]
    
    var results: [Result] = []
    var result: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let cellnib = UINib(nibName: "HeaderCell", bundle: nil)
        tableView.registerNib(cellnib, forCellReuseIdentifier: "headerCell")
        
        let weeknib = UINib(nibName: "WeekCell", bundle: nil)
        tableView.registerNib(weeknib, forCellReuseIdentifier: "weekCell")
        
        
        let briefnib = UINib(nibName: "BriefCell", bundle: nil)
        tableView.registerNib(briefnib, forCellReuseIdentifier: "briefCell")
        
        let attachnib = UINib(nibName: "AttachCell", bundle: nil)
        tableView.registerNib(attachnib, forCellReuseIdentifier: "attachCell")
        
        
        //北京的天气周报
        let weeklyWeatherBJ = NetworkHelper.WeeklyWeather(cityid: "1")
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        weeklyWeatherBJ.getWeather { (results, error) in
            if let results = results {
                self.results = results
                self.result.append(results.first!)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.tableView.reloadData()
                })
                
            } else {
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    let alertVC = UIAlertController(title: "网络错误", message: error!, preferredStyle: .Alert)
                    let action = UIAlertAction(title: "好", style: .Default, handler: nil)
                    alertVC.addAction(action)
                    self.presentViewController(alertVC, animated: true, completion: nil)
                })
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
   

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch  section {
        case 1:
            return results.count
        default:
            return result.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 3:
            return 88
        default:
            return 44
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellID = ""
        let weather = result[0]
        
        switch indexPath.section {
        case 0:
            cellID = "headerCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! HeaderCell
            cell.labelCity.text = weather.citynm
            cell.labelTemp.text = weather.tempHigh + "°"
            cell.labelWeather.text = weather.weather
            
            return cell
        case 1:
            cellID = "weekCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! WeekCell
            let  result = results[indexPath.row]
            
            if indexPath.row == 0 {
                cell.labelToday.text = "今天"
            } else {
                cell.labelToday.text = "  "
            }
            
            cell.labelWeek.text = result.week
            
            let data = NSData(contentsOfURL: NSURL(string: result.weatherIcon)!)!
            cell.imgWeatherIcon.image = UIImage(data: data)
            
            cell.labelHighTemp.text = result.tempHigh
            cell.labelLowTemp.text = result.tempLow

            return cell
        case 2:
            cellID = "briefCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BriefCell
            cell.labelBrief.text = "\(weather.weather)。最高温：\(weather.tempHigh)，最低温\(weather.tempLow)。"
            
            return cell
        case 3:
            cellID = "attachCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! AttachCell
            cell.labelWind.text = weather.wind
            cell.labelHumid.text = weather.humidity
            
            return cell
            
        default:
            return UITableViewCell(frame: CGRectZero)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
