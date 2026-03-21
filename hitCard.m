function [hand, nextCard] = hitCard(shuffledDeck, nextCard, hand)
    hand(end+1) = shuffledDeck(nextCard);
    nextCard = nextCard + 1;
end