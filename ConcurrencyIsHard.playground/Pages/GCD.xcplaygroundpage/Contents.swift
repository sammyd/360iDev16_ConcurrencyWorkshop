//: [⬅ NSOperation in Practice](@previous)
/*:
 ## GCD Queues
 NSOperation queues are built on top of a technology called `libdispatch`, or *Grand Central Dispatch*. This is an advanced open-source technology that underpins concurrent programming on Apple technologies. It uses the now-familiar queuing model to greatly simplify concurrent programming, but is a C-level interface. This can make it slightly more challenging to work with.
 */
import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
/*:
 ### Using a Global Queue
 iOS has some global queues, where every task eventually ends up being executed. You can use these directly. You need to use the main queue for UI updates.
 */
let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
let mainQueue = DispatchQueue.main

//: ### Creating your own Queue
//: Creating your own queues allow you to specify a label, which is super-useful for debugging.
//: You can specify whether the queue is serieal (default) or concurrent (see later).
//: You can also specify the QOS or priority (here be dragons)
let attr = dispatch_queue_attr_make_with_qos_class(DispatchQueue.Attributes.serial, DispatchQoS.QoSClass.userInitiated, 0)
let workerQueue = DispatchQueue(label: "com.raywenderlich.worker", qos: attr)


//: ### Getting the queue name
//: You can't get hold of the "current queue", but you can obtain its name - useful for debugging
func currentQueueName() -> String? {
  let label = DISPATCH_CURRENT_QUEUE_LABEL.label
  return String(CString: label, encoding: String.Encoding.utf8)
}

let currentQueue = currentQueueName()
print(currentQueue)


//: ### Dispatching work asynchronously
//: Send some work off to be done, and then continue on—don't await a result
print("=== Sending asynchronously to Worker Queue ===")
workerQueue.async {
  print("=== ASYNC:: Executing on \(currentQueueName()) ===")
}
print("=== Completed sending asynchronously to worker queue ===\n")



//: ### Dispatching work synchronously
//: Send some work off and wait for it to complete before continuing (here be more dragons)
print("=== Sending SYNChronously to Worker Queue ===")
workerQueue.sync {
  print("=== SYNC:: Executing on \(currentQueueName()) ===")
}


print("=== Completed sending synchronously to worker queue ===\n")



//: ### Concurrent and serial queues
//: Serial allows one job to be worked on at a time, concurrent multitple
func doComplexWork() {
  sleep(1)
  print("\(currentQueueName()) :: Done!")
}

print("=== Starting Serial ===")
workerQueue.async(execute: doComplexWork)
workerQueue.async(execute: doComplexWork)
workerQueue.async(execute: doComplexWork)
workerQueue.async(execute: doComplexWork)

sleep(5)

let concurrentQueue = DispatchQueue(label: "com.raywenderlich.concurrent", qos: DispatchQueue.Attributes.concurrent)

print("\n=== Starting concurrent ===")
concurrentQueue.async(execute: doComplexWork)
concurrentQueue.async(execute: doComplexWork)
concurrentQueue.async(execute: doComplexWork)
concurrentQueue.async(execute: doComplexWork)

sleep(5)

XCPlaygroundPage.currentPage.finishExecution()


//: [➡ GCD Groups](@next)
