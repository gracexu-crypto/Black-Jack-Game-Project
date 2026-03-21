function bust = isBust(hand)
    bust = calculateHandValue(hand) > 21;
end