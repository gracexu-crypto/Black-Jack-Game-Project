function [dealerHand, nextCard] = dealerTurn(shuffledDeck, nextCard, dealerHand)
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