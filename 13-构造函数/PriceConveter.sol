// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import "./AggregatorV3Interface.sol";
library PriceConveter {
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface dataFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
        (, int256 price, , , ) = dataFeed.latestRoundData();
        return uint256(price * 1e10);
    }
    function getConversionRate(
        uint256 btcAmount
    ) internal view returns (uint256) {
        uint256 btcPrice = getPrice();
        uint256 btcAmountInUsd = ((btcPrice * btcAmount) / 1e18);
        return btcAmountInUsd;
    }
}
