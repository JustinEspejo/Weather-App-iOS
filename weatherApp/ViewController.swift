//
//  ViewController.swift
//  weatherApp
//
//  Created by Justin Espejo on 10/10/15.
//  Copyright © 2015 Snowcialite. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    
    @IBAction func getDataButton(sender: AnyObject) {
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(cityNameTextField)")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=newyork&APPID68ac93f60dce530a6e77df48ef4f4d69")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData(urlString: String) {
        let url = NSURL(string: urlString)
        print("url: \(url)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){ (data, response, error) in
            dispatch_async(dispatch_get_main_queue(),{
                self.setLabels(data!)
            })
        }
        task.resume()
    }
    
    func setLabels (weatherData: NSData) {
        var jsonError: NSError?
        
        var json = NSDictionary()
        
        do
        {
          json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: []) as! [String:AnyObject]
        }
        catch
        {
            
        }
        
        if let name = json ["name"] as? String {
            cityNameLabel.text = name
//        }

        if let main =  json["main"] as? NSDictionary {
            if let temp = main ["temp"] as? Double {
                cityNameLabel.text = String (format: "%.1f", temp)
            }
//        do
//        {
//         let anyObj = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
//                // use anyObj here
//        }
//            catch let error as NSError {
//                print("json error: \(error.localizedDescription)")
//        }
//        do  {
//            let json = NSJSONSerialization.JSONObjectWithData(weatherData, options: nil)// NSJSONSerialization.JSONObjectWithData(weatherData, options: nil, error: jsonError) as NSDictionary
//        
//        if let name = json ["name"] as? String {
//            cityNameLabel.text = name
////        }
//        
//        if let main =  json["main"] as? NSDictionary {
//            if let temp = main ["temp"] as? Double {
//                cityNameLabel.text = String (format: "%.1f", temp)
//            }
        

        }
    }
}
}

