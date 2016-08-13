//: [Previous](@previous)

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/* Thing I want to be able to do:
 - Create a new promise from a closure
 - Chain promises with .then(), passing in another closure
 - Create a promise that always resolves to an error, or a value
 - Handle the onValue / onError
 */


import Foundation

enum Result<T, E: Error> {
  case success(T)
  case error(E)
}


struct Promise<T, E: Error> {
  typealias PromiseResult = Result<T, E>
  typealias PromiseResultHandler = (PromiseResult) -> ()
  typealias AsyncOperation = (PromiseResultHandler) -> ()
  
  private let asyncOperation: AsyncOperation
  
  func resolve(handler: PromiseResultHandler) {
    asyncOperation(handler)
  }
  
  func then<U>(_ next: (T) -> (U)) -> Promise<U, E> {
    return Promise<U, E> { (resultHandler) in
      self.resolve { firstResult in
        switch firstResult {
        case .success(let value): resultHandler(.success(next(value)))
        case .error(let error): resultHandler(.error(error))
        }
      }
    }
  }
  
  func then<U>(_ next: (Result<T, E>) -> (Result<U, E>)) -> Promise<U, E> {
    return Promise<U, E> { (resultHandler) in
      self.resolve { firstResult in
        resultHandler(next(firstResult))
      }
    }
  }
  
  func then<U>(_ next: (T) -> (Result<U, E>)) -> Promise<U, E> {
    return Promise<U, E> { (resultHandler) in
      self.resolve { firstResult in
        switch firstResult {
        case .success(let value): resultHandler(next(value))
        case .error(let error): resultHandler(.error(error))
        }
      }
    }
  }
}

enum NoError: Error { }


struct Future<T> {
  typealias FutureResultHandler = (T) -> ()
  typealias AsyncOperation = (FutureResultHandler) -> ()
  
  private let asyncOperation: AsyncOperation
  
  func resolve(handler: FutureResultHandler) {
    asyncOperation(handler)
  }
  
  func then<U>(_ next: (T) -> (U)) -> Future<U> {
    return Future<U> { (resultHandler) in
      self.resolve { firstResult in
        resultHandler(next(firstResult))
      }
    }
  }
  
  func then<U>(_ next: (T, (U) -> ()) -> ()) -> Future<U> {
    return Future<U> { (resultHandler) in
      self.resolve { firstResult in
        next(firstResult) { secondResult in
          resultHandler(secondResult)
        }
      }
    }
  }
}








let queue = DispatchQueue(label: "com.razeware.sams-queue")

/* Sample Async Operations */
// Data load
func loadData(callback: ([Int]) -> ()) {
  queue.async {
    usleep(500_000)
    callback(Array(1...10))
  }
}


// Image load
func loadImages(data: [Int], callback: ([String]) -> ()) {
  queue.async {
    usleep(500_000)
    callback(data.map { String(repeating: Character("🐠") , count: $0) })
  }
}


// Image Processing
func processImage(images: [String], callback: ([String]) -> ()) {
  queue.async {
    usleep(500_000)
    callback(images.map { $0.replacingOccurrences(of: "🐠🐠🐠🐠", with: "🐙") } )
  }
}

/* Without promises */

loadData { (data) in
  loadImages(data: data, callback: { (images) in
    processImage(images: images, callback: { (result) in
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
Future { (resultHandler) in
  loadData(callback: resultHandler)
}
  .then { (data, resultHandler) in
  loadImages(data: data, callback: resultHandler)
}
  .then { (images, resultHandler) in
processImage(images: images, callback: resultHandler)
}
  .then { (processedImages, _) in
    DispatchQueue.main.async {
      print(processedImages)
      PlaygroundPage.current.finishExecution()
    }
}







//: [Next](@next)
