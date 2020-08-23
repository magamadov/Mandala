//
//  ViewController.swift
//  Mandala
//
//  Created by ZELIMKHAN MAGAMADOV on 13.08.2020.
//

import UIKit

class MoodSelectionViewController: UIViewController {

  @IBOutlet var moodSelector: ImageSelector!
  @IBOutlet var addMoodButton: UIButton!
  
  var moodsConfigurable: MoodsConfigurable!
  
  var moods: [Mood] = [] {
    didSet {
      currentMood = moods.first
      moodSelector.images = moods.map { $0.image }
      moodSelector.highLightsColor = moods.map { $0.color }
    }
  }
  
  var currentMood: Mood? {
    didSet {
      guard let currentMood = currentMood else {
        addMoodButton.setTitle("Нету муда", for: .normal)
        addMoodButton.backgroundColor = nil
        return
      }
      addMoodButton.setTitle(currentMood.name, for: .normal)
      let selectionAnimator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.6) {
        self.addMoodButton.backgroundColor = currentMood.color
      }
      selectionAnimator.startAnimation()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    moods = [.angry, .confused, .crying, .goofy, .happy, .meh, .sad, .sleepy]
    addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
      case "embedContainerViewController":
        guard let moodsConfigurable = segue.destination as? MoodListViewController else {
          preconditionFailure("View controller expected to conform to MoodsConfigurable")
        }
        segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        self.moodsConfigurable = moodsConfigurable
      default:
        preconditionFailure("Unexpected segue identifier")
    }
  }
  
  @IBAction func addMoodTapped(_ sender: Any) {
    guard let currentMood = currentMood else {
      return
    }
    let newMoodEntry = MoodEntry(mood: currentMood, timeStamp: Date())
    moodsConfigurable.add(newMoodEntry)
  }
  
  @IBAction private func moodSelectionChanged(_ sender: ImageSelector) {
    let selectedIndex = sender.selectedIndex
    currentMood = moods[selectedIndex]
  }
}

