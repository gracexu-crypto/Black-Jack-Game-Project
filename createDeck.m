function deck = createDeck()
    card_values = 1:13;
    suits = 4;
    deck = repmat(card_values, 1, suits);
end