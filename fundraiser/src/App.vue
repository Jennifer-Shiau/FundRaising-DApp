<template>
  <v-app>
    <div id="app">
      <ToolBar 
        v-bind:login-status="loginStatus"
        v-bind:account-type="accountType"
        v-bind:user-name="userName"
        @logout="changeToolBar"
      >
      </ToolBar>
      <v-container fluid>
        <router-view @login="changeToolBar" @signup="changeToolBar" 
          v-bind:user-name="userName"
        ></router-view>
      </v-container>
    </div>
  </v-app>
</template>

<script>
import ToolBar from './components/ToolBar';
export default {
    components: { ToolBar },
    name: 'App',
    data: () => ({
      loginStatus: false,
      accountType: "",
      userName: ""
    }),
    methods: {
      changeToolBar(arg){
        this.accountType = arg[0]
        this.loginStatus = arg[1]
        this.userName = arg[2]
      }
    }
};

</script>


<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  align-content: center;
  justify-content: center;
}
</style>
