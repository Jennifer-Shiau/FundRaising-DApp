const Fundraiser = artifacts.require('../contracts/Fundraiser.sol');

contract('Fundraiser', function (accounts) {
  
  // for organization
  const _name = "aabbcc";
  const _password = "112233";
  // for event
  const _eventName = "testEvent";
  const _creator = _name;
  const _intro = "Event for testing";
  const _targetAmount = 1000;
  const _eventAddress = accounts[1];
  // for donate
  const _donor = accounts[0];
  const _event = _eventAddress;
  const _amount = 1000;

  it('Create an organization', async () => {
    let contract = await Fundraiser.deployed();
    await contract.createOrganization(_name, _password, {from:accounts[0]});
    let result = await contract.creatorName2Hash(_name);
    assert.notEqual(result, 0);
  })

  it('Check valid creator name', async () => {
    let contract = await Fundraiser.deployed();
    let result = true;
    try {
      await contract.createOrganization(_name, _password, {from:accounts[0]});
    }
    catch(error) {
      result = false;
    }
    assert.equal(result, false);
  })

  it('Create an event', async () => {
    let contract = await Fundraiser.deployed();
    await contract.createEvent(_eventName, _creator, _intro, _targetAmount, _eventAddress, {from:accounts[0]});
    let result = await contract.addr2EventId(_eventAddress);
    assert.equal(result, 1);
  })

  it('Donate to an event', async () => {
    let contract = await Fundraiser.deployed();
    // _ongoing should be true
    let eventId = await contract.addr2EventId(_event) - 1;
    let event = await contract.eventList(eventId);
    assert.equal(event._ongoing, true);
    // donate
    await contract.donate(_donor, _event, _amount, {from:accounts[0]});
    let received = await contract.getReceivedAmount(_event);
    let balance = await contract.getBalance(_event);
    assert.equal(_amount, 1000);
    assert.equal(received, _amount);
    assert.equal(balance, _amount);
    // get event again, _ongoing should be false
    event = await contract.eventList(eventId);
    assert.equal(event._ongoing, false);
    // ckeck donor balance
    let donorBalance = await contract.getBalance(_donor);
    let initialBalance = await contract._initialBalance();
    let expected = initialBalance - _amount;
    assert.equal(initialBalance, 10000);
    assert.equal(expected, 10000 - 1000);
    assert.equal(donorBalance, expected);
  })

  it('Get event list', async () => {
    let contract = await Fundraiser.deployed();
    let len = await contract.getEventListLength();
    var ongoingCount = 0;
    var pastCount = 0;
    for(var i = 0; i < len; i++) {
      let event = await contract.eventList(i);
      if(event._creator === _creator) {
        if(event._ongoing === true) {
          ongoingCount += 1;
        }
        else {
          pastCount += 1;
        }
      }
    }
    assert.equal(ongoingCount, 0);
    assert.equal(pastCount, 1);
  })
})
