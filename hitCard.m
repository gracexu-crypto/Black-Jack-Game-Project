% Add one card to the current hand.
% Then move nextCard to the following position in the deck.
function [hand, nextCard] = hitCard(shuffledDeck, nextCard, hand)
    hand(end+1) = shuffledDeck(nextCard);
    nextCard = nextCard + 1;
end