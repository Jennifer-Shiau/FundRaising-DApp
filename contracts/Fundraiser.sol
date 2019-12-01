pragma solidity ^0.5.8;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Fundraiser is ERC20 {

	uint public _initialBalance = 10000;

	constructor() public {
    _mint(msg.sender, _initialBalance);
  }

  mapping(address=>uint) public addr2EventId;
  mapping(string=>uint) public creatorName2Hash;

  uint _digits = 8;
  uint _modulus = 10 ** _digits;

  struct Event {
    string _eventName;
    string _creator;
    string _intro;
  	uint256 _targetAmount;
  	uint256 _receivedAmount;
    address _eventAddress;
    bool _ongoing;
    mapping(address=>uint256) _transactions;
  }

  Event[] public eventList;

  // events
	event NewEvent(string _name, string _creator, uint256 _target, address _event, string _intro);
  event Donate(address _donor, address _event, uint _amount);
  event DonationStored(uint _eventId, uint _amount); 	//cannot emit struct in event
	event NewOrganization(string _name, string _password);

  modifier checkValidCreatorName(string memory _name) {
    require(creatorName2Hash[_name] == 0, "Creator name is invalid.");
    _;
  }

  function createOrganization(string memory _name, string memory _password) public checkValidCreatorName(_name) returns(bool) {
    uint _nameCode = uint(keccak256(abi.encodePacked(_name))) % _modulus;
    uint _passwordCode = uint(keccak256(abi.encodePacked(_password))) % _modulus;
    uint _code = _nameCode * _modulus + _passwordCode;
    creatorName2Hash[_name] = _code;
		emit NewOrganization(_name, _password);
  }

	function createEvent(string memory _eventName, string memory _creator, string memory _intro,
											uint256 _targetAmount, address _eventAddress) public returns(bool) {
    // create new event
    uint id = eventList.push(Event(_eventName, _creator, _intro, _targetAmount, 0, _eventAddress, true));
    addr2EventId[_eventAddress] = id;
    emit NewEvent(_eventName, _creator, _targetAmount,  _eventAddress, _intro);
  }

  function donate(address _donor, address payable _event, uint _amount) public {
    // donate to event
    require(balanceOf(_donor) >= _amount, "Donor does not have enough ethers!");
    uint _id = addr2EventId[_event] - 1;
    require(eventList[_id]._ongoing == true, "The event has ended.");
		require(msg.sender == _donor, "Sender should be donor!");

		transfer(_event, _amount);
    storeDonation(_donor, _event, _amount);
    updateOngoing(_id);
    emit Donate(_donor, _event, _amount);
  }

  function storeDonation(address _donor, address payable _event, uint _amount) private {
    // store donation into event
    uint _id = addr2EventId[_event] - 1;
		eventList[_id]._transactions[_donor] = _amount;
    eventList[_id]._receivedAmount += _amount;
    emit DonationStored(_id, _amount);
  }

  function updateOngoing(uint _id) private {
    // update ongoing status for events that received donations
		if (eventList[_id]._receivedAmount >= eventList[_id]._targetAmount) {
      eventList[_id]._ongoing = false;
    }
  }

  function getReceivedAmount(address _event) public view returns (uint) {
    // get received amount for event
    uint id = addr2EventId[_event] - 1;
    return eventList[id]._receivedAmount;
  }

  function getBalance(address _event) public view returns (uint) {
    // get balance for event
    return balanceOf(_event);
  }

	function getEventListLength() public view returns (uint) {
		// get length of eventList
		return eventList.length;
	}
}
