<template>
  <div class="account">
    <v-container>
      <v-card class="text-left pa-5 ma-5">
        <v-row>
          <v-col>
            <span class="display-1 mr-10">{{ event['_eventName'] }}</span>
            <span class="grey--text">{{ event['_creator'] }}</span>
            <v-icon
              @click="toCompany"
            >
              mdi-chevron-right
            </v-icon>
          </v-col>
        </v-row>

        <v-row>
          <v-col
            cols="12"
            md="6"
          >
            <h3>Address</h3>
            <p>{{ event['_eventAddress'] }}</p>
            <h3>Category</h3>
            <p>{{ event['_eventType'] }}</p>
          </v-col>

          <v-col
            cols="12"
            md="6"
          >
            <!-- Intro -->
            <v-row>
              <v-col>
                <h3>Intro</h3>
              </v-col>
              <v-col align="right">
                <v-dialog v-model="dialog" v-if="validCreator" persistent max-width="600px">
                  <template v-slot:activator="{ on }">
                    <v-icon
                      small
                      class="mr-2"
                      v-on="on"
                    >
                      mdi-border-color
                    </v-icon>
                  </template>
                  <v-card>
                    <v-card-title>
                      <span class="headline">Edit Intro</span>
                    </v-card-title>
                    <v-card-text>
                      <v-container>
                        <v-row>
                          <v-col cols="12">
                            <v-form
                              ref="form"
                              v-model="valid"
                              :lazy-validation="lazy"
                            >
                              <v-text-field
                                v-model="intro"
                                :counter="500"
                                :rules="introRules"
                                label="Intro"
                                required
                              ></v-text-field>
                            </v-form>
                          </v-col>
                        </v-row>
                      </v-container>
                    </v-card-text>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn color="blue darken-1" text @click="cancel">Cancel</v-btn>
                      <v-btn color="blue darken-1" text @click="edit">Save</v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-col>
            </v-row>
            <v-row>
              <v-col>{{ event['_intro'] }}</v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-card>
      
      <v-row>
        <v-col
          cols="12"
          md="7"
        >
          <!-- Comments -->
          <v-card class="pa-5 ma-5">
            <div>
              <v-row>
                <v-col>
                  <v-btn class="ma-2" text icon color="blue darken-1">
                    <v-icon
                      @click="incrementLike"
                      large
                    >
                      mdi-thumb-up
                    </v-icon>
                  </v-btn>
                  {{ likeCount }}
                </v-col>

                <v-col>
                  <v-btn class="ma-2" text icon color="red darken-2">
                    <v-icon
                      @click="incrementDislike"
                      large
                    >
                      mdi-thumb-down
                    </v-icon>
                  </v-btn>
                  {{ dislikeCount }}
                </v-col>

                <v-col>
                  <v-btn class="ma-2" text icon color="grey darken-3">
                    <v-icon large>mdi-message-text</v-icon>
                  </v-btn>
                  {{ commentCount }}
                </v-col>
              </v-row>
            </div>

            <v-card-title>Comments</v-card-title>
              <v-list>
                <v-list-group color="primary"
                  v-for="(comment, i) in commentList"
                  :key="i"
                >
                  <template v-slot:activator>
                    <v-icon>mdi-account</v-icon>
                    <v-divider inset></v-divider>
                    <v-list-item-title>
                      <v-row>
                        <v-col class="text-left justify-center align-center">
                        <h5 v-if="comment[0].slice(0, 42) === event['_eventAddress']">{{ event['_creator'] }}</h5>
                        <h5 v-else>{{comment[0].slice(0, 42)}}</h5>
                        <p>
                          {{comment[0].slice(42)}}
                        </p>
                        </v-col>
                      </v-row>
                    </v-list-item-title>
                  </template>
                  <v-list-item round
                    v-for="(reply, j) in comment.slice(1)"
                    :key="`${reply}${j}`"
                  >
                    <v-list-item-content>
                      <v-row>
                        <v-col class="text-left justify-center align-center">
                        <h5 v-if="reply.slice(0, 42) === event['_eventAddress']">{{ event['_creator'] }}</h5>
                        <h5 v-else>{{reply.slice(0, 42)}}</h5>
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
                <v-list-item-title>
                  <v-row>
                    <v-col>
                      <v-textarea
                        name="Reply"
                        :label=self
                        v-model="commentContent"
                        rounded filled
                        auto-grow
                        rows="1"
                        append-icon="mdi-send"
                        @click:append="storeComment()"
                        placeholder="Type a reply..."
                      ></v-textarea>
                    </v-col>
                  </v-row>
                  </v-list-item-title>
              </v-list>
          </v-card>
        </v-col>

        <v-col
          cols="12"
          md="5"
        >
          <!-- Donate -->
          <v-card class="pa-5 ma-5">
            <v-col v-if="!loginStatus">
              <v-row justify="end" v-if="event['_ongoing']">
                <v-dialog v-model="dialog" persistent max-width="600px">
                  <template v-slot:activator="{ on }">
                    <v-btn color="deep-orange darken-1" dark v-on="on">Donate</v-btn>
                  </template>
                  <v-card>
                    <v-card-title>
                      <span class="headline">Donate</span>
                    </v-card-title>
                    <v-card-text>
                      <v-container>
                        <v-row>
                          <v-col cols="12">
                            <v-text-field
                              v-model="amount"
                              :rules="amountRules"
                              label="Amount"
                              required
                            ></v-text-field>
                          </v-col>
                        </v-row>
                      </v-container>
                    </v-card-text>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn color="blue darken-1" text @click="cancelDonate">Cancel</v-btn>
                      <v-btn color="blue darken-1" text @click="donate">Confirm</v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-row>
              <!-- Past -->
              <v-row justify="end" v-else>
                <v-btn disabled>Closed</v-btn>
              </v-row>
            </v-col>
            
            <v-col v-else>
              <v-row justify="end" v-if="event['_ongoing']">
                <v-btn disabled>Donate</v-btn>
              </v-row>
              <!-- Past -->
              <v-row justify="end" v-else>
                <v-btn disabled>Closed</v-btn>
              </v-row>
            </v-col>

            <!-- Progress -->
            <v-col>
              <v-container class="text-right">
                <v-card-text>{{ (event['_receivedAmount']*1.0/event['_targetAmount'] * 100).toFixed(2) }}%</v-card-text>
                <v-progress-linear
                  disabled
                  :background-opacity=0.3
                  :value="event['_receivedAmount']*1.0/event['_targetAmount'] * 100"
                  rounded
                  color="deep-orange lighten-1"
                  height="8"
                  dark
                >
                </v-progress-linear>
                <v-card-text>{{ event['_receivedAmount'] }} / {{ event['_targetAmount'] }}</v-card-text>
              </v-container>
            </v-col>
          </v-card>

          <!-- Transactions -->
          <v-card class="pa-5 ma-5">
            <v-card-title>Transactions</v-card-title>
            <v-simple-table>
              <template v-slot:default>
                <tbody class="text-left">
                  <tr>
                    <th>Donor Address</th>
                    <th>Donation Amount</th>
                    <td></td>
                  </tr>
                  <tr 
                    v-for="(tx, i) in txList"
                    :key="i"
                  >
                    <td>{{ tx.address }}</td>
                    <td>{{ tx.amount }}</td>
                    <td></td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </v-card>

        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Account',
  props: {
    loginStatus: Boolean,
    eventAddress: String,//Event address
    userName: String,
    // Creator: String,
    state: Object
  },
  data: () => ({
    self: null,
    event: {},
    eventId: null,
    balance: null,
    txCount: 0,
    txList: [], //list of {'address': addr, 'amount': $} to preserve insert order
    likeCount: 0,
    dislikeCount: 0,
    commentCount: 0,
    commentList: [],
    validCreator: false,
    replyContent: "",
    commentContent: "",
    // for intro
    valid: true,
    lazy: false,
    intro: "",
    introRules: [
      v => !!v || 'Intro is required',
      v => (v && v.length <= 500) || 'Intro must be less than 500 characters',
    ],
    // for donate
    dialog: false,
    amount: "",
    amountRules: [
      v => !!v || 'Amount is required'
    ],
  }),
  methods: {
    async donate() {
      let donorBalance = await this.state.contract.methods.getBalance(this.self).call({from: this.self});
      if ((donorBalance - this.amount) < 0) {
        alert('Donor does not have enough tokens!');
      }
      else if (this.event['_ongoing'] === false) {
        alert('The event has ended.');
        this.dialog = false;
      }
      else {
        this.dialog = false;
        await this.state.contract.methods.donate(this.self, this.event['_eventAddress'], this.amount).send({from: this.self});
        this.event = await this.state.contract.methods.eventList(this.eventId).call({from: this.self});
        this.balance = await this.state.contract.methods.getBalance(this.event['_eventAddress']).call({from: this.self});
        this.updateTx();
      }
    },
    cancelDonate() {
      this.dialog = false;
    },
    toCompany() {
      this.$router.push({name: 'Company', params: {loginStatus: this.loginStatus, 
        userName: this.userName, creator: this.event['_creator'], state: this.state}});
    },
    checkCreator(){
      if (this.userName === this.event['_creator']){
        this.validCreator = true;
      }
    },
    async edit() {
      if (this.$refs.form.validate()) {
        this.dialog = false;
        await this.state.contract.methods.editIntro(this.eventId, this.intro).send({from: this.self});
        this.event = await this.state.contract.methods.eventList(this.eventId).call({from: this.self});
      }
    },
    cancel() {
      this.dialog = false;
      this.intro = this.event['_intro'];
    },
    async getTx() {
      this.txCount = await this.state.contract.methods.getTxCount(this.eventId).call({from:this.self});
      for (let i = 0; i < this.txCount; i++){
        let result = await this.state.contract.methods.getEventTXbyIdx(this.eventId, i).call({from:this.self});
        let {0: addr, 1: amount} = result;
        this.txList.push({'address': addr, 'amount': amount});
      }
    },
    async updateTx() {
      // after donate
      let newCount =  await this.state.contract.methods.getTxCount(this.eventId).call({from:this.self});
      for (let i = this.txCount; i < newCount; i++){
        let result = await this.state.contract.methods.getEventTXbyIdx(this.eventId, i).call({from:this.self});
        let {0: addr, 1: amount} = result;
        this.txList.push({'address': addr, 'amount': amount});
      }
      this.txCount = newCount;
    },
    async getComments() {
      this.commentCount = await this.state.contract.methods.getCommentCount(this.eventId).call({from:this.self});
      for (let i = 0; i < this.commentCount; i++){
        let result = await this.state.contract.methods.getCommentsbyIdx(this.eventId, i).call({from:this.self});
        this.commentList.push(result);
      }
    },
    async updateReplies() {
      let newCount = await this.state.contract.methods.getCommentCount(this.eventId).call({from:this.self});
      for (let i = this.commentCount; i < newCount; i++){
        let result = await this.state.contract.methods.getCommentsbyIdx(this.eventId, i).call({from:this.self});
        this.commentList.push(result);
      }
      this.commentCount = newCount;
    },
    async storeReply(cIdx) {
      if (this.commentList[cIdx].length < 10 && this.replyContent){
        await this.state.contract.methods.updateReply(this.eventId, cIdx, this.self + this.replyContent).send({from: this.self});
        this.commentList[cIdx].push(this.self + this.replyContent);
        this.replyContent = "";
      } else {
        alert("Reply count has reached max amount!")
      }
    },
    async storeComment() {
      if (this.commentContent){
        await this.state.contract.methods.updateComment(this.eventId, this.self + this.commentContent).send({from: this.self});
        this.updateReplies();
        this.commentContent = "";
      }
    },
    async incrementLike() {
      await this.state.contract.methods.updateLikes(this.eventId, +this.likeCount+1).send({from: this.self});
      this.likeCount = +this.likeCount+1;
    },
    async incrementDislike() {
      await this.state.contract.methods.updateDislikes(this.eventId, +this.dislikeCount+1).send({from: this.self});
      this.dislikeCount = +this.dislikeCount+1;
    },
  },
  async mounted() {
    this.self = this.state.accounts[0];
    this.eventId = await this.state.contract.methods.addr2EventId(this.eventAddress).call({from: this.self}) - 1;
    this.event = await this.state.contract.methods.eventList(this.eventId).call({from: this.self});
    this.balance = await this.state.contract.methods.getBalance(this.event['_eventAddress']).call({from: this.self});
    this.checkCreator();
    this.intro = this.event['_intro'];
    this.getTx();
    this.getComments();
    this.likeCount = this.event['_likes'];
    this.dislikeCount = this.event['_dislikes'];
  }
}
</script>