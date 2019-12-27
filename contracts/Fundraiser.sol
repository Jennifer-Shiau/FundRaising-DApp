// pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Fundraiser is ERC20 {

	uint public _initialBalance = 10000;

	constructor() public payable {
    _mint(msg.sender, _initialBalance);
  }

  mapping(address=>uint) public addr2EventId;
  mapping(string=>uint) public creatorName2Hash;
  mapping(string=>uint) public creatorName2OrgId;

  //company posts mapping

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
    string _eventType;
    address[] _txAddress;
    uint256[] _txAmount;
    uint256 _likes;
    uint256 _dislikes;
    string[][] _comments; //here x y is reversed. a dynamic array of length 10 arrays
  }

  struct Organization {
    string _userName;
    string _intro;
    uint256 _likes;
    uint256 _dislikes;
    string[][] _posts;
  }

  Event[] public eventList;
  Organization[] public orgList;

  function createOrganization(string memory _name, string memory _password) public payable {
    // create new organization
    uint _nameCode = uint(keccak256(abi.encodePacked(_name))) % _modulus;
    uint _passwordCode = uint(keccak256(abi.encodePacked(_password))) % _modulus;
    uint _code = _nameCode * _modulus + _passwordCode;
    creatorName2Hash[_name] = _code;
    string[][] memory _comments;
    orgList.push(Organization(_name, "", 0, 0, _comments));
  }

  function checkValidName(string memory _name) public view returns (bool) {
    // for sign up
    if (creatorName2Hash[_name] == 0) {
      return true;
    }
    else {
      return false;
    }
  }

  function verifyPassword(string memory _name, string memory _password) public view returns (bool) {
    // for login
    uint _nameCode = uint(keccak256(abi.encodePacked(_name))) % _modulus;
    uint _passwordCode = uint(keccak256(abi.encodePacked(_password))) % _modulus;
    uint _code = _nameCode * _modulus + _passwordCode;
    if (_code == creatorName2Hash[_name]) {
      return true;
    }
    else {
      return false;
    }
  }

	function createEvent(string memory _eventName, string memory _creator, string memory _intro,
		uint256 _targetAmount, address _eventAddress, string memory _eventType) public payable {
    // create new event
    address[] memory _txAddress;
    uint256[] memory _txAmount;
    string[][] memory _comments;
    uint id = eventList.push(Event(_eventName, _creator, _intro, _targetAmount, 0, _eventAddress, true,
      _eventType, _txAddress, _txAmount, 0, 0, _comments));
    addr2EventId[_eventAddress] = id;
  }

  function donate(address _donor, address payable _event, uint _amount) public payable {
    // donate to event
    require(balanceOf(_donor) >= _amount, "Donor does not have enough ethers!");
    uint _id = addr2EventId[_event] - 1;
    require(eventList[_id]._ongoing == true, "The event has ended.");
		require(msg.sender == _donor, "Sender should be donor!");

		transfer(_event, _amount);
    storeDonation(_donor, _event, _amount);
    updateOngoing(_id);
  }

  function editIntro(uint _id, string memory _intro) public payable {
    // edit event intro
    eventList[_id]._intro = _intro;
  }

  function storeDonation(address _donor, address payable _event, uint _amount) private {
    // store donation into event
    uint _id = addr2EventId[_event] - 1;
		eventList[_id]._txAddress.push(_donor);
    eventList[_id]._txAmount.push(_amount);
    eventList[_id]._receivedAmount += _amount;
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

  function getTxCount(uint eIdx) public view returns (uint) {
		// get length of transaction lists of event eIdx
		return eventList[eIdx]._txAddress.length;
	}

  function getEventTXbyIdx(uint eIdx, uint txIdx) public view returns (address, uint) {
		// get txIdx transaction of eIdx event
		return (eventList[eIdx]._txAddress[txIdx], eventList[eIdx]._txAmount[txIdx]);
	}

  function getCommentCount(uint eIdx) public view returns (uint) {
		// get length of comment list of event eIdx
		return eventList[eIdx]._comments.length;
	}

  function getCommentsbyIdx(uint eIdx, uint rIdx) public view returns(string[] memory){
    // get a comment and its replies of a certain event by eIdx and rIdx
    uint n = eventList[eIdx]._comments[rIdx].length;
    string[] memory ret = new string[](n);
    for(uint i = 0; i < n; i++){
      ret[i] = eventList[eIdx]._comments[rIdx][i];
    }
    return ret;
  }

  function updateComment(uint eIdx, string memory comment) public payable{
    // update event comment
    string[] memory newComment = new string[](1);
    newComment[0] = comment;
    eventList[eIdx]._comments.push(newComment);
  }

  function updateReply(uint eIdx, uint rIdx, string memory comment) public payable {
    // update event reply
    eventList[eIdx]._comments[rIdx].push(comment);
  }

  function updateLikes(uint eIdx, uint256 _newLikes) public payable {
    // update likes for event
    eventList[eIdx]._likes = _newLikes;
  }

  function updateDislikes(uint eIdx, uint256 _newDislikes) public payable {
    // update dislikes for event
    eventList[eIdx]._dislikes = _newDislikes;
  }

  function updateOrgLikes(uint oIdx, uint256 _newLikes) public payable {
    // update likes for organization
    orgList[oIdx]._likes = _newLikes;
  }

  function updateOrgDislikes(uint oIdx, uint256 _newDislikes) public payable {
    // update dislikes for organization
    orgList[oIdx]._dislikes = _newDislikes;
  }

  function updateOrgIntro(uint oIdx, string memory _intro) public payable {
    // update intro for organization
    orgList[oIdx]._intro = _intro;
  }

  function updateOrgPosts(uint oIdx, string memory _post) public payable {
    // update organization posts
    string[] memory newPost = new string[](1);
    newPost[0] = _post;
    orgList[oIdx]._posts.push(newPost);
  }

  function updateOrgPostReply(uint oIdx, uint pIdx, string memory _post) public payable {
    // update organization post reply for pIdx post
    orgList[oIdx]._posts[pIdx].push(_post);
  }

  function editOrgIntro(uint oIdx, string memory _intro) public payable {
    // edit organization intro
    orgList[oIdx]._intro = _intro;
  }
}
