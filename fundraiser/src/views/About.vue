<template>
  <div class="about">
    <div align="center">
      <v-img src="https://i.imgur.com/h8UXNeF.png" aspect-ratio="3.7" max-width="1200"></v-img>
    </div>
    <br/><br/><br/>
    <div class="display-3 font-weight-light font-italic amber--text text--darken-2">
      A Few Clicks Make the World Better.
    </div>
    <br/><br/>
    <p class="title text--primary">
      The Fundraising DApp makes donations safer, easier, and more trustworthy with blockchain features.
    </p>
    <br/><br/>

    <!-- Why blockchain? -->
    <v-container>
      <br/><br/>
      <div class="display-2 font-weight-bold light-green--text text--darken-2">Why blockchain?</div>
      <br/><br/>
      <v-row>
        <v-col>
          <h1>Safety</h1><br/>
          <p class="body-1 text--primary" align="left">
            The cryptographic hash function keeps transactions 
            immutable and thus ensures their safety. 
          </p>
        </v-col>
        <v-col>
          <h1>Transparency</h1><br/>
            <p class="body-1 text--primary" align="left">
              Decentralization allows people to easily examine whether the organizations use your donations properly. 
            </p>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <h1>Efficiency</h1><br/>
          <p class="body-1 text--primary" align="left">
            With a MetaMask account, it takes only a few clicks to donate and provide immediate assistance to those in need. 
            This website collects all kinds of charity and crowdsourcing organizations around the world.
          </p>
        </v-col>
        <v-col>
          <h1>No Middlemen Fees</h1><br/>
          <p class="body-1 text--primary" align="left">
            A centralized fundraising platform requires middlemen fees to maintain the server. With our decentralized app, all donations will be free.
          </p>
        </v-col>
      </v-row>
    </v-container>

    <!-- How it works -->
    <v-container>
      <br/><br/>
      <div class="display-2 light-green--text font-weight-bold text--darken-2">How it works</div>
      <br/><br/>

        <v-expansion-panels focusable>
          <v-expansion-panel>
            <v-expansion-panel-header class="title light-green lighten-4">
              I'm an organization (Raise Funds)
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              <v-card
                class="mx-auto"
                align="left"
              >
                <v-card-text>
                  <p class="display-1 text--primary">
                    STEP 1  Create Fundraising DApp Account
                  </p>
                  <p class="subtitle-1 text--grey">
                    Skip this step if you aready have an account.
                  </p>
                  <div class="body-1 text--primary">
                    <p>Click <kbd>SIGN UP</kbd> on the upper right corner of the window.</p>
                    <p>Enter your username and password.</p>
                    <p>Edit your profile: add descriptions about your organization, 
                      and add links to your own website or social media.</p>
                    <p>On the organization profile page, donors can press thumbs up or down for your organization. 
                      News and stories can be posted to interact with donors.</p>
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
                    <p>Go to the <kbd>PROFILE</kbd> page and click <kbd>CREATE EVENT</kbd>.</p>
                    <p>Enter event information.</p>
                    <p>Each event needs its own MetaMask account.</p>
                    <p>When the received donation amount reaches the target amount, 
                      the event will be shut down and moved to "Past Events". 
                      Users will no longer be able to donate to this event.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 4  Post
                  </p>
                  <div class="body-1 text--primary">
                    <p>Go to the <kbd>PROFILE</kbd> page.</p>
                    <p>We only support pure text posts.</p>
                    <p>Donors can reply to your posts.</p>
                  </div>
                </v-card-text>
              </v-card>
            </v-expansion-panel-content>
          </v-expansion-panel>

          <v-expansion-panel>
            <v-expansion-panel-header class="title light-green lighten-4">
              I'm a donor (Make Donations)
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
                    <p>You do NOT need to create an account in our website.</p>
                    <p>Log in with your MetaMask account.</p>
                    <p>If you do NOT have a MetaMask account, create an account and deposit cryptocurrency.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 2  Explore
                  </p>
                  <div class="body-1 text--primary">
                    <p>On the <kbd>HOME</kbd> page, you can explore ongoing events by category.</p>
                    <p>Information, posts, ongoing events and past events of organizations are also available.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 3  Feedback
                  </p>
                  <div class="body-1 text--primary">
                    <p>Provide feedback for an organization or an event by pressing thumbs up or down.</p>
                    <p>You can leave comments to events or below posts by organizations.</p>
                  </div>

                  <p class="display-1 text--primary">
                    STEP 4  Donate
                  </p>
                  <div class="body-1 text--primary">
                    <p>Information of an event is displayed on the event page.</p>
                    <p>Click <kbd>DONATE</kbd> and enter the amount you want to donate.</p>
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
      <div class="display-2 light-green--text font-weight-bold text--darken-2">GOAL</div>
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
      rounded
      class="display-1 font-weight"
      width="250"
      height="75"
      depressed
      color="yellow darken-2"
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