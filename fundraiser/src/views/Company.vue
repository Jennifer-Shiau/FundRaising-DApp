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
            New
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
          <v-list>
            <v-list-item-group v-model="selectEvent">
              <v-list-item
                v-for="(event, i) in ongoingEvents"
                :key="i"
              >
                <v-list-item-content>
                  <v-btn
                    @click="visitEventPage"
                    width = 400 px
                  >
                    {{ event }}
                  </v-btn>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-col>

        <v-col
          cols="6"
        >
          <h2>Past Events</h2><br>
          <v-list>
            <v-list-item-group v-model="selectEvent">
              <v-list-item
                v-for="(event, i) in pastEvents"
                :key="i"
              >
                <v-list-item-content>
                  <v-btn
                    @click="visitEventPage"
                    width = 400 px
                  >
                    {{ event }}
                  </v-btn>
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
    userName: String
  },
  data: () => ({
    selectEvent: 1,
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
      this.$router.push({path: '/create/:' + this.userName})
    },
    visitEventPage(){
      this.$router.push({path: '/account/:' + this.selectEvent})
    }
  }
}
</script>