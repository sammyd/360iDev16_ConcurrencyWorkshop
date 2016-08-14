//: [⬅ NSOperation in Practice](@previous)
/*:
 ## GCD Queues
 [NS]Operation queues are built on top of a technology called `libdispatch`, or *Grand Central Dispatch*. This is an advanced open-source technology that underpins concurrent programming on Apple technologies. It uses the now-familiar queuing model to greatly simplify concurrent programming, up until recently via a C-level interface. However, Swift 3 has greatly improved the GCD API, so it's no longer nearly as challenging.
 */
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ### Using a Global Queue
 iOS has some global queues, where every task eventually ends up being executed. You can use these directly. You need to use the main queue for UI updates.
 */
// TODO

//: ### Creating your own Queue
//: Creating your own queues allow you to specify a label, which is super-useful for debugging.
//: You can specify whether the queue is serial (default) or concurrent (see later).
//: You can also specify the QOS or priority (here be dragons)
// TODO

//: ### Getting the queue name
//: You can't get hold of the "current queue", but you can obtain its name - useful for debugging
func currentQueueName() -> String {
  let label = __dispatch_queue_get_label(.none)
  return String(cString: label)
}


let currentQueue = currentQueueName()
print(currentQueue)


//: ### Dispatching work asynchronously
//: Send some work off to be done, and then continue on—don't await a result
print("=== Sending asynchronously to Worker Queue ===")
// TODO
print("=== Completed sending asynchronously to worker queue ===\n")



//: ### Dispatching work synchronously
//: Send some work off and wait for it to complete before continuing (here be more dragons)
print("=== Sending SYNChronously to Worker Queue ===")
// TODO
print("=== Completed sending synchronously to worker queue ===\n")



//: ### Concurrent and serial queues
//: Serial allows one job to be worked on at a time, concurrent multitple
func doComplexWork() {
  sleep(1)
  print("\(currentQueueName()) :: Done!")
}

print("=== Starting Serial ===")
// TODO

sleep(5)

// TODO


sleep(5)

PlaygroundPage.current.finishExecution()


//: [➡ GCD Groups](@next)
