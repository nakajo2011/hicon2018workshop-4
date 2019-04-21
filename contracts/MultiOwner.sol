pragma solidity >0.4.99 <0.6.0;


/**
 * @title MultiOwner
 * @dev The MultiOwner contract has multi owner address, and provides basic authorization control
 * functions.
 * This contract is not multisig. it allow each owners to be able control by single.
 */
contract MultiOwner {

  mapping(address => bool) private _owners;

  event AddOwner(
    address indexed newOwner
  );

  event RemoveOwner(
    address indexed fired
  );

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() internal {
    _addOwner(msg.sender);
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isOwner() public view returns (bool) {
    return _owners[msg.sender];
  }

  function addOwner(address _newOwner) public onlyOwner {
    _addOwner(_newOwner);
  }

  function removeOwner(address _fireAddress) public onlyOwner {
    _removeOwner(_fireAddress);
  }

  /**
   * @dev Add owner of the contract.
   * @param _newOwner new owner address.
   */
  function _addOwner(address _newOwner) internal {
    _owners[_newOwner] = true;
    emit AddOwner(_newOwner);
  }

  /**
   * @dev Remove owner of the contract.
   */
  function _removeOwner(address _fireAddress) internal {
    _owners[_fireAddress] = false;
    emit RemoveOwner(_fireAddress);
  }
}
