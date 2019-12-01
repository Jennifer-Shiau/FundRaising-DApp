const Fundraiser = artifacts.require('../contracts/Fundraiser.sol');

contract('Fundraiser', function (accounts) {
  let contract;

  // execute before each test and will deploy a new instance of the smart contract
  // ensures each test is executed against a clean contract state
  // beforeEach(async () => {
  //   contract = await Fundraiser.new()
  // })
  contract = await Fundraiser.deployed();

  // for organization
  const _name = "aabbcc";
  const _password = "112233";
  // for event
  const _eventName = "testEvent";
  const _creator = _name;
  const _intro = "Event for testing";
  const _targetAmount = 1000;
  const _eventAddress = 0x0;
  // for donate
  const _donor = accounts[0];
  const _event = _eventAddress;
  const _amount = 100;

  it('Create an organization', async () => {
    let result = await contract.createOrganization(_name, _password).send();
    assert.equal(result, true);
  })

  it('Check valid creator name', async () => {
    let result = true;
    try {
      result = await contract.createOrganization(_name, _password).send();
    }
    catch(error) {
      result = false;
    }
    assert.equal(result, false);
  })

  it('Create an event', async () => {
    let result = await contract.createEvent(_eventName, _creator, _intro, _targetAmount, _eventAddress).send();
    assert.equal(result, true);
  })

  it('Donate to an event', async () => {
    await contract.donate(_donor, _event, _amount).send();
    let received = await contract.getReceivedAmount(_event).call();
    let balance = await contract.getBalance(_event).call();
    assert.equal(received, _amount);
    assert.equal(balance, _amount);
  })

  it('Get event list', async () => {
    let eventList = await contract.eventList();

    var count = 0;
    var i;
    for(i = 0; i < eventList.length; i++) { 
      if(eventList[i]._creator === _creator) {
        count += 1;
      }
    }
    assert.equal(count, 1);
  })
})
