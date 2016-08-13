//: [Previous](@previous)

import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true


struct Future<T> {
  typealias FutureResultHandler = (T) -> ()
  typealias AsyncOperation = (FutureResultHandler) -> ()
  
  private let asyncOperation: AsyncOperation
  
  func resolve(_ handler: FutureResultHandler) {
    asyncOperation(handler)
  }
  
  func then<U>(_ next: (input: T, callback: (U) -> ()) -> ()) -> Future<U> {
    return Future<U> { (resultHandler) in
      self.resolve { firstResult in
        next(input: firstResult) { secondResult in
          resultHandler(secondResult)
        }
      }
    }
  }
}


let queue = DispatchQueue(label: "com.razeware.sams-queue")

/* Sample Async Operations */
// Data load
func loadData(_ callback: ([Int]) -> ()) {
  queue.async {
    usleep(500_000)
    callback(Array(1...10))
  }
}


// Image load
func loadImages(_ input: [Int], callback: ([String]) -> ()) {
  queue.async {
    usleep(500_000)
    callback(input.map { String(repeating: Character("🐠") , count: $0) })
  }
}


// Image Processing
func processImage(_ input: [String], callback: ([String]) -> ()) {
  queue.async {
    usleep(500_000)
    callback(input.map { $0.replacingOccurrences(of: "🐠🐠🐠🐠", with: "🐙") } )
  }
}

/* Without promises */

loadData { (data) in
  loadImages(data, callback: { (images) in
    processImage(images, callback: { (result) in
      DispatchQueue.main.async {
        print("This is your processed data:")
        for value in result {
          print(value)
        }
      }
    })
  })
}


/* With "futures" */
Future(asyncOperation: loadData)
  .then(loadImages)
  .then(processImage)
  .resolve { results in
    DispatchQueue.main.async {
      print(results)
      PlaygroundPage.current.finishExecution()
    }
  }




//: [Next](@next)
