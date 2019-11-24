<template>
    <v-app-bar
      color="white"
      class="elevation-0 align-left"
    >
      <v-toolbar-title>FundRaising DApp</v-toolbar-title>

      <v-spacer></v-spacer>
      <v-btn
        to="/home"
        text
      >
        <span class="mr-2">Home</span>
      </v-btn>

      <v-btn
        to="/about"
        text
      >
        <span class="mr-2">About</span>
      </v-btn>

      <v-btn
        text
      >
        <span class="mr-2">Events</span>
      </v-btn>

      <v-btn v-if="loginStatus && accountType=='Donor'"
        @click="displayAccount"
        text
      >
        <span class="mr-2">My Account</span>
      </v-btn>

      <v-btn v-if="loginStatus && accountType=='Organization'"
        @click="displayCompany"
        text
      >
        <span class="mr-2">Company</span>
      </v-btn>
      
      <v-spacer></v-spacer>

      <v-autocomplete
        cache-items
        class="mx-3"
        flat
        hide-no-data
        hide-details
        item-text=""
        label="Type to search for company or event..."
      >
      </v-autocomplete>

      <v-btn v-if="loginStatus" class="mx-2" icon>
        <v-icon>mdi-account</v-icon>
      </v-btn>

      <div v-else>
        <v-btn
          to="/login"
        >
          Log in
        </v-btn>
        <v-btn
          to="/signup"
        >
          Sign up
        </v-btn>
      </div>
    </v-app-bar>
</template>

<script>
export default {
  name: 'ToolBar',
  props: {
    accountType : String,
    loginStatus : Boolean,
    userName : String
  },
  methods: {
    displayAccount(){
      this.$router.push({ path: '/account/:' + this.userName})
    },
    displayCompany(){
      this.$router.push({ path: '/company/:' + this.userName})
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
