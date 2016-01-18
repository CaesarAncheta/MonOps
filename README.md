# MonOps
Monitor operations in Haskell.
MonOps stands for  Monitor operations.

Overview, summary,  in-depth items, conclusion, and a list of resources for further work.

Overview

The concept is to separate exception handling from Operations. 
A Monitor oversees Operations; it forks Operations, while concentrating on its mainline process. 
If an error in Operations occurs, the monitor can be used for debugging failures.
An operation can then concentrate on performing its function. 

Monitor graphic symbol is UML State icon -- rectangle with rounded corners. As is the case for State machines, transitions from the current state to the next occur with events in the current state. Events can be OS inputs, timers, exceptions, resource limitation etc.

Operations graphic symbol is shrunken Ops.png. Depict this as ASCII art. Courier font, monospaced.

Now translate MonOps graphic to ASCII art, depicting graphic scenarios:
```
    ----------------------------------------------------------------------------------------------
    
    [tagname] denotes a monitor state
    
    [streams of development, evolution]
    |  \  /   any of these tokens denotes a code stream, each for a specific Op in that stream
    
    [Terminal nodes]
    *         process starts. Forks of new Ops are imminent.
    ...       comment, for a specific Op feature
    o         feature associated with a comment
    x         exception occurs for a specific Op in stream
    .         this. The hotspot. The 'punctum' of Barthe's Camera Lucida
    
    vertical dimension depicts the flow of time
    horizontal dimension denotes Op cases, each using some resource of the environment at some time
    
    [MonOps picture]  follows:
    ----------------------------------------------------------------------------------------------
    *         [Op0 -Mainstream Operation]
    o
    |
    |
    |
    |
    |
    |
    |
    |
    |
    o         ...base case. Return code 0. No exceptions.
    
    ----------------------------------------------------------------------------------------------
    *         [Op1 -Mainstream Operation with one fork]
    o
    |\
    | \
    |  \
    |   \
    |    \
    |     \
    |      \
    |       \
    |        \
    o         o ... Op's base case. Op returned with no exceptions.
    
    ----------------------------------------------------------------------------------------------
    *         [Op2 -Operation with one exception]
    o
    |\
    | x       ...exception occurs
    | |\
    | | \
    | |  \
    | |   \
    | |    \
    | |     \
    | |      \
    o o       .  ...Just terminate Op and start debugging.
      .       ...Exception with successful recovery.
    
    ----------------------------------------------------------------------------------------------
    *         [Op3 -Operation with multiple exceptions]
    o
    |\
    | x       ...exception occurs
    | |\
    | | x     ...exception occurs
    | | |\
    | | | x   ...exception occurs
    | | | |\
    | | | | x ...exception occurs
    | | | | |\
    o o o o o .  ...debug the nth exception.
    .         ...Mainstream operation, no recovery needed
      .       ...Operation recovered after one Op exception
        .     ...Operation recovered after two Op exceptions
            . ...Operation recovered after n exceptions
    
    ----------------------------------------------------------------------------------------------
```
MonOps -- overview of Monitor Operations. Two cases, Op0 and Op1, are depicted as exception-free.
``` 
    * ~ . -- a triad of * (a salient event) ~ (the attendant Op processing) and . (the punctum)
``` 
For Op0, Op1, the punctum is the return code of normal operation in the monitor.

But for other cases, Op2 and Op3, the punctum depicts one and multiple exceptions. Unhandled exceptions are an error, in software. In hardware, errors in processing are faults, for a specific hardware condition, or system failure, a combination of hardware fault and software error. It is the task of MonOps to reflect and depict software error, or to report failures and faults, typically in a dashboard. It is a Monitor failure to depict normal operation when a failure has in fact occurred.

Summary 

The approach is to use error as your guide to your goal.

For example, a general approach to solving any mathematical equation, "Try  numbers (--Richard Feynman)", actually uses the error in your guess to drive the next step of the process. Newton's method uses error as well.

One difficulty is that Exception handling in Haskell can be unhelpful. Exceptions can be handled as simply as the use of a

    flip
    maybe
    either
    
But the danger is ad-hoc solution to an endemic problem, hard-coded into the implementation

Ad-hoc approaches, simply addressing each error as it occurs, baking each patch into the code, makes the code brittle and resistant to change. Eventually this kind of code is simply abandoned. Domain-specific knowledge, painfully gathered at code level, gets lost when the programmer leaves.

A more formal, more uniform approach would have the benefit of extracting this kind of domain-specific knowledge.

More detail -- overview, summary,  in-depth items, conclusion, and a bibliography for further work

Control

The Continuation-Passing Style, supported on Hackage Control.Monad.Cont, provides a way for the Monitor to take control of the exception-handling process. The Call with Current Continuation, CallCC is one such function.

See nestedCallCC.hs for an example of the usage of CallCC. CallCC can be generated from its type, as demonstrated by Djinn.hs, available on GitHub. I argue that handling exceptions by Separation of Concerns makes Exception handling more scalable.

Scalability 

Although Haskell is justly respected for the simplicity of some its solutions, the additional detail needed to process exceptions harms the scalability of those solutions. Separating Exception handling away from the Operations code serves to localize the expertise needed to handle the exceptions


 
Getting Types right

We can formulate a Haskell version of Polya's method, How to Solve It

    1. Get the type right
    2. Build functions for the issues I am currently encountering
    3. Compose these functions (meaning: get the types right for the specific issue)
    4. Review 1, 2, 3: is this approach right?
    
But note the recursive nature of steps 1, 2, 3. Further 4 introduces a kind of typeclass constraint, something like Phil Freeman's HOAS, but with the 'approach' as a parameter.  If we were to further add in the cost of the approach, more intelligent development decisions could then be pursued.

For example, the Monitor consumes uniform items in its dashboard, but the items are not entirely Int, or String, to speak in concrete terms. The monitor needs to be able to identify Exception conditions to the dashboard user, as well as routine Op return codes. This matters, because the user needs to initiate debugging or Live coding to address changing conditions.

One approach could be to define ConcreteData, as either string or int. Thus the Monitor can consume a uniform type based on ConcreteData. The Monitor can thus consume a stream of Eithers.  

There is a Haskell application, Facebook's Haxl, recently  open-sourced, which consumes Typeables. Haxl  consumes Fetches and returns IDs from a database of users of interest. It operates at scale, and is over 200,000 lines of Haskell code, converted from an internal language. Haxl was able to investigate queries and to zero in on the queries which took too long (2 seconds in the long tail).

The selection of Either's Left or Right need not be restricted to String Lefts and Int Rights. The Right sides could just as well be Strings. Nested  data types could be another approach:

        Either Text Text
             Either Text Text
                  Either Text Int 

This kind of datatype allows the compilation of problems at an abstract level as well as a concrete level. It is just as likely that misconceptions and misconstruals can impede the development of a project, at the specification level, as well as at the user interface level, and implementation level. The goals in the development of a project, such as functional goals, can include getting nested data types right. This allows us to integrate the goals listed in a Github checklist form with their feasibility.

One application for MonOps could then be the development of a smart to-do list, itself deployed to a Tasker tablet or smartphone. 

Conclusion --
        Haskell can be industrial strength, operating at scale. But it takes special types of resources -- Haskell programmers. Therefore we need more of us who can use 
        this language, to actually get things done.

List of resources: Bibiliography, Source, and Notes. Included with the comments during the Git commits.
