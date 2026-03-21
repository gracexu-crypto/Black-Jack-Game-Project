% Compare the final player and dealer hands.
%Return the game result as a message string.
function result = determineWinner(playerHand, dealerHand)
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