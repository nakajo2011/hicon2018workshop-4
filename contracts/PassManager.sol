pragma solidity ^0.4.22;


import "./MultiOwner.sol";
import "./EducationPass.sol";

/**
 * @title PassManager
 * @dev The PassManager contract has multi owner address, and a owner be able to issue education-pass.
 * @notice in the first. you must call init functions for create EducationPass Token.
 */
contract PassManager is MultiOwner {
  EducationPass private token;


  /**
   * @dev Throws if inited.
   */
  modifier yetInit() {
    require(address(token) == 0x0);
    _;
  }

  constructor() public {
  }

  function tokenAddress() public view returns(address) {
    return token;
  }

  /**
   * @dev create EducationPass token.
   * @notice This method can be called by only once.
   */
  function init() public onlyOwner yetInit {
    token = new EducationPass();
  }

  /**
   * @dev Issue the EducationPass token.
   * Wrapping EducationPass.mint so that some owners can issue pass.
   * @param _to The address of student.
   * @param _uportId The uportId of student.
   */
  function issue(address _to, uint256 _uportId) public onlyOwner {
    require(address(token) != 0x0, "not yet init.");
    token.mint(_to, _uportId);
  }
}
