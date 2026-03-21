% Handle the player turn by asking for hit or stand.
% The turn ends when the player busts or chooses to stand.

function [playerHand, nextCard, playerBust, playerStand] = playerTurn(shuffledDeck, nextCard, playerHand)
    
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