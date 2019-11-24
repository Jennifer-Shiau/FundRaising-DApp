<template>
  <v-app>
    <div id="app">
      <ToolBar></ToolBar>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </div>
  </v-app>
</template>

<script>
import ToolBar from './components/ToolBar';
export default {
    components: { ToolBar },
    name: 'App',
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
