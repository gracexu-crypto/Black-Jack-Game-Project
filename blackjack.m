clc;
clear;


disp('Welcome to Blackjack!')

% Create and shuffle deck
myDeck = createDeck();
myShuffledDeck = shuffleDeck(myDeck);

% Deal initial cards
[playerHand, dealerHand, nextCard] = dealCards(myShuffledDeck);

% Show initial hands
disp('Your starting hand:')
displayHand(playerHand);
fprintf('Your hand value: %d\n\n', calculateHandValue(playerHand));

% show dealer's first card
disp('Dealer shows:')
displayHand(dealerHand(1));
fprintf('\n');

% check for Blackjack at the start
playerValue = calculateHandValue(playerHand);
dealerValue = calculateHandValue(dealerHand);

if playerValue == 21 && dealerValue == 21
    disp('Both player and dealer has Blackjack! It is a tie.')
    return
elseif playerValue == 21
    disp('Blackjack! You win!')
    return
elseif dealerValue == 21
    disp('Dealer has Blackjack. Dealer wins.')
    return
end

fprint('\n');

% Player turn
[playerHand, nextCard, playerBust, playerStand] = playerTurn(myShuffledDeck, nextCard, playerHand);


if playerBust
    disp('You busted. Dealer wins.')
else
    [dealerHand, nextCard] = dealerTurn(myShuffledDeck, nextCard, dealerHand);

    % Show final hands
    disp('Final Player Hand:')
    displayHand(playerHand);
    fprintf('Player hand value: %d\n\n', calculateHandValue(playerHand));

    disp('Final Dealer Hand:')
    displayHand(dealerHand);
    fprintf('Dealer hand value: %d\n\n', calculateHandValue(dealerHand));

    % Determine winner
    result = determineWinner(playerHand, dealerHand);
    disp(result)
end

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

function [playerHand, dealerHand, nextCard] = dealCards(shuffledDeck)
    % Deal two cards each to player and dealer
    playerHand = [shuffledDeck(1) shuffledDeck(3)];
    dealerHand = [shuffledDeck(2) shuffledDeck(4)];

    % Track the next card position
    nextCard = 5;
end

function [hand, nextCard] = hitCard(shuffledDeck, nextCard, hand)
   % protect agains no cards left
    if nextCard > length(shuffledDeck)
        error('No more cards left in the deck.');
    end 
    
     % Deal one additional card
    hand(end+1) = shuffledDeck(nextCard);
    nextCard = nextCard + 1;
end

function handValue = calculateHandValue(hand)
    % Convert face cards (11,12,13) to 10
    values = hand;
    values(values > 10) = 10;

    % Count aces
    numAces = sum(values == 1);

    % Start by treating all aces as 11
    handValue = sum(values(values ~= 1)) + numAces * 11;

    % Adjust aces from 11 to 1 if bust
    while handValue > 21 && numAces > 0
        handValue = handValue - 10;
        numAces = numAces - 1;
    end
end

function bust = isBust(hand)
    % Returns true if hand value > 21
    bust = calculateHandValue(hand) > 21;
end

function [playerHand, nextCard, playerBust, playerStand] = playerTurn(shuffledDeck, nextCard, playerHand)
    % Player chooses hit or stand
    playerBust = false;
    playerStand = false;

    while ~playerBust && ~playerStand
        disp('Your current hand:')
        displayHand(playerHand);
        fprintf('Current hand value: %d\n', calculateHandValue(playerHand));

        choice = lower(input('Type "hit" to draw a card or "stand" to stop: ', 's'));

        if strcmp(choice, 'hit')  || strcmp(choice, 'h')
            [playerHand, nextCard] = hitCard(shuffledDeck, nextCard, playerHand);
            disp('You drew:')
            disp(playerHand(end));

            if isBust(playerHand)
                disp('Your updated hand:')
                displayHand(playerHand);
                fprintf('Hand value: %d\n', calculateHandValue(playerHand));
                playerBust = true;
            end

        elseif strcmp(choice, 'stand')
            playerStand = true;
            disp('You chose to stand.')

        else
            disp('Invalid input. Please type "hit" or "stand".')
        end

        fprintf('\n');
    end
