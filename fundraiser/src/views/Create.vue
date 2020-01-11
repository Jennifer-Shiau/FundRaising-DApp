<template>
  <div class="create">
    <v-container height="200">
        <v-layout row wrap align-center>
            <v-flex xs12 sm6 offset-sm3>
             <v-card align="center">
                <v-responsive :aspect-ratio="2/1">
                  <v-card-text>
                    <h2 class="font-weight-light display-1">Create new event</h2>
                  </v-card-text>
                  <v-container>
                      <v-form
                        ref="form"
                        v-model="valid"
                        :lazy-validation="lazy"
                      >
                        <v-text-field
                          v-model="eventName"
                          :counter="50"
                          :rules="eventNameRules"
                          label="Event name"
                          required
                        ></v-text-field>

                        <v-text-field
                            v-model="targetAmount"
                            :rules="targetAmountRules"
                            label="Target amount"
                            suffix="tokens"
                            required
                        ></v-text-field>

                        <v-text-field
                            v-model="eventAddress"
                            :rules="eventAddressRules"
                            label="Event address"
                            required
                        ></v-text-field>

                        <v-select
                          v-model="selectCategory"
                          :items="categories"
                          :rules="[v => !!v || 'Category is required']"
                          label="Category"
                          required
                        ></v-select>

                        <v-btn
                          class="mr-4"
                          @click="createEvent"
                        >
                          Create
                        </v-btn>

                        <v-btn
                          class="mr-4"
                          @click="reset"
                        >
                          Reset Form
                        </v-btn>
                    </v-form>
                  </v-container>
                </v-responsive>
              </v-card>
            </v-flex>
        </v-layout>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Create',
  props: {
    loginStatus: Boolean,
    creator: String, //not used
    state: Object
  },
  data: () => ({
    selectCategory : null,
    valid: true,
    eventName: "",
    eventNameRules: [
      v => !!v || 'Event name is required',
      v => (v && v.length <= 50) || 'Event name must be less than 50 characters',
    ],
    targetAmount: null,
    targetAmountRules: [ //rule: is digit
      v => !!v || 'Target amount is required',
      v => !isNaN(parseInt(v)) && parseInt(v) > 0|| 'Target amount must be a number',
    ],
    eventAddress: "", //0x48C6Ed71726E4800210bF748C8C2909acDd24b02
    eventAddressRules:[
      v => !!v || 'Event address is required',
      v => (v && v.length == 42) || 'Event address must be 42 characters',
    ],
    categories: [
      'Natural Disasters',
      'Causes',
      'Donations',
      'Investments'
    ],
    lazy: false,
  }),
  methods: {
    toEventPage(){
      if (this.$refs.form.validate()) {
        this.$router.push({name: 'Account', params: {eventAddress :this.eventAddress, loginStatus: this.loginStatus,
        state: this.state}})
      }
    },
    reset () {
      this.$refs.form.reset()
    },
    async createEvent(){
      try {
        var self = this.state.accounts[0]
        await this.state.contract.methods.createEvent(this.eventName, this.creator, "...", this.targetAmount, 
              this.eventAddress, this.selectCategory).send({from: self})
        this.toEventPage()
      } catch (error) {
        alert('Fail!')
        this.reset()
      }
    }
  }
}
</script>