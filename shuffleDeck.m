function shuffledDeck = shuffleDeck(deck)
    num_cards = length(deck);
    shuffledDeck = deck(randperm(num_cards));
end