<template>
    <v-container height="200">
        <v-layout row wrap align-center>
            <v-flex xs12 sm6 offset-sm3>
             <v-card align="center">
                <v-responsive :aspect-ratio="2/1">
                  <v-card-text>
                    <h2 class="font-weight-light display-1">Login</h2>
                  </v-card-text>
                  <v-container>
                      <v-form
                        ref="form"
                        v-model="valid"
                        :lazy-validation="lazy"
                      >
                        <v-text-field
                          v-model="username"
                          :counter="10"
                          :rules="usernameRules"
                          label="Username"
                          required
                        ></v-text-field>

                        <v-text-field
                            v-model="password"
                            :rules="passwordRules"
                            label="Password"
                            required
                        ></v-text-field>

                        <v-btn
                          class="mr-4"
                          @click="login"
                        >
                          Login
                        </v-btn>

                        <v-btn
                          class="mr-4"
                          @click="reset"
                        >
                          Reset Form
                        </v-btn>
                    </v-form>
                  </v-container>
                </v-responsive>
              </v-card>
            </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
// @ is an alias to /src

export default {
    name: 'Login',
    props: {
      state: Object
    },
    data: () => ({
      valid: true,
      username: '',
      usernameRules: [
        v => !!v || 'Username is required',
        v => (v && v.length <= 10) || 'Username must be less than 10 characters',
      ],
      password: '',
      passwordRules: [
        v => !!v || 'Password is required',
        v => (v && v.length >= 6) || "Password must be longer than 6 characters",
      ],
      lazy: false,
    }),

    methods: {
      async login () {
        if (this.$refs.form.validate()) {
          let result = await this.state.contract.methods.verifyPassword(this.username, this.password).call({from: this.state.accounts[0]})
          if (result === true) {
            this.$router.push({ path: '/home'})
            this.$emit('login', [true, this.username])
          }
          else {
            alert('Wrong username or password!')
            this.reset()
          }
        }
      },
      reset () {
        this.$refs.form.reset()
      },
    },
  }
</script>