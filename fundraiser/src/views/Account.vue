<template>
  <div class="account">
    <v-container fluid>
      <h2 class="font-weight-light display-1">{{ event['_eventName'] }}</h2>
      <v-row>
        <v-col
          cols="12"
          md="8"
        >
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
        </v-col>
        
        <v-col v-if="!loginStatus"
          cols="6"
          md="4"
        >
          <v-btn>Donate</v-btn>
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
    state: Object
  },
  data: () => ({
    event: {},
  }),
  async mounted(){
    let self = this.state.accounts[0]
    let eventId = await this.state.contract.methods.addr2EventId(this.eventAddress).call({from: self}) - 1;
    this.event = await this.state.contract.methods.eventList(eventId).call({from: self});
    console.log(this.event["_eventName"])
  }
}
</script>