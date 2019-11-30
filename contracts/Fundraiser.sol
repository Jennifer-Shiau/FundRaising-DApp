pragma solidity ^0.5.8;

contract fundraising {
  	
  	mapping(address=>uint) add2eventId;
  	mapping(string=>uint) creatorName2Hash;
  	
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
	
  	//events
	event NewEvent(string _name, string _creator, uint256 _target, address _event, string _intro);
    event Donate(address _donor, address _event, uint _amount);
  	event DonationStored(address _event, uint _amount);
  
  	modifier checkValidCreatorName(string _name) {
        require(creatorName2Hash[_name] == 0, "Creator name is invalid.");
        _;
    }

  	function createOrganization(string _name, string _password) checkValidCreatorName(_name) {
      	uint _nameCode = uint(keccak256(_name)) % _modulus;;
      	uint _passwordCode = uint(keccak256(_password)) % _modulus;
      	uint _code = _nameCode * _modulus + _passwordCode;
    	creatorName2Hash[_name] = _code;
    }
	
	function createEvent(string _eventName, string _creator, string _intro, uint256 _targetAmount, address _eventAddress) public {
      	//create new event
        uint id = eventList.push(Event(_eventName, _creator, _intro, _targetAmount, 0, _eventAddress, true)) - 1;
        add2eventId[_eventAddress] = id;
        NewEvent(_eventName, _creator, _targetAmount,  _eventAddress, _intro);
    }
  	
  	function donate(address _donor, address _event, uint _amount) {
      	//donate to event
      	require(_donor.balance >= _amount);
      	uint _id = addr2eventId(_event);
      	require(eventList[_id]._ongoing == true)
      
      	_event.transfer(_amount);
      	storeDonation(_donor, _event, _amount);
      	updateOngoing(_id);
      	Donate(_donor, _event, _amount);
    }
  
  	function storeDonation(address _donor, address _event, uint _amount){
      	//store donation into event
      	uint id = addr2eventId(_event);
		eventList[id]._transactions[_donor] = _amount;
      	eventList[id]._receivedAmount += _amount;
        DonationStored(eventList[id], _amount);
    }
  
  	function updateOngoing(uint _id) {
      	//update ongoing status for events that received donations
		if (eventList[_id]._receivedAmount >= eventList[_id]._targetAmount) {
          	eventList[_id]._ongoing = false;
        }
    }
  
  	function getReceivedAmount(address _event) public returns (uint) {
      	//get received amount for event
      	uint id = addr2eventId(_event);
      	return eventList[id]._receivedAmount;
    }
  
  	function getBalance(address _event) public returns (uint) {
      	//get balance for event
      	return _event.balance;
    }
  	
  	function getEventList(string _creator) public returns (Event[], Event[]){
      	//get ongoing and past events from same organization
      	Event[] ongoing;
      	Event[] past;
      	for(uint i = 0; i < eventList.length; i++) {
          	if(eventList[i]._creator == _creator) {
              	if(eventList[i]._ongoing == true) {
                  	ongoing.push(eventList[i]);
                }
              	else {
                  	past.push(eventList[i]);
                }
            }
        }
    	return ongoing, past;
    }
}