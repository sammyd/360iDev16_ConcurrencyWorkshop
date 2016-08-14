//: [⬅ Chaining NSOperations](@previous)
/*:
 ## [NS]Operations in Practice
 
 You've seen how powerful `Operation` is, but not really seen it fix a real-world problem.
 
 This playground page demonstrates how you can use `Operation` to load and filter images for display in a table view, whilst maintaining the smooth scroll effect you expect from table views.
 
 This is a common problem, and comes from the fact that if you attempt expensive operations synchronously, you'll block the main queue (thread). Since this is used for rendering the UI, you cause your app to become unresponsive - temporarily freezing.
 
 The solution is to move data loading off into the background, which can be achieved easily with `Operation`.
 
 */
import UIKit
import PlaygroundSupport

let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 720))
tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
PlaygroundPage.current.liveView = tableView
tableView.rowHeight = 250


//: `ImageProvider` is a class that is responsible for loading and processing an image. It creates the relevant operations, chains them together, pops them on a queue and then ensures that the output is passed back appropriately
class ImageProvider {
  // TODO
}

//: `DataSource` is a class that represents the table's datasource and delegate
class DataSource: NSObject {
  var imageNames = [String]()
  // TODO
}

//: Possibly the simplest implementation of `UITableViewDataSource`:
// TODO

//: Create a datasource and provide a list of images to display
let ds = DataSource()
ds.imageNames = ["dark_road_small.jpg", "train_day.jpg", "train_dusk.jpg", "train_night.jpg", "dark_road_small.jpg", "train_day.jpg", "train_dusk.jpg", "train_night.jpg", "dark_road_small.jpg", "train_day.jpg", "train_dusk.jpg", "train_night.jpg", "dark_road_small.jpg", "train_day.jpg", "train_dusk.jpg", "train_night.jpg"]

// TODO

/*:
 - note:
 This implementation for a table view is not complete, but instead meant to demonstrate how you can use `NSOperation` to improve the scrolling performance.
 
 [➡ Grand Central Dispatch](@next)
 */
