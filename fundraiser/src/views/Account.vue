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
              <thead>
                <tr>
                  <th class="text-left">Name</th>
                  <th class="text-left">Value</th>
                </tr>
              </thead>
              <tbody class="text-left">
                <tr @click="toCompany">
                  <td>Creator</td>
                  <td>{{ event['_creator'] }}</td>
                </tr>
                <tr>
                  <td>Intro</td>
                  <td>{{ event['_intro'] }}</td>
                </tr>
                <tr>
                  <td>Target amount</td>
                  <td>{{ event['_targetAmount'] }}</td>
                </tr>
                <tr>
                  <td>Received amount</td>
                  <td>{{ event['_receivedAmount'] }}</td>
                </tr>
                <tr>
                  <td>Balance</td>
                  <td>{{ balance }}</td>
                </tr>
                <tr>
                  <td>Address</td>
                  <td>{{ event['_eventAddress'] }}</td>
                </tr>
                <tr>
                  <td>Ongoing</td>
                  <td>{{ event['_ongoing'] }}</td>
                </tr>
                <tr>
                  <td>Category</td>
                  <td>{{ event['_eventType'] }}</td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
          
          <!--
          <v-expansion-panels focusable>
            <v-expansion-panel>
              <v-expansion-panel-header>Balance</v-expansion-panel-header>
              <v-expansion-panel-content>
                1000 ETH
              </v-expansion-panel-content>
            </v-expansion-panel>

            <v-expansion-panel>
              <v-expansion-panel-header>Transactions</v-expansion-panel-header>
              <v-expansion-panel-content>
                <v-card>
                  <v-tabs grow>
                    <v-tab>Input</v-tab>
                    <v-tab>Output</v-tab>
                    
                    <v-tab-item>
                      <v-card flat>
                        <v-card-text>Transaction inputs ...</v-card-text>
                      </v-card>
                    </v-tab-item>
                    <v-tab-item>
                      <v-card flat>
                        <v-card-text>Transaction outputs ...</v-card-text>
                      </v-card>
                    </v-tab-item>
                  </v-tabs>
                </v-card>
              </v-expansion-panel-content>
            </v-expansion-panel>
          </v-expansion-panels>
          -->
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
      }
    },
    toCompany() {
      this.$router.push({name: 'Company', params: {loginStatus: this.loginStatus, 
        userName: this.userName, creator: this.event['_creator'], state: this.state}});
    }
  },
  async mounted() {
    this.self = this.state.accounts[0];
    this.eventId = await this.state.contract.methods.addr2EventId(this.eventAddress).call({from: this.self}) - 1;
    this.event = await this.state.contract.methods.eventList(this.eventId).call({from: this.self});
    this.balance = await this.state.contract.methods.getBalance(this.event['_eventAddress']).call({from: this.self});
  }
}
</script>