//
//  MoodListViewController.swift
//  Mandala
//
//  Created by ZELIMKHAN MAGAMADOV on 15.08.2020.
//

import UIKit

class MoodListViewController: UITableViewController {
  
  var moodEntries: [MoodEntry] = []
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    moodEntries.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let moodEntry = moodEntries[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    cell.imageView?.image = moodEntry.mood.image
    cell.textLabel?.text = moodEntry.mood.name
    let dateString = DateFormatter.localizedString(from: moodEntry.timeStamp, dateStyle: .medium, timeStyle: .short)
    cell.detailTextLabel?.text = dateString
    return cell
  }
}

extension MoodListViewController: MoodsConfigurable {
  func add(_ moodEntry: MoodEntry) {
    moodEntries.insert(moodEntry, at: 0)
    tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
  }
}
