 % Create a standard 52-card deck using values 1 to 13.
% Each value appears 4 times to represent the 4 suits.

function deck = createDeck()
    card_values = 1:13;
    suits = 4;
    deck = repmat(card_values, 1, suits);
end