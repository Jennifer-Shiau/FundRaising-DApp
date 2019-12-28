<template>
  <div class="company">
    <v-container>
      <v-row>
        <v-col
          cols="4"
        >
          <div align="center">
            <v-img src="https://i.imgur.com/UVOo14B.png" aspect-ratio="1" max-width="150"></v-img>
            <br>
            <v-row>
              <v-col></v-col>
              <v-col>
                <v-img src="https://i.imgur.com/zQOYAeS.png" aspect-ratio="1" max-width="50"></v-img>
              </v-col>
              <v-col>
                <v-img src="https://i.imgur.com/BiXsNgt.png" aspect-ratio="1" max-width="50"></v-img>
              </v-col>
              <v-col>
                <v-img src="https://i.imgur.com/dw77URG.png" aspect-ratio="1" max-width="50"></v-img>
              </v-col>
              <v-col></v-col>
            </v-row>
          </div>
        </v-col>

        <v-col
          cols="8"
        >
          <v-row v-if="postReady">
            <v-col cols="8" align="left">
              <h1>{{ creator }}</h1><br>
              <h3>About as</h3>
              <p>{{ org['_intro'] }}</p>
            </v-col>
            <v-col cols="4" v-if="validCreator">
              <v-btn
                @click="createEvent"
                color="primary"
                class="my-10"
              >
                Create Event
              </v-btn>
            </v-col>
          </v-row>
          
          <v-row>
            <v-col cols="8"></v-col>
            <v-col cols="2">
              <v-btn class="ma-2" text icon color="blue lighten-2">
                <v-icon large>mdi-thumb-up</v-icon>
              </v-btn>
              {{ likeCount }}
            </v-col>

            <v-col cols="2">
              <v-btn class="ma-2" text icon color="red lighten-2">
                <v-icon large>mdi-thumb-down</v-icon>
              </v-btn>
              {{ dislikeCount }}
            </v-col>
          </v-row>
        </v-col>
      </v-row>

      <v-flex>
        <v-tabs
          v-model="select"
          background-color="transparent"
          color="basil"
          grow
        >
          <v-tab>Post</v-tab>
          <v-tab>Ongoing Events</v-tab>
          <v-tab>Past Events</v-tab>
        </v-tabs>

        <v-tabs-items v-model="select">
          <v-tab-item>
            <v-list>
                <v-list-item-title>
                  <v-row>
                    <v-col>
                      <v-textarea
                        name="Reply"
                        :label=self
                        v-model="postContent"
                        auto-grow outlined
                        rows="5"
                        append-icon="mdi-send"
                        @click:append="storePost()"
                        placeholder="Post something..."
                      ></v-textarea>
                    </v-col>
                  </v-row>
                </v-list-item-title>
                <v-list-group color="primary"
                  v-for="(post, i) in posts.slice().reverse()"
                  :key="i"
                >
                  <template v-slot:activator>
                    <v-icon>mdi-account</v-icon>
                    <v-divider inset></v-divider>
                    <v-list-item-title>
                      <v-row>
                        <v-col class="text-left justify-center align-center">
                        <h5>{{ creator }}</h5>
                        <p>
                          {{post[0]}}
                        </p>
                        </v-col>
                      </v-row>
                    </v-list-item-title>
                  </template>
                  <v-list-item round
                    v-for="(reply, j) in post.slice(1)"
                    :key="`${reply}${j}`"
                  >
                    <v-list-item-content>
                      <v-row>
                        <v-col class="text-left justify-center align-center">
                        <h5>{{reply.slice(0, 42)}}</h5>
                        <p>
                          {{reply.slice(42)}}
                        </p>
                        </v-col>
                      </v-row>
                    </v-list-item-content>
                  </v-list-item>
                  <v-list-item
                  >
                    <v-list-item-content>
                      <v-row>
                        <v-col>
                          <v-textarea
                            name="Reply"
                            :label=self
                            v-model="replyContent"
                            rounded filled
                            auto-grow
                            rows="1"
                            append-icon="mdi-send"
                            @click:append="storeReply(i)"
                            placeholder="Type a reply..."
                          ></v-textarea>
                        </v-col>
                      </v-row>
                    </v-list-item-content>
                  </v-list-item>
                </v-list-group>
              </v-list>
          </v-tab-item>

          <v-tab-item>
            <v-list class="elevation-1" v-if="eventReady">
              <v-list-item-group>
                <v-list-item
                  v-for="(event, i) in ongoingEvents"
                  :key="i"
                  @click="visitEventPage(event['_eventAddress'])"
                >
                  <v-list-item-content>
                      {{ event['_eventName'] }}
                  </v-list-item-content>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </v-tab-item>

          <v-tab-item>
            <v-list class="elevation-1" v-if="eventReady">
              <v-list-item-group>
                <v-list-item
                  v-for="(event, i) in pastEvents"
                  :key="i"
                  @click="visitEventPage(event['_eventAddress'])"
                >
                  <v-list-item-content>
                      {{ event['_eventName'] }}
                  </v-list-item-content>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </v-tab-item>
        </v-tabs-items>
      </v-flex>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Company',
  props: {
    userName: String,
    creator: String,
    loginStatus: Boolean,
    state: Object
  },
  data: () => ({
    self: null,
    select: 0,
    ongoingEvents: [],
    pastEvents: [],
    org: null,
    orgId: null,
    posts: [],
    postContent: "",
    replyContent: "",
    validCreator: false,
    eventReady: false,
    likeCount: 87,
    dislikeCount: 78,
  }),
  methods: {
    createEvent(){
      this.$router.push({name: 'Create', params: {loginStatus: this.loginStatus, creator: this.userName, 
        state: this.state}})
    },
    visitEventPage(eventAddress){
      this.selectEvent = eventAddress
      this.$router.push({name: 'Account', params: {eventAddress: this.selectEvent, loginStatus: this.loginStatus,
        userName: this.userName, state: this.state}})
    },
    checkCreator(){
      if (this.userName === this.creator){
        this.validCreator = true;
      }
    },
    async getOrgNPosts(){
      this.orgId = await this.state.contract.methods.creatorName2OrgId(this.creator).call({from: this.self});
      this.org = await this.state.contract.methods.orgList(this.orgId).call({from:this.self});
      this.getPosts()
    },
    async getEventList(){
      this.ongoingEvents = []
      let len = await this.state.contract.methods.getEventListLength().call({from: this.self});
      for (let i = 0; i < len; i++) {
        let e = await this.state.contract.methods.eventList(i).call({from: this.self});
        if (e['_creator'] === this.creator) {
          if (e['_ongoing'] === true) {
            this.ongoingEvents.push(e);
          }
          else {
            this.pastEvents.push(e);
          }
        }
      }
      this.eventReady = true;
    },
    async getPosts() {
      console.log(this.orgId)
      this.postCount = await this.state.contract.methods.getPostCount(this.orgId).call({from:this.self});
      for (let i = 0; i < this.postCount; i++){
        let p = await this.state.contract.methods.getPostsbyIdx(this.orgId, i).call({from:this.self});
        this.posts.push(p);
      }
      this.postReady = true;
    },
    async storePost() { // store new post into contract
      if (this.postContent){
        await this.state.contract.methods.updatePost(this.orgId, this.postContent).send({from: this.self});
        this.updatePosts();
        this.postContent = "";
      }
    },
    async updatePosts() { // update frontend this.posts list
      let newCount = await this.state.contract.methods.getPostCount(this.orgId).call({from:this.self});
      for (let i = this.postCount; i < newCount; i++){
        let p = await this.state.contract.methods.getPostsbyIdx(this.orgId, i).call({from:this.self});
        this.posts.push(p);
      }
    },
    async storeReply(pIdx){ // store reply into contract and update frontend
      if (this.posts[pIdx].length < 10 && this.replyContent){
        await this.state.contract.methods.updatePostReply(this.orgId, pIdx, this.self + this.replyContent).send({from: this.self});
        this.posts[pIdx].push(this.self + this.replyContent);
        this.replyContent = "";
      } else {
        alert("Reply count has reached max amount!")
      }
    },
  },
  watch: {
    creator: {
      handler() {
        this.self = this.state.accounts[0];
        this.eventReady = false;
        this.postReady = false;
        this.getOrgNPosts()
        console.log("done org")
        console.log("done get posts")
        this.getEventList()
        this.checkCreator()
      },
      immediate: true,
    }
  },
}
</script>