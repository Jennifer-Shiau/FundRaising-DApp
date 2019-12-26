<template>
  <div class="about">
    <div align="center">
      <v-img src="https://i.imgur.com/RNovA1Y.png" aspect-ratio="2.1" max-width="600"></v-img>
    </div>
    <br/><br/><br/>
    <div class="display-3 font-weight-bold font-italic amber--text text--darken-2">
      Few Clicks Make the World Better.
    </div>
    <br/><br/><br/>
    <p class="title text--primary">
      In order to make the best of people's generosity, we introduce a DApp to make donations <br/>
      safer, easier, and more trustworthy with remarkable blockchain features.
    </p>
    <br/><br/>

    <!-- What's more -->
    <v-container>
      <br/><br/>
      <div class="display-2 light-green--text text--darken-2">What's more..</div>
      <br/><br/>
      <p class="body-1 text--primary" align="left">
        One of the key algorithms of blockchain, cryptographic hash function, keeps transactions 
        unchangeable and thus ensures their safety. Decentralization publishes all transactions' information, 
        which allows people to easily examine whether the organizations use your donations properly. 
        Connecting to the MetaMask account, it takes only few clicks to donate and provide immediate 
        assistance to those in need. This website collects all kinds of charity organizations around 
        the world. People will no longer waste time visiting different websites for different events.
      </p>
      <p class="body-1 text--primary" align="left">
        One website and few clicks can pass your kind heart to anywhere on earth reliably and without any danger.
      </p>
    </v-container>

    <!-- How it works -->
    <v-container>
      <br/><br/>
      <div class="display-2 light-green--text text--darken-2">How it works</div>
      <br/><br/>

        <v-expansion-panels focusable>
          <v-expansion-panel>
            <v-expansion-panel-header class="title light-green lighten-4">
              I’m an organization (recieve donations)
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <v-card
                class="mx-auto"
                align="left"
              >
                <v-card-text>
                  <p class="display-1 text--primary">
                    STEP 1  Create Account
                  </p>
                  <p class="subtitle-1 text--grey">
                    Skip this step if you aready have an account
                  </p>
                  <div class="body-1 text--primary">
                    <p>Click <kbd>SIGN UP</kbd> on the upper right corner of the window.</p>
                    <p>Enter your username and password.</p>
                    <p>(Optional) Edit your profile: upload a photo, add descriptions about yourself 
                      and links to your own website or social media.</p>
                    <p>In your profile, people can thumb up or down to your organization. 
                      You can post news on it and interact with doners.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 2  Log In
                  </p>
                  <div class="body-1 text--primary">
                    <p>Click <kbd>LOG IN</kbd> on the upper right corner of the window.</p>
                    <p>Enter your username and password.</p>
                    <p>Get started.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 3  Create Event
                  </p>
                  <div class="body-1 text--primary">
                    <p>Go to <kbd>COMPANY</kbd> page and click <kbd>CREATE EVENT</kbd></p>
                    <p>Enter event information.</p>
                    <p>Each event needs its own MetaMask account.</p>
                    <p>When the received donation amount achieves the target amount, 
                      the event will be automatically closed and moved to "Past Events". 
                      In this situation, people will no longer be able to donate to this event.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 4  Post
                  </p>
                  <div class="body-1 text--primary">
                    <p>Go to <kbd>COMPANY</kbd> page and click <kbd>+</kbd></p>
                    <p>We only support "text" post.</p>
                    <p>People and you can comment below your post.</p>
                  </div>
                </v-card-text>
              </v-card>
            </v-expansion-panel-content>
          </v-expansion-panel>

          <v-expansion-panel>
            <v-expansion-panel-header class="title light-green lighten-4">
              I’m a donor (make donations)
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <v-card
                class="mx-auto"
                align="left"
              >
                <v-card-text>
                  <p class="display-1 text--primary">
                    STEP 1  Log In
                  </p>
                  <div class="body-1 text--primary">
                    <p>You do NOT need to create any account in our website.</p>
                    <p>Log in with your MetaMask account.</p>
                    <p>If you do NOT have a MetaMask account, go create one and store some money, 
                      and you can get started.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 2  Explore
                  </p>
                  <div class="body-1 text--primary">
                    <p>On the <kbd>HOME</kbd> page, you can get recent events catagorized 
                      by different tags.</p>
                    <p>You can also see the information, posts, ongoing events and past events of organizations.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 3  Evaluation
                  </p>
                  <div class="body-1 text--primary">
                    <p>You can evaluate an organization or an event by thumbing up or down.</p>
                    <p>You can leave comments to events or below posts by organizations to tell people what you think.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 4  Donate
                  </p>
                  <div class="body-1 text--primary">
                    <p>On the event page, you can see all information about this event.</p>
                    <p>Click <kbd>DONATE</kbd> and enter the amount you want to donate</p>
                  </div>
                </v-card-text>
              </v-card>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
    </v-container>

    <!-- Goal -->
    <v-container>
      <br/><br/>
      <div class="display-2 light-green--text text--darken-2">GOAL</div>
      <br/><br/>
      <v-row justify="space-around">
        <v-col cols="3" align="center">
          <v-img src="https://i.imgur.com/9tVrIbz.png" aspect-ratio="1" max-width="200"></v-img>
          <div class="display-1 light-blue--text text--accent-4 mt-5">100+<br/>NATIONS</div>
        </v-col>

        <v-col cols="3" align="center">
          <v-img src="https://i.imgur.com/lDbbplB.png" aspect-ratio="1" max-width="200"></v-img>
          <div class="display-1 yellow--text text--darken-3 mt-5">1000+<br/>PROJECTS</div>
        </v-col>

        <v-col cols="3" align="center">
          <v-img src="https://i.imgur.com/EH5RxWa.png" aspect-ratio="1" max-width="200"></v-img>
          <div class="display-1 red--text text--lighten-2 mt-5">10000+<br/>DOLLARS</div>
        </v-col>
      </v-row>
    </v-container>

    <!-- Start -->
    <br/><br/><br/>
    <v-btn
      to="/home"
      class="display-1 font-weight-bold"
      width="250"
      height="75"
      depressed
      color="yellow accent-4"
      dark
    >
      START NOW
    </v-btn>
    <br/><br/><br/>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'About',
  components: {

  }
}
</script>