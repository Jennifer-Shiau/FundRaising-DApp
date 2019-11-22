<template>
  <div class="home">
    <h3>Home</h3>
    <LandingPage/>
  </div>
</template>

<script>
// @ is an alias to /src
import LandingPage from '@/components/LandingPage.vue'

export default {
  name: 'Home',
  components: {
    LandingPage,
  }
}
</script>
