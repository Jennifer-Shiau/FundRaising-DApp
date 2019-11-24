<template>
  <div class="company">
    <v-container>
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

    <v-container>
      <v-row>
        <v-col
          cols="6"
        >
          <h2>Ongoing Events</h2><br>
          <v-card>
            <v-card-text>
              <div>
                <v-btn
                  width = 400 px
                  to = "/account"
                >
                  Event A
                </v-btn>
              </div>
              <br>
              <div>
                <v-btn
                  width = 400 px
                  to = "/account"
                >
                  Event B
                </v-btn>
              </div>
              <br>
              <div>
                <v-btn
                  width = 400 px
                  to = "/account"
                >
                  Event C
                </v-btn>
              </div>
            </v-card-text>
          </v-card>
        </v-col>
        
        <v-col
          cols="6"
        >
          <h2>Past Events</h2><br>
          <v-card>
            <v-card-text>
              <div>
                <v-btn
                  width = 400 px
                  to = "/account"
                >
                  Event D
                </v-btn>
              </div>
              <br>
              <div>
                <v-btn
                  width = 400 px
                  to = "/account"
                >
                  Event E
                </v-btn>
              </div>
              <br>
              <div>
                <v-btn
                  width = 400 px
                  to = "/account"
                >
                  Event F
                </v-btn>
              </div>
            </v-card-text>
          </v-card>
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
    selectEvent: null,
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
//TODO: Change events to list and use visitEventPage function
</script>