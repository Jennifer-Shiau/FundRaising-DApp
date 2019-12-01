<template>
  <v-container fluid>
    <v-layout
      row wrap
    >
      <v-flex offset-sm1>
        <v-card color="basil" width="90%" align="center">
        <v-card-title class="text-center justify-center py-6">
          <h1 class="font-weight-light display-2">FundRaising Events</h1>
        </v-card-title>

        <v-tabs
          v-model="selectCategory"
          background-color="transparent"
          color="basil"
          grow
        >
          <v-tab
            v-for="cat in categories"
            :key="cat.name"
          >
            {{ cat.name }}
          </v-tab>
        </v-tabs>

        <v-tabs-items v-model="selectCategory">
          <v-tab-item
            v-for="cat in categories"
            :key="cat.intro"
          >
            <v-card flat color="basil">
              <v-card-text>{{ cat.intro }}</v-card-text>

              <v-list>
                <v-subheader>Ongoing</v-subheader>
                <v-list-item-group v-model="selectEvent" color="primary">
                  <v-list-item
                    v-for="(event, i) in events"
                    :key="i"
                    @click="visitEventPage(event.name)"
                  >
                    <v-list-item-content>
                      <v-card class="text-left justify-center align-center elevation-1">
                        <v-row>
                          <v-col>
                          <v-card-title>{{event.name}}</v-card-title>
                          <v-card-subtitle>{{event.company}}</v-card-subtitle>
                          <v-card-text>
                            {{event.intro}}
                          </v-card-text>
                          </v-col>
                          <v-col>
                            <v-container class="text-right">
                              <v-card-text>{{event.progress}}%</v-card-text>
                              <v-progress-linear
                                disabled
                                :background-opacity=0.3
                                :value="event.progress"
                                rounded
                                color="indigo darken-2"
                                height="8"
                                dark
                              >
                              </v-progress-linear>
                            </v-container>
                          </v-col>
                        </v-row>
                      </v-card>
                    </v-list-item-content>
                  </v-list-item>
                </v-list-item-group>
              </v-list>
            
          </v-card>
        </v-tab-item>
      </v-tabs-items>
      </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  name: 'LandingPage',
  props:{
    loginStatus: Boolean
  },
  data: () => ({
    selectCategory: null,
    categories: [
      { name: 'Natural Disasters', intro: "Fundraising for disasters such as earthquakes...etc.", icon: ""},
      { name: 'Causes', intro: "Fundraising for dedicated causes.", icon: ""},
      { name: 'Donations', intro: "Donations of small amount???", icon: ""},
      { name: 'Investments', intro: "Investments in startups or others.", icon: ""},
    ],
    selectEvent: 1,
    events: [
      { name: 'Event A', company: "Red Cross", intro: "Raise funds for earthquake", progress:40},
      { name: 'Event B', company: "Red Cross", intro: "Raise funds for earthquake", progress:60},
      { name: 'Event C', company: "Red Cross", intro: "Raise funds for earthquake", progress:76},
    ],
  }),
  methods: {
    visitEventPage(event){
      this.selectEvent = event
      this.$router.push({name: 'Account', params: {eventName:this.selectEvent, loginStatus: this.loginStatus}})
    }
  }
};
</script>
