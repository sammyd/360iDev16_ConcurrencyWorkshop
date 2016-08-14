//: [⬅ Grand Central Dispatch](@previous)
/*:
 ## Dispatch Groups
 
 Dispatch groups are a feature of GCD that allow you to perform an action when a group of GCD operations has completed. This offers a really simple way to keep track of the progress of a set of operations, rather than having to implement something to keep track yourself.
 
 When you're responsible for dispatching blocks yourself, it's really easy to disptach a block into a particular dispatch group, using the `dispatch_group_*()` family of functions, but the real power comes from being able to wrap existing async functions in dispatch groups.
 
 In this demo you'll see how you can use dispatch groups to run an action when a set of disparate animations has completed.
 */
import UIKit
import PlaygroundSupport

//: Create a new animation function on `UIView` that wraps an existing animation function, but now takes a dispatch group as well.
// TODO

//: Create a disptach group with `dispatch_group_create()`:
// TODO

//: The animation uses the following views
// TODO

//: The following completely independent animations now use the dispatch group so that you can determine when all of the animations have completed:

// TODO


//: `dispatch_group_notify()` allows you to specify a block that will be executed only when all the blocks in that dispatch group have completed:
// TODO

//: [➡ Thread safety with GCD Barriers](@next)
