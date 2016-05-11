//
//  TagsColorsTableViewController.swift
//  PhotoTagger
//
//  Created by Mohaiminul Islam on 5/11/16.
//  Copyright © 2016 InfancyIT LLC. All rights reserved.
//

import UIKit

struct TagsColorTableData {
  var label: String
  var color: UIColor?
}

class TagsColorsTableViewController: UITableViewController {

  // MARK: - Properties
  var data: [TagsColorTableData]?

  // MARK: - UITableViewDataSource
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let data = data else {
      return 0
    }

    return data.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let data = data else {
      fatalError("Application error no cell data available")
    }
    
    let cellData = data[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier("TagOrColorCell", forIndexPath: indexPath)
    cell.textLabel?.text = cellData.label
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    guard let data = data else {
      fatalError("Application error no cell data available")
    }

    let cellData = data[indexPath.row]
    guard let color = cellData.color else {
      cell.textLabel?.textColor = UIColor.blackColor()
      cell.backgroundColor = UIColor.whiteColor()
      return
    }
    
    var red = CGFloat(0.0), green = CGFloat(0.0), blue = CGFloat(0.0), alpha = CGFloat(0.0)
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    let threshold = CGFloat(105)
    let bgDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
    
    let textColor = (255 - bgDelta < threshold) ? UIColor.blackColor() : UIColor.whiteColor();
    cell.textLabel?.textColor = textColor
    cell.backgroundColor = color
  }
}
