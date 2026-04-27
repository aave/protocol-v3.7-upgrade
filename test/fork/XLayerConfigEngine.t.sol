// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {
    IAaveV3ConfigEngine
} from "aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol";

contract XLayerConfigEngineParityTest is Test {
    address constant OLD_ENGINE = 0x2eb21BCE2C5D59a67C648BfD2e700AdDB752DD7B;
    address constant NEW_ENGINE = 0x29A9b0a13c81d59f13BA0f39DBDCAA1AB2adc95F;

    function setUp() public {
        vm.createSelectFork(vm.rpcUrl("xLayer"));
    }

    function test_newEngineMatchesLive() public view {
        IAaveV3ConfigEngine oldEngine = IAaveV3ConfigEngine(OLD_ENGINE);
        IAaveV3ConfigEngine newEngine = IAaveV3ConfigEngine(NEW_ENGINE);

        assertEq(address(newEngine.POOL()), address(oldEngine.POOL()), "POOL");
        assertEq(
            address(newEngine.POOL_CONFIGURATOR()),
            address(oldEngine.POOL_CONFIGURATOR()),
            "POOL_CONFIGURATOR"
        );
        assertEq(address(newEngine.ORACLE()), address(oldEngine.ORACLE()), "ORACLE");
        assertEq(
            newEngine.DEFAULT_INTEREST_RATE_STRATEGY(),
            oldEngine.DEFAULT_INTEREST_RATE_STRATEGY(),
            "DEFAULT_INTEREST_RATE_STRATEGY"
        );
        assertEq(
            newEngine.REWARDS_CONTROLLER(),
            oldEngine.REWARDS_CONTROLLER(),
            "REWARDS_CONTROLLER"
        );
        assertEq(newEngine.COLLECTOR(), oldEngine.COLLECTOR(), "COLLECTOR");
        assertEq(newEngine.ATOKEN_IMPL(), oldEngine.ATOKEN_IMPL(), "ATOKEN_IMPL");
        assertEq(newEngine.VTOKEN_IMPL(), oldEngine.VTOKEN_IMPL(), "VTOKEN_IMPL");
    }
}
