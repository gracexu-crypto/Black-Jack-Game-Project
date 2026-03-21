% Shuffle the deck into a random order.
% This keeps the same cards but changes their positions.
function shuffledDeck = shuffleDeck(deck)
    num_cards = length(deck);
    shuffledDeck = deck(randperm(num_cards));
end