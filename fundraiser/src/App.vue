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
        <v-btn @click="callContract"
        >Call contract</v-btn>
        <router-view @login="changeToolBar" @signup="changeToolBar" 
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
    }),
    methods: {
      changeToolBar(arg){
        this.loginStatus = arg[0]
        this.userName = arg[1]
      },
      async callContract(){//for debugging
        try {
          // console.log(this.state)
          var self = this.state.accounts[0]
          console.log(self)
          var _event = "0x48C6Ed71726E4800210bF748C8C2909acDd24b02"
          await this.state.contract.methods.createEvent("_eventName", "_creator", "_intro", 100, _event, "Natural Disaster").send({from: self})
          var b1 = await this.state.contract.methods.getBalance(self).call({from: self})
          console.log(b1)
          await this.state.contract.methods.donate(self, _event, 10).send({from: self})
          var b2 = await this.state.contract.methods.getBalance(self).call({from: self})
          console.log(b2)
          console.log("Success!")
        } catch (error) {
          alert('Fail!')
          console.log(error)
        }
      }
    },
    async mounted(){
      try {
        this.state.web3 = await getWeb3();
        this.state.accounts = await this.state.web3.eth.getAccounts();
        const networkId = await this.state.web3.eth.net.getId();
        const deployedNetwork = await Fundraiser.networks[networkId];
        console.log(deployedNetwork.address)
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
