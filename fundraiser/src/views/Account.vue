<template>
  <div class="account">
    <v-container fluid>
      <h2 class="font-weight-light display-1">{{ displayName }}</h2>
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
        
        <v-col v-if="displayType=='Event' && accountType!='Organization'"
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
    accountType: String, //Organization or Donor
    displayType: String, //Event or Donor
    loginStatus: Boolean,
    displayName: String//Event name or donor name
  },
}
</script>