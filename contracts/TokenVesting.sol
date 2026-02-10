// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TokenVesting {
  address public beneficiary;
  uint256 public start;
  uint256 public duration;
  uint256 public totalAmount;
  uint256 public released;

  event ETHFunded(uint256 indexed amount, uint256 indexed timestamp);
  event ETHReleased(uint256 indexed amount, address indexed to);

  constructor(address b, uint256 s, uint256 d) {
    require(b != address(0), "Beneficiary cannot be zero address");
    require(d > 0, "Duration must be greater than zero");
    require(s <= block.timestamp || s > block.timestamp, "Start time must be valid");
    
    beneficiary = b;
    start = s;
    duration = d;
  }

  function release() external {
    uint256 vested = vestedAmount(block.timestamp);
    require(vested > released, "No tokens available for release");
    
    uint256 unreleased = vested - released;
    released += unreleased;
    
    (bool success, ) = payable(beneficiary).call{value: unreleased}("");
    require(success, "ETH transfer failed");
    
    emit ETHReleased(unreleased, beneficiary);
  }

  function vestedAmount(uint256 t) public view returns (uint256) {
    if (t < start) return 0;
    if (t >= start + duration) return totalAmount;
    return (totalAmount * (t - start)) / duration; //Division by duration is safe because duration > 0 (validated in constructor)
  }

  receive() external payable {
    require(msg.value > 0, "Must send ETH");
    totalAmount += msg.value;
    emit ETHFunded(msg.value, block.timestamp);
  }
}
