//CREATE STRUCT

struct RecipeStep: CustomStringConvertible {
    var recipeName: String
    var duration: Int
    var timeToStart: Int
    var attentionRequired: Bool
    
    var description: String {
        return "Start: \(timeToStart), Duration: \(duration), Attention Needed: \(attentionRequired), Recipe: \(recipeName)\n"
    }
    
}

//INITIALIZE OBJECTS

//same start, different attention --> pick false
let potatoes1 = RecipeStep(recipeName: "potatoes", duration: 10, timeToStart: -100, attentionRequired: false)
let chicken1 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -100, attentionRequired: true)

//same start, same attention = true --> pick shorter duration, add duration to total time
let potatoes2 = RecipeStep(recipeName: "potatoes", duration: 5, timeToStart: -80, attentionRequired: true)
let chicken2 = RecipeStep(recipeName: "chicken", duration: 10, timeToStart: -80, attentionRequired: true)

//TODO same start, same attention = false --> pick shorter duration, add duration to total time

//overlap duration, 1st attentionNeeded = false --> do first, then second
let potatoes3 = RecipeStep(recipeName: "potatoes", duration: 10, timeToStart: -50, attentionRequired: false)
let chicken3 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -45, attentionRequired: true)

//overlap duration, 1st attentionNeeded = true and 2nd = false --> do second, then first
let potatoes4 = RecipeStep(recipeName: "potatoes", duration: 10, timeToStart: -35, attentionRequired: true)
let chicken4 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -30, attentionRequired: false)

//overlap duration, both attentionNeeded = same --> sort normally, add additional time to total time. [Additional time = (1st timeToStart + 1st duration) - 2nd timeToStart]
let potatoes5 = RecipeStep(recipeName: "potatoes", duration: 15, timeToStart: -20, attentionRequired: true)
let chicken5 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -15, attentionRequired: true)

//diferent starts, non-overlapping durations --> sort normally by timeToStart
let chicken6 = RecipeStep(recipeName: "chicken", duration: 10, timeToStart: -10, attentionRequired: true)
let potatoes6 = RecipeStep(recipeName: "potatoes", duration: 5, timeToStart: -5, attentionRequired: true)



//SORT STEPS

var steps = [chicken1, chicken2, chicken3, chicken4, chicken5, chicken6, potatoes1, potatoes2, potatoes3, potatoes4, potatoes5, potatoes6]

var steps2 = [chicken1, potatoes1, chicken2, potatoes2, chicken3, potatoes3, chicken4, potatoes4, chicken5, potatoes5, chicken6, potatoes6]

var addedTime = Int()


func sortSteps() {
    steps = steps.sorted { (step1: RecipeStep, step2: RecipeStep) -> Bool in
        
        //same start
        if step1.timeToStart == step2.timeToStart {
            if step1.attentionRequired == false && step2.attentionRequired == true {
                return true
            } else if step1.attentionRequired == true && step2.attentionRequired == false {
                return false
                
            } else if step1.attentionRequired == step2.attentionRequired {
                if step1.duration > step2.duration {
                    return false
                } else if step1.duration < step2.duration {
                    return true
                }
            }
        }
        
        //overlap duration
        if (step2.timeToStart > step1.timeToStart) && (step2.timeToStart < (step1.timeToStart + step1.duration)) {

            if step1.attentionRequired == false && step2.attentionRequired == true {
                return true
            } else if step1.attentionRequired == true && step2.attentionRequired == false {
                return false
            } else if step1.attentionRequired == step2.attentionRequired {
                addedTime = step1.timeToStart + step1.duration - step2.timeToStart
                return true
            }
        }
        
        return step1.timeToStart < step2.timeToStart
    }
    
    print(addedTime)
    print(steps)
}

sortSteps()

/* RESULTS SHOULD BE:
 
 [Start: -100, Duration: 10, Attention Needed: false, Recipe: potatoes
 , Start: -100, Duration: 5, Attention Needed: true, Recipe: chicken
 , Start: -80, Duration: 5, Attention Needed: true, Recipe: potatoes
 , Start: -80, Duration: 10, Attention Needed: true, Recipe: chicken
 , Start: -50, Duration: 10, Attention Needed: false, Recipe: potatoes
 , Start: -45, Duration: 5, Attention Needed: true, Recipe: chicken
 , Start: -30, Duration: 5, Attention Needed: false, Recipe: chicken
 , Start: -35, Duration: 10, Attention Needed: true, Recipe: potatoes
 , Start: -20, Duration: 15, Attention Needed: true, Recipe: potatoes
 , Start: -15, Duration: 5, Attention Needed: true, Recipe: chicken
 , Start: -10, Duration: 10, Attention Needed: true, Recipe: chicken
 , Start: -5, Duration: 5, Attention Needed: true, Recipe: potatoes
 ]

 */


//account for interruptible tasks happening at/during start time unmoveable tasks (ex: cutting chicken is interruptible, in the middle of it you need to put pie in the oven, which is unmovebale because must be ready at 7pm) assume all tasks are interruptible.

//if full attention not required and moveable, move it! defer to giving user one task at a time without interruptions.


