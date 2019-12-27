<template>
  <div class="company">
    <v-container>
      <v-row>
        <v-col
          cols="4"
        >
          <div align="center">
            <v-img src="https://i.imgur.com/UVOo14B.png" aspect-ratio="1" max-width="150"></v-img>
            <br>
            <v-row>
              <v-col></v-col>
              <v-col>
                <v-img src="https://i.imgur.com/zQOYAeS.png" aspect-ratio="1" max-width="50"></v-img>
              </v-col>
              <v-col>
                <v-img src="https://i.imgur.com/BiXsNgt.png" aspect-ratio="1" max-width="50"></v-img>
              </v-col>
              <v-col>
                <v-img src="https://i.imgur.com/dw77URG.png" aspect-ratio="1" max-width="50"></v-img>
              </v-col>
              <v-col></v-col>
            </v-row>
          </div>
        </v-col>

        <v-col
          cols="8"
        >
          <v-row>
            <v-col cols="8" align="left">
              <h1>{{ creator }}</h1><br>
              <h3>About as</h3>
              <p>{{ orgIntro }}</p>
            </v-col>
            <v-col cols="4" v-if="validCreator">
              <v-btn
                @click="createEvent"
                color="primary"
                class="my-10"
              >
                Create Event
              </v-btn>
            </v-col>
          </v-row>
          
          <v-row>
            <v-col cols="8"></v-col>
            <v-col cols="2">
              <v-btn class="ma-2" text icon color="blue lighten-2">
                <v-icon large>mdi-thumb-up</v-icon>
              </v-btn>
              {{ likeCount }}
            </v-col>

            <v-col cols="2">
              <v-btn class="ma-2" text icon color="red lighten-2">
                <v-icon large>mdi-thumb-down</v-icon>
              </v-btn>
              {{ dislikeCount }}
            </v-col>
          </v-row>
        </v-col>
      </v-row>

      <v-flex>
        <v-tabs
          v-model="select"
          background-color="transparent"
          color="basil"
          grow
        >
          <v-tab>Post</v-tab>
          <v-tab>Ongoing Events</v-tab>
          <v-tab>Past Events</v-tab>
        </v-tabs>

        <v-tabs-items v-model="select">
          <v-tab-item>
            posts
          </v-tab-item>

          <v-tab-item>
            <v-list class="elevation-1" v-if="eventReady">
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
          </v-tab-item>

          <v-tab-item>
            <v-list class="elevation-1" v-if="eventReady">
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
          </v-tab-item>
        </v-tabs-items>
      </v-flex>
    </v-container>

    <!-- original -->
    <!--
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
          <v-list class="elevation-1" v-if="eventReady">
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
          <v-list class="elevation-1" v-if="eventReady">
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
    -->
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
    select: 0,
    ongoingEvents: [],
    pastEvents: [],
    validCreator: false,
    eventReady: false,
    orgIntro: "Organization intro ...",
    likeCount: 87,
    dislikeCount: 78,
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
      this.ongoingEvents = []
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
      this.eventReady = true;
    }
  },
  watch: {
    creator: {
      handler() {
        this.eventReady = false;
        this.getEventList()
        this.checkCreator()
      },
      immediate: true,
    }
  },
}
</script>