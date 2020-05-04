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
        <!--input type="text" v-model="friend" name="friend" class="form-control" /-->
        <select v-model="friend">
          <option v-for="friend in friends" :key="friend.id" value>{{friend.attributes.firstName}}</option>
        </select>
        <label for="topic">Topic</label>
        <select v-model="topic">
          <option v-for="topic in topics" :key="topic">{{topic}}</option>
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
      const { friend, topic } = this;
      this.loadProjects();
    },
    loadProjects(vm) {
      const { friend, topic } = this;
      apiService
        .post("api/v1/projects/search", { friend, topic })
        .then(function(response) {
          vm.setFriends(response.data);
          vm.setProjects(response.data);
          vm.setTopics(vm.projects);
        })
        .catch(function(error) {
          vm.$router.push("/error");
        });
    },
    extractData(data, key) {
      return data[key];
    },
    setTopics(projects) {
      //let projects = this.extractData(payload, "projects");
      let topics = new Set();
      debugger;
      projects.forEach(project => {
        topics.add(project.attributes.topicName);
      });
      this.topics = Array.from(topics);
    },

    setProjects(payload) {
      let projects = this.extractData(payload, "projects");
      this.projects = projects.data.sort(function(a, b) {
        return a.attributes.name > b.attributes.name ? 1 : -1;
      });
    },
    setFriends(payload) {
      let friends = this.extractData(payload, "friends");
      this.friends = friends.data.sort(function(a, b) {
        return a.attributes.firstName > b.attributes.firstName ? 1 : -1;
      });
    }
  },

  beforeRouteEnter: function(to, from, next) {
    next(vm => vm.loadProjects(vm));
  }
};
</script>
