clc;
clear;

deck = createDeck();
assert(length(deck) == 52, 'deck should have 52 cards.')
assert(sum(deck == 1) == 4, 'should contain 4 Aces.')
disp('createDeck passed.')

shuffledDeck = shuffleDeck(deck);
assert(length(shuffledDeck) == 52, 'shuffled deck should have 52 cards.')
assert(isequal(sort(shuffledDeck), sort(deck)), ...
    'shuffled deck should contain the same cards.')
disp('shuffleDeck passed.')

[playerHand, dealerHand, nextCard] = dealCards(shuffledDeck);
assert(length(playerHand) == 2, 'player should have 2 cards.')
assert(length(dealerHand) == 2, 'dealer should have 2 cards.')
disp('dealCards passed.')

oldLength = length(playerHand);
[playerHand2, nextCard2] = hitCard(shuffledDeck, nextCard, playerHand);
assert(length(playerHand2) == oldLength + 1, 'hand size should increase by 1.')
assert(nextCard2 == nextCard + 1, 'nextCard should increase by 1.')
assert(playerHand2(end) == shuffledDeck(nextCard), 'wrong card added.')
disp('hitCard passed.')

assert(calculateHandValue([10 13]) == 20, '[10 13] should be 20.')
assert(calculateHandValue([1 13]) == 21, '[1 13] should be 21.')
assert(calculateHandValue([1 9 5]) == 15, '[1 9 5] should be 15.')
assert(calculateHandValue([1 1 9]) == 21, 'c[1 1 9] should be 21.')
disp('calculateHandValue passed.')

assert(isBust([10 9 5]) == true, '[10 9 5] should bust.')
assert(isBust([10 7]) == false, '[10 7] should not bust.')
assert(isBust([1 9]) == false, '[1 9] should not bust.')
disp('isBust passed.')

disp('All tests passed.')