end

function [dealerHand, nextCard] = dealerTurn(shuffledDeck, nextCard, dealerHand)
    % Dealer must hit until hand value is at least 17
    disp('Dealer reveals hand:')
    displayHand(dealerHand);
    fprintf('Dealer hand value: %d\n\n', calculateHandValue(dealerHand));

    while calculateHandValue(dealerHand) < 17
        disp('Dealer hits.')
        [dealerHand, nextCard] = hitCard(shuffledDeck, nextCard, dealerHand);
        disp('Dealer hand is now:')
        displayHand(dealerHand);
        fprintf('Dealer hand value: %d\n\n', calculateHandValue(dealerHand));
    end

    if isBust(dealerHand)
        disp('Dealer busts!')
    else
        disp('Dealer stands.')
    end
    fprintf('\n');
end

function result = determineWinner(playerHand, dealerHand)
    % Determine final winner
    playerValue = calculateHandValue(playerHand);
    dealerValue = calculateHandValue(dealerHand);

    if playerValue > 21
        result = 'You busted. Dealer wins.';
    elseif dealerValue > 21
        result = 'Dealer busted. You win!';
    elseif playerValue > dealerValue
        result = 'You win!';
    elseif dealerValue > playerValue
        result = 'Dealer wins.';
    else
        result = 'It is a tie.';
    end
end

function displayHand(hand)
    % Display hand as card names
    for i = 1:length(hand)
        card = hand(i);

        if card == 1
            fprintf('Ace ');
        elseif card == 11
            fprintf('Jack ');
elseif card == 12
            fprintf('Queen ');
        elseif card == 13
            fprintf('King ');
        else
            fprintf('%d ', card);
        end
    end
    fprintf('\n');
end        

% Test createDeck
deck = createDeck();
assert(length(deck) == 52, 'createDeck failed: deck should have 52 cards.')
assert(sum(deck == 1) == 4, 'createDeck failed: should contain 4 Aces.')
disp('createDeck passed.')

% Test shuffleDeck
shuffledDeck = shuffleDeck(deck);
assert(length(shuffledDeck) == 52, 'shuffleDeck failed: shuffled deck should have 52 cards.')
assert(isequal(sort(shuffledDeck), sort(deck)), ...
    'shuffleDeck failed: shuffled deck should contain the same cards.')
disp('shuffleDeck passed.')

% Test dealCards
[playerHand, dealerHand, nextCard] = dealCards(shuffledDeck);
assert(length(playerHand) == 2, 'dealCards failed: player should have 2 cards.')
assert(length(dealerHand) == 2, 'dealCards failed: dealer should have 2 cards.')
assert(nextCard == 5, 'dealCards failed: nextCard should be 5.')
disp('dealCards passed.')

% Test hitCard
oldLength = length(playerHand);
[playerHand2, nextCard2] = hitCard(shuffledDeck, nextCard, playerHand);
assert(length(playerHand2) == oldLength + 1, 'hitCard failed: hand size should increase by 1.')
assert(nextCard2 == nextCard + 1, 'hitCard failed: nextCard should increase by 1.')
assert(playerHand2(end) == shuffledDeck(nextCard), 'hitCard failed: wrong card added.')
disp('hitCard passed.')

%% Test calculateHandValue
assert(calculateHandValue([10 13]) == 20, 'calculateHandValue failed: [10 13] should be 20.')
assert(calculateHandValue([1 13]) == 21, 'calculateHandValue failed: [1 13] should be 21.')
assert(calculateHandValue([1 9 5]) == 15, 'calculateHandValue failed: [1 9 5] should be 15.')
assert(calculateHandValue([1 1 9]) == 21, 'calculateHandValue failed: [1 1 9] should be 21.')
disp('calculateHandValue passed.')

%% Test isBust
assert(isBust([10 9 5]) == true, 'isBust failed: [10 9 5] should bust.')
assert(isBust([10 7]) == false, 'isBust failed: [10 7] should not bust.')
assert(isBust([1 9]) == false, 'isBust failed: [1 9] should not bust.')
disp('isBust passed.')
