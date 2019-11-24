<template>
  <div class="create">
    <br><h2>Create new event</h2><br>
    <v-container>
      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="2">
          <v-subheader style="font-size:18px">Name</v-subheader>
        </v-col>
        <v-col cols="6">
          <v-text-field
            label="Event name"
            value=""
          ></v-text-field>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="2">
          <v-subheader style="font-size:18px">Amount</v-subheader>
        </v-col>
        <v-col cols="6">
          <v-text-field
            label="Target amount"
            value=""
            suffix="ETH"
          ></v-text-field>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="2">
          <v-subheader style="font-size:18px">Category</v-subheader>
        </v-col>
        <v-col cols="8">
          <v-radio-group v-model="row" row>
            <v-radio label="Category 1" value=""></v-radio>
            <v-radio label="Category 2" value=""></v-radio>
            <v-radio label="Category 3" value=""></v-radio>
            <v-radio label="Other" value=""></v-radio>
          </v-radio-group>
        </v-col>
      </v-row>
    </v-container>
    <v-btn
      to = "/Company"
    >
      Create
    </v-btn>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Create',
  components: {

  }
}
</script>