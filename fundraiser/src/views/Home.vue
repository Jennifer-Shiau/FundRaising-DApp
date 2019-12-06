<template>
  <div class="home">
    <LandingPage 
      v-bind:login-status="loginStatus"
      v-bind:state="state"
    ></LandingPage>
  </div>
</template>

<script>
// @ is an alias to /src
import LandingPage from '@/components/LandingPage.vue'

export default {
  name: 'Home',
  props: {
    loginStatus: Boolean,
    state: Object
  },
  components: {
    LandingPage,
  }
}
</script>
