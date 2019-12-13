<template>
  <div class="company">
    <v-container fluid v-if="validCreator">
      <v-row>
        <v-col
          cols="2"
        >
          <v-btn
            @click="createEvent"
          >
            Create Event
          </v-btn>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid>
      <v-row>
        <v-col
          cols="6"
        >
          <h2>Ongoing Events</h2><br>
          <v-list class="elevation-1" v-if="mounted">
            <v-list-item-group>
              <v-list-item
                v-for="(event, i) in ongoingEvents"
                :key="i"
                @click="visitEventPage(event['_eventAddress'])"
              >
                <v-list-item-content>
                    {{ event['_eventName'] }}
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-col>

        <v-col
          cols="6"
        >
          <h2>Past Events</h2><br>
          <v-list class="elevation-1" v-if="mounted">
            <v-list-item-group>
              <v-list-item
                v-for="(event, i) in pastEvents"
                :key="i"
                @click="visitEventPage(event['_eventAddress'])"
              >
                <v-list-item-content>
                    {{ event['_eventName'] }}
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Company',
  props: {
    userName: String,
    creator: String,
    loginStatus: Boolean,
    state: Object
  },
  data: () => ({
    ongoingEvents: [],
    pastEvents: [],
    validCreator: false,
    mounted: false
  }),
  methods: {
    createEvent(){
      this.$router.push({name: 'Create', params: {loginStatus: this.loginStatus, creator: this.userName, 
        state: this.state}})
    },
    visitEventPage(eventAddress){
      this.selectEvent = eventAddress
      this.$router.push({name: 'Account', params: {eventAddress: this.selectEvent, loginStatus: this.loginStatus,
        userName: this.userName, state: this.state}})
    },
    checkCreator(){
      if (this.userName === this.creator){
        this.validCreator = true;
      }
    },
    async getEventList(){
      console.log(this.userName)
      console.log(this.creator)
      let self = this.state.accounts[0]
      let len = await this.state.contract.methods.getEventListLength().call({from:self});
      for (let i = 0; i < len; i++) {
        let e = await this.state.contract.methods.eventList(i).call({from:self});
        if (e['_creator'] === this.creator) {
          if (e['_ongoing'] === true) {
            this.ongoingEvents.push(e);
          }
          else {
            this.pastEvents.push(e);
          }
        }
      }
      this.mounted = true;
    }
  },
  mounted(){
    this.checkCreator()
    this.getEventList()
  }
}
</script>