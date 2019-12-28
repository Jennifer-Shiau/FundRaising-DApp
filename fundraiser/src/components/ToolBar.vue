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

      <v-btn v-if="loginStatus"
        @click="displayCompany"
        text
      >
        <span class="mr-2">Profile</span>
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

      <v-menu v-if="loginStatus"
        :close-on-click="closeOnClick"
        :close-on-content-click="closeOnContentClick"
        :offset-y="offsetY"
      >
        <template v-slot:activator="{ on }">
          <v-btn class="mx-2" 
           icon v-on="on"
          >
            <v-icon>mdi-account</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-list-item
            v-for="(option, index) in dropDown"
            :key="index"
            @click=triggerDropDown(index)
          >
            <v-list-item-title>{{ option.title }}</v-list-item-title>
            <v-list-item-avatar>
              <v-icon>{{ option.icon }}</v-icon>
            </v-list-item-avatar>
          </v-list-item>
        </v-list>
      </v-menu>

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
    loginStatus : Boolean,
    userName : String
  },
  data: () => ({
    dropDown : [
      {title: "Settings", icon: "mdi-settings"},
      {title: "Log Out", icon: "mdi-logout"},
    ],
    closeOnClick : true,
    closeOnContentClick : true,
    offsetY : true,
  }),
  methods: {
    displayCompany(){
      const path = `/company/${this.userName}`
      if (decodeURI(this.$route.path) !== path){
        this.$router.push({name: 'Company', params: {loginStatus: this.loginStatus, 
          userName: this.userName, creator: this.userName}})
      }
    },
    triggerDropDown(arg){
      if (arg == 0){
        //settings
      } else if (arg == 1){ //logout
        if (this.$router.currentRoute.path != "/home"){
          this.$router.push({ path: '/home'})
        }
        this.$emit('logout', [false, ""])
      }
    },
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
