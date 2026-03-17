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

function [playerHand, dealerHand, nextCard] = dealCards(shuffledDeck)
    % Deal two cards each to player and dealer
    playerHand = [shuffledDeck(1) shuffledDeck(3)];
    dealerHand = [shuffledDeck(2) shuffledDeck(4)];

    % Track the next card position
    nextCard = 5;
end

function [hand, nextCard] = hitCard(shuffledDeck, nextCard, hand)
    % Deal one additional card
    hand(end+1) = shuffledDeck(nextCard);
    nextCard = nextCard + 1;
end

[playerHand, dealerHand, nextCard] = dealCards(myShuffledDeck);

disp('Player Hand:')
disp(playerHand)

disp('Dealer Hand:')
disp(dealerHand)

[playerHand, nextCard] = hitCard(myShuffledDeck, nextCard, playerHand);

disp('Player Hand After Hit:')
disp(playerHand)
