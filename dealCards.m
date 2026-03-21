% Deal two starting cards to the player and dealer.
% nextCard tracks the position of the next card to be drawn.

function [playerHand, dealerHand, nextCard] = dealCards(shuffledDeck)
    playerHand = [shuffledDeck(1) shuffledDeck(3)];
    dealerHand = [shuffledDeck(2) shuffledDeck(4)];
    nextCard = 5;
end