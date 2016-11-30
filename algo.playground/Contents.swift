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

//same start, different attention --> do false first
let potatoes1 = RecipeStep(recipeName: "potatoes", duration: 10, timeToStart: -100, attentionRequired: false)
let chicken1 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -100, attentionRequired: true)

//same start, same attention --> do shorter duration first, add shorter duration to total time
//addedTime = 5
let potatoes2 = RecipeStep(recipeName: "potatoes", duration: 5, timeToStart: -80, attentionRequired: true)
let chicken2 = RecipeStep(recipeName: "chicken", duration: 10, timeToStart: -80, attentionRequired: true)

//overlap duration, 1st attentionNeeded = false --> keep order, 2nd doesn't move, but adding up duration of all steps is now shorter due to overlap, so subtract overlapping time from total time.
//addedTime = (start2nd) - ((start1st + duration); ex: -45 - (-50 + 10) = -5
//addedTime = -5
let potatoes3 = RecipeStep(recipeName: "potatoes", duration: 10, timeToStart: -50, attentionRequired: false)
let chicken3 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -45, attentionRequired: true)

//overlap duration, 1st attention = true & 2nd = false --> complete entire 1st, so 2nd starts late/add extra time (extra: adjust start time value for display)
//addedTime = endTime1st(ie start + duration) - startTime2nd; ex. (-35 + 10) - -30 = 5 extra minutes
//addedTime = 5
let potatoes4 = RecipeStep(recipeName: "potatoes", duration: 10, timeToStart: -35, attentionRequired: true)
let chicken4 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -30, attentionRequired: false)

//overlap duration, both attentionNeeded = same --> sort normally, add additional time to total time. [Additional time = (1st timeToStart + 1st duration) - 2nd timeToStart]
//addedTime = 5
let potatoes5 = RecipeStep(recipeName: "potatoes", duration: 10, timeToStart: -20, attentionRequired: true)
let chicken5 = RecipeStep(recipeName: "chicken", duration: 5, timeToStart: -15, attentionRequired: true)

//diferent starts, non-overlapping durations --> sort normally by timeToStart
let chicken6 = RecipeStep(recipeName: "chicken", duration: 2, timeToStart: -10, attentionRequired: true)
let potatoes6 = RecipeStep(recipeName: "potatoes", duration: 3, timeToStart: -5, attentionRequired: true)



//SORT STEPS

var steps = [chicken1, chicken2, chicken3, chicken4, chicken5, chicken6, potatoes1, potatoes2, potatoes3, potatoes4, potatoes5, potatoes6]

var steps2 = [chicken1, potatoes1, chicken2, potatoes2, chicken3, potatoes3, chicken4, potatoes4, chicken5, potatoes5, chicken6, potatoes6]


func sortSteps() -> [RecipeStep] {
    var addedTime = 0
    
    steps = steps.sorted { (step1: RecipeStep, step2: RecipeStep) -> Bool in
        
        //same start
        if step1.timeToStart == step2.timeToStart {
            
            //different attentionNeeded
            if step1.attentionRequired == false && step2.attentionRequired == true {
                return true
            } else if step1.attentionRequired == true && step2.attentionRequired == false {
                addedTime += step1.timeToStart + step1.duration - step2.timeToStart
                print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                return false
            
            //same attentionNeeded, add shorter duration to addedTime
            } else if step1.attentionRequired == step2.attentionRequired {
                if step1.duration > step2.duration {
                    addedTime += step2.duration
                    print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return false
                } else if step1.duration < step2.duration {
                    addedTime += step1.duration
                    print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                    return true
                }
            }
        }
        
        //overlap duration
        if (step2.timeToStart > step1.timeToStart) && (step2.timeToStart < (step1.timeToStart + step1.duration)) {

            if step1.attentionRequired == false && step2.attentionRequired == true {
                addedTime += step2.timeToStart - (step1.timeToStart + step1.duration)
                print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                return true
                
            } else if step1.attentionRequired == true && step2.attentionRequired == false {
                addedTime += (step1.timeToStart + step1.duration) - step2.timeToStart
                print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                return true
                
            } else if step1.attentionRequired == step2.attentionRequired {
                addedTime += (step1.timeToStart + step1.duration) - step2.timeToStart
                print("\(addedTime): step1 = \(step1.timeToStart); step2 = \(step2.timeToStart)")
                return true
            }
        }
        
        return step1.timeToStart < step2.timeToStart
    }
    
    print(addedTime)
    print(steps)
    return(steps)
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




//if overlapping and not attention needed goes first, subtract overlapping time from total time. (ex: oven, chopping early, subtract start time from second from end time first)

//if overlapping and first item requires attention & second time doesn't, keep order, add extra time -- even if this is unmoveable task!!


