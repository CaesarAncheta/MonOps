# MonOps
Monitor operations in Haskell
MonOps -- Monitor operations.

Monitor graphic symbol is UML State icon -- rectangle with rounded corners.

Operations graphic symbol is shrunken Ops.png. Depict this as ASCII art. Courier font, monospaced.

Now translate MonOps graphic to ASCII art.
```
    vertical dimension is time
    horizontal dimension denote Op cases, each using some resource of the environment
    --
    [tagname] denotes a monitor state
    [MonOps picture]  follows:
    ---
    [streams of development, evolution]
    |  \  /   any of these tokens denote a code stream, each for a specific Op in stream
          [Terminal nodes]
    *         process starts. Forks of new Ops are imminent.
    ...       comment, for a specific Op feature
    o         feature associated with a comment
    x         exception occurs for a specific Op in stream
    .         this. The hotspot. The 'punctum' of Barthe's Camera Lucida
    ---
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
    ---
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
    ---
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
    --
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
```
---- overview, summary,  in-depth items, conclusion, and a bibliography for further work
MonOps -- overview of Monitor Operations
 
              * ~ . -- a triad
 
Summary -- use error as your guide to your goal
              Try numbers

More detail --
 
Conclusion --
        hs is industrial strength
        we need more of us
