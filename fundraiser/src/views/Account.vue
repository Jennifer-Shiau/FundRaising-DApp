<template>
  <div class="account">
    <v-container fluid>
      <h2 class="font-weight-light display-1">{{ event['_eventName'] }}</h2>
      <v-row>
        <v-col
          cols="12"
          md="8"
        >
          <v-simple-table>
            <template v-slot:default>
              <tbody class="text-left">
                <tr @click="toCompany">
                  <td>Creator</td>
                  <td>{{ event['_creator'] }}</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Intro</td>
                  <td>{{ event['_intro'] }}</td>
                  <td>
                    <v-dialog v-model="dialog" v-if="validCreator" persistent max-width="600px">
                      <template v-slot:activator="{ on }">
                        <v-icon
                          small
                          class="mr-2"
                          v-on="on"
                        >
                          mdi-border-color
                        </v-icon>
                      </template>
                      <v-card>
                        <v-card-title>
                          <span class="headline">Edit Intro</span>
                        </v-card-title>
                        <v-card-text>
                          <v-container>
                            <v-row>
                              <v-col cols="12">
                                <v-text-field
                                  v-model="intro"
                                  :counter="50"
                                  :rules="introRules"
                                  label="Intro"
                                  required
                                ></v-text-field>
                              </v-col>
                            </v-row>
                          </v-container>
                        </v-card-text>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn color="blue darken-1" text @click="cancel">Cancel</v-btn>
                          <v-btn color="blue darken-1" text @click="edit">Save</v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>
                  </td>
                </tr>
                <tr>
                  <td>Target amount</td>
                  <td>{{ event['_targetAmount'] }}</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Received amount</td>
                  <td>{{ event['_receivedAmount'] }}</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Balance</td>
                  <td>{{ balance }}</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Address</td>
                  <td>{{ event['_eventAddress'] }}</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Ongoing</td>
                  <td>{{ event['_ongoing'] }}</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Category</td>
                  <td>{{ event['_eventType'] }}</td>
                  <td></td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-col>
        
        <v-col v-if="!loginStatus"
          cols="6"
          md="4"
        >
          <v-row justify="center" v-if="event['_ongoing']">
            <v-dialog v-model="dialog" persistent max-width="600px">
              <template v-slot:activator="{ on }">
                <v-btn color="primary" dark v-on="on">Donate</v-btn>
              </template>
              <v-card>
                <v-card-title>
                  <span class="headline">Donate</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-row>
                      <v-col cols="12">
                        <v-text-field
                          v-model="amount"
                          :rules="amountRules"
                          label="Amount"
                          required
                        ></v-text-field>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="blue darken-1" text @click="dialog = false">Cancel</v-btn>
                  <v-btn color="blue darken-1" text @click="donate">Confirm</v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
          </v-row>

        </v-col>
      </v-row>
      <v-row>
        <v-card>
            <v-card-title>Transactions</v-card-title>
            <v-simple-table>
              <template v-slot:default>
                <tbody class="text-left">
                  <tr>
                    <th>Donor Address</th>
                    <th>Donation Amount</th>
                    <td></td>
                  </tr>
                  <tr 
                  v-for="(tx, i) in txList"
                      :key="i"
                  >
                    <td>{{ tx.address }}</td>
                    <td>{{ tx.amount }}</td>
                    <td></td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </v-card>
      </v-row>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Account',
  props: {
    loginStatus: Boolean,
    eventAddress: String,//Event address
    userName: String,
    // Creator: String,
    state: Object
  },
  data: () => ({
    self: null,
    event: {},
    eventId: null,
    balance: null,
    txCount: 0,
    txList: [], //list of {'address': addr, 'amount': $} to preserve insert order
    validCreator: false,
    // for intro
    intro: "",
    introRules: [
      v => !!v || 'Intro is required',
      v => (v && v.length <= 50) || 'Intro must be less than 50 characters',
    ],
    // for donate
    dialog: false,
    amount: "",
    amountRules: [
      v => !!v || 'Amount is required'
    ],
  }),
  methods: {
    async donate() {
      let donorBalance = await this.state.contract.methods.getBalance(this.self).call({from: this.self});
      if ((donorBalance - this.amount) < 0) {
        alert('Donor does not have enough tokens!');
      }
      else if (this.event['_ongoing'] === false) {
        alert('The event has ended.');
        this.dialog = false;
      }
      else {
        this.dialog = false;
        await this.state.contract.methods.donate(this.self, this.event['_eventAddress'], this.amount).send({from: this.self});
        this.event = await this.state.contract.methods.eventList(this.eventId).call({from: this.self});
        this.balance = await this.state.contract.methods.getBalance(this.event['_eventAddress']).call({from: this.self});
        this.updateTx()
      }
    },
    toCompany() {
      this.$router.push({name: 'Company', params: {loginStatus: this.loginStatus, 
        userName: this.userName, creator: this.event['_creator'], state: this.state}});
    },
    checkCreator(){
      if (this.userName === this.event['_creator']){
        this.validCreator = true;
      }
    },
    async edit() {
      this.dialog = false;
      await this.state.contract.methods.editIntro(this.eventId, this.intro).send({from: this.self});
      this.event = await this.state.contract.methods.eventList(this.eventId).call({from: this.self});
    },
    cancel() {
      this.dialog = false;
      this.intro = this.event['_intro'];
    },
    async getTx() {
      this.txCount = await this.state.contract.methods.getTxCount(this.eventId).call({from:this.self});
      for (let i = 0; i < this.txCount; i++){
        let result = await this.state.contract.methods.getEventTXbyIdx(this.eventId, i).call({from:this.self});
        let {0: addr, 1: amount} = result;
        this.txList.push({'address': addr, 'amount': amount});
      }
    },
    async updateTx() {
      //after donate
      let newCount =  await this.state.contract.methods.getTxCount(this.eventId).call({from:this.self});
      for (let i = this.txCount; i < newCount; i++){
        let result = await this.state.contract.methods.getEventTXbyIdx(this.eventId, i).call({from:this.self});
        let {0: addr, 1: amount} = result;
        this.txList.push({'address': addr, 'amount': amount});
      }
      this.txCount = newCount;
    }
  },
  async mounted() {
    this.self = this.state.accounts[0];
    this.eventId = await this.state.contract.methods.addr2EventId(this.eventAddress).call({from: this.self}) - 1;
    this.event = await this.state.contract.methods.eventList(this.eventId).call({from: this.self});
    this.balance = await this.state.contract.methods.getBalance(this.event['_eventAddress']).call({from: this.self});
    this.checkCreator();
    this.intro = this.event['_intro'];
    this.getTx()
  }
}
</script>