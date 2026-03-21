function handValue = calculateHandValue(hand)
    values = hand;
    values(values > 10) = 10;

    numAces = sum(values == 1);
    handValue = sum(values(values ~= 1)) + numAces * 11;

    while handValue > 21 && numAces > 0
        handValue = handValue - 10;
        numAces = numAces - 1;
    end
end