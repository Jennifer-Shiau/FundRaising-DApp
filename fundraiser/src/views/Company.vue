<template>
  <div class="company">
    <v-container fluid>
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
          <v-list class="elevation-1">
            <v-list-item-group>
              <v-list-item
                v-for="(event, i) in ongoingEvents"
                :key="i"
                @click="visitEventPage(event)"
              >
                <v-list-item-content>
                    {{ event }}
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-col>

        <v-col
          cols="6"
        >
          <h2>Past Events</h2><br>
          <v-list class="elevation-1">
            <v-list-item-group>
              <v-list-item
                v-for="(event, i) in pastEvents"
                :key="i"
                @click="visitEventPage(event)"
              >
                <v-list-item-content>
                    {{ event }}
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
    loginStatus: Boolean,
    state: Object
  },
  data: () => ({
    ongoingEvents: [
      'Event A',
      'Event B',
      'Event C'
    ],
    pastEvents: [
      'Event D',
      'Event E',
      'Event F'
    ]
  }),
  methods: {
    createEvent(){
      this.$router.push({name: 'Create', params: {loginStatus: this.loginStatus, creator: this.userName}})
    },
    visitEventPage(event){
      this.selectEvent = event
      this.$router.push({name: 'Account', params: {eventName:this.selectEvent, loginStatus: this.loginStatus}})
    }
  }
}
</script>