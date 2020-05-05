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
      <form @submit="onSubmit">
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
  mounted() {
    //alert(this.projects.size);
  },

  methods: {
    onSubmit(e) {
      this.submitted = true;
      this.loadProjects();
    },
    loadProjects(vm) {
      const { friend, topic } = this;
      apiService
        .post("api/v1/projects/search", { friend, topic })
        .then(function(response) {
          vm.setFriends(response.data);
          vm.setProjects(response.data);
          vm.setTopics(response.data);
        })
        .catch(function(error) {
          vm.$router.push("/error");
        });
    },

    setProjects(jsonResponse) {
      this.projects = this.setSortedData(jsonResponse, "projects", "name");
    },

    setFriends(jsonResponse) {
      this.friends = this.setSortedData(jsonResponse, "friends", "firstName");
    },

    setTopics(jsonResponse) {
      this.topics = this.setSortedData(jsonResponse, "topics", "name");
    },

    setSortedData(jsonResponse, collectionName, sortField) {
      return this.sortData(
        this.extractJsonData(jsonResponse, collectionName).data,
        sortField
      );
    },

    extractJsonData(data, key) {
      return data[key];
    },
    sortData(collection, key) {
      return collection.sort(function(a, b) {
        return a.attributes[key] > b.attributes[key] ? 1 : -1;
      });
    }
  },

  beforeRouteEnter: function(to, from, next) {
    next(vm => vm.loadProjects(vm));
  }
};
</script>
