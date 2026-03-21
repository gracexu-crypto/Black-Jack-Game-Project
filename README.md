# Black-Jack-Game-Project

## Project description
For our team project, we created a playable Blackjack game with MATLAB.

The program creates a deck of cards, shuffles it, deals cards to the player and dealer, lets the player choose to hit or stand, applies the dealer rules, calculates hand values, and determines the final result.

We displayed the game directly in the MATLAB Command Window so the player can follow each step of the round.

## Getting Started
  
First, clone the project into MATLAB using:
```
git clone https://github.com/gracexu-crypto/Black-Jack-Game-Project
```

To play the game, run:
```
main
```

To run the tests, use:
```
test
```

## Program Output

**Game Example**
![Blackjack game example](images/blackjack_example.png)

**Test Results**
![Test result](images/test_result.png)

## Challenges and Solutions

### Grace:

Implementing `playerTurn` was the biggest challenge for me in this project. At the beginning, it seemed like I only needed to ask the player to type `hit` or `stand`, but once I started writing the loop, I realized there were several cases to handle at the same time. The program needed to keep asking for input, update the hand after each hit, stop immediately if the player busted, and also reject invalid input without breaking the game flow.  
  
I solved this by using two boolean variables, `playerBust` and `playerStand`, to control the loop clearly. That made it easier for me to separate the different stopping conditions and keep the logic readable. 

Another challenge appeared near the end of the project. We found that keeping both the real Blackjack game and all the test cases in `blackjack.m` made the workflow feel a little weird, since the game would run first and only then the tests would start.

At first, I thought reorganizing the file structure would be simple and that I only needed to split the helper functions into separate files. But once I did that, the project suddenly started breaking in different places and would not run correctly. 

The issue was that once the helper functions were separated, I had to be much more careful about how they called each other. For example, `playerTurn` depends on `hitCard`, `displayHand`, `calculateHandValue`, and `isBust`, so even a small mismatch in function behavior could cause the whole turn logic to fail.

I fixed this by going back through the functions one by one and checking their inputs, outputs, and roles in the overall game flow. I made sure each helper function had a clear purpose, returned exactly the values the next function needed, and interacted cleanly with the rest of the program. 

In general, my biggest takeaway from this project was that I found implementing the functionality of a single function is usually not the hardest part. The real challenge is making multiple functions interact correctly and fit together into one complete program.This is a point that requires even more attention.

### Danielle:
