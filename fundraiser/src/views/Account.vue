<template>
  <div class="account">
    <v-container>
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
        
        <v-col
          cols="6"
          md="4"
        >
          <v-btn>Save Money</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Account',
  components: {

  }
}
</script>