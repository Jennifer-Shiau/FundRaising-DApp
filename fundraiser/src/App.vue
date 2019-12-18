<template>
  <v-app>
    <div id="app">
      <ToolBar 
        v-bind:login-status="loginStatus"
        v-bind:user-name="userName"
        @logout="changeToolBar"
      >
      </ToolBar>
      <v-container fluid>
        <v-skeleton-loader
          v-if="!stateReady"
          class="mx-auto"
          max-width="600"
          max-height="500"
          type="card"
        ></v-skeleton-loader>
        <router-view @login="changeToolBar" @signup="changeToolBar" v-if="stateReady"
          v-bind:user-name="userName"
          v-bind:state="state"
          v-bind:login-status="loginStatus"
        ></router-view>
      </v-container>
    </div>
  </v-app>
</template>

<script>
import ToolBar from './components/ToolBar';
import getWeb3 from "./utils/getWeb3";
import Fundraiser from "../../build/contracts/Fundraiser.json"

export default {
    components: { ToolBar },
    name: 'App',
    data: () => ({
      loginStatus: false,
      userName: "",
      state: {
        web3: {},
        accounts: [],
        contract: {}
      },
      stateReady: false
    }),
    methods: {
      changeToolBar(arg){
        this.loginStatus = arg[0]
        this.userName = arg[1]
      },
    },
    async beforeCreate(){
      try {
        this.state.web3 = await getWeb3();
        this.state.accounts = await this.state.web3.eth.getAccounts();
        const networkId = await this.state.web3.eth.net.getId();
        const deployedNetwork = await Fundraiser.networks[networkId];
        this.state.contract = new this.state.web3.eth.Contract(
          Fundraiser.abi,
          deployedNetwork && deployedNetwork.address,
        );
      } catch (error) {
        alert(
          `Failed to load web3, accounts, or contract. Check console for details.`,
        );
        console.error(error);
      }
      this.stateReady = true
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
