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


fprintf('\n');

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

        if strcmp(choice, 'hit')
            [playerHand, nextCard] = hitCard(shuffledDeck, nextCard, playerHand);
            disp('You drew:')
            disp(playerHand(end))

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
    % Display hand as card values
    disp(hand)
end
