clc;
clear;

% This file handles the overall game flow from dealing to the final result.


disp('Welcome to Blackjack!')

myDeck = createDeck();
myShuffledDeck = shuffleDeck(myDeck);

[playerHand, dealerHand, nextCard] = dealCards(myShuffledDeck);

disp('Your starting hand:')
displayHand(playerHand);
fprintf('Your hand value: %d\n\n', calculateHandValue(playerHand));

[playerHand, nextCard, playerBust, playerStand] = playerTurn(myShuffledDeck, nextCard, playerHand);

if playerBust
    disp('You busted. Dealer wins.')
else
    [dealerHand, nextCard] = dealerTurn(myShuffledDeck, nextCard, dealerHand);

    disp('Final Player Hand:')
    displayHand(playerHand);
    fprintf('Player hand value: %d\n\n', calculateHandValue(playerHand));

    disp('Final Dealer Hand:')
    displayHand(dealerHand);
    fprintf('Dealer hand value: %d\n\n', calculateHandValue(dealerHand));

    result = determineWinner(playerHand, dealerHand);
    disp(result)
end