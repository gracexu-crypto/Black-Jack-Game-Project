function deck = createDeck()
    % Create a standard 52-card deck matrix (4 suits, values 1-13)
    % 1 = Ace, 11 = Jack, 12 = Queen, 13 = King
    card_values = 1:13;
    suits = 4;
    deck = repmat(card_values, 1, suits);
end

function shuffledDeck = shuffleDeck(deck)
    % Randomize the order of the deck array using randperm
    num_cards = length(deck);
    shuffledDeck = deck(randperm(num_cards));
end

% test the function
myDeck = createDeck();
myShuffledDeck = shuffleDeck(myDeck);
disp(myShuffledDeck);