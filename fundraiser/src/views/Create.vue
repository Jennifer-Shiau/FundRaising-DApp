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
                            suffix="ETH"
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
                          @click="toEventPage"
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
  data: () => ({
    selectCategory : null,
    valid: true,
    eventName: "",
    eventNameRules: [
      v => !!v || 'Event name is required',
      v => (v && v.length <= 50) || 'Event name must be less than 50 characters',
    ],
    targetAmount: "",
    targetAmountRules: [
      v => !!v || 'Target amount is required',
    ],
    categories: [
      'Natural Disasters',
      'Causes',
      'Donations',
      'Investments'
    ],
    lazy: false,
    // userName = $route.params.userName
  }),
  methods: {
    toEventPage(){
      if (this.$refs.form.validate()) {
        this.$router.push({path: '/account/:' + this.eventName})
      }
    },
    reset () {
      this.$refs.form.reset()
    }
  }
}
</script>