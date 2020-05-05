<template>
  <div>
    <h1>Project List</h1>
    <div class="nav">
      <p>
        <router-link to="/login">logout</router-link>
      </p>
      <p>
        <router-link to="/home">Home</router-link>
      </p>
    </div>
    <div class="main">
      <form @submit.prevent="onSubmit">
        <h2>Filter By:</h2>
        <label for="person">Friend</label>
        <select v-model="friend">
          <option
            v-for="friend in friends"
            :key="friend.id"
            :value="friend.id"
          >{{friend.attributes.firstName}}</option>
        </select>
        <label for="topic">Topic</label>
        <select v-model="topic">
          <option
            v-for="topic in topics"
            :key="topic.id"
            :value="topic.id"
          >{{topic.attributes.name}}</option>
        </select>
        <button class="btn btn-primary">Go</button>
      </form>
      <h1>Projects</h1>
      <ul>
        <li v-for="p in projects" :key="p.id">{{p.attributes.name}}</li>
      </ul>
    </div>
  </div>
</template>

<script>
import { apiService } from "../_services";
import { jsonResponseHandler } from "../_services";
export default {
  data() {
    return {
      friend: null,
      topic: null,
      friends: [],
      topics: [],
      projects: []
    };
  },

  methods: {
    onSubmit(e) {
      this.submitted = true;
      this.loadProjects()
        .then(response => this.setData(response))
        .catch(function(error) {
          console.log(error);
        });
    },
    loadProjects() {
      const { friend, topic } = this;
      return apiService.post("api/v1/projects/search", { friend, topic });
    },

    setData(response) {
      this.setFriends(response.data);
      this.setProjects(response.data);
      this.setTopics(response.data);
    },

    setProjects(jsonResponse) {
      this.projects = this.getSortedData(jsonResponse, "projects", "name");
    },

    setFriends(jsonResponse) {
      this.friends = this.getSortedData(jsonResponse, "friends", "firstName");
    },

    setTopics(jsonResponse) {
      this.topics = this.getSortedData(jsonResponse, "topics", "name");
    },
    getSortedData(jsonResponse, data, key) {
      return jsonResponseHandler.setSortedData(jsonResponse, data, key);
    }
  },

  beforeRouteEnter: function(to, from, next) {
    next(vm =>
      vm
        .loadProjects()
        .then(function(response) {
          vm.setData(response);
        })
        .catch(function(error) {
          console.log(error);
          vm.$router.push("/error");
        })
    );
  }
};
</script>
