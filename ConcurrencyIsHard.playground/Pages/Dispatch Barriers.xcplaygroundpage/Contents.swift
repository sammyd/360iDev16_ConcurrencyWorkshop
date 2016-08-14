//: [⬅ GCD Groups](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//: ## GCD Barriers
//: When you're using asynchronous calls you need to consider thread safety.
//: Consider the following object:

let nameChangingPerson = Person(firstName: "Alison", lastName: "Anderson")

//: The `Person` class includes a method to change names:

// TODO

//: What happens if you try and use the `changeName(firstName:lastName:)` simulataneously from a concurrent queue?

// TODO

let nameList = [("Charlie", "Cheesecake"), ("Delia", "Dingle"), ("Eva", "Evershed"), ("Freddie", "Frost"), ("Gina", "Gregory")]

// TODO

//: __Result:__ `nameChangingPerson` has been left in an inconsistent state.


//: ### Dispatch Barrier
//: A barrier allows you add a task to a concurrent queue that will be run in a serial fashion. i.e. it will wait for the currently queued tasks to complete, and prevent any new ones starting.

// TODO


print("\n=== Threadsafe ===")

let threadSafeNameGroup = DispatchGroup()

// TODO
//: [➡ Futures](@next)
