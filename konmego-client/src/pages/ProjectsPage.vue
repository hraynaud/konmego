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
        <label for="person">person</label>
        <input type="text" v-model="person" name="person" class="form-control" />
        <label for="topic">topic</label>
        <input type="text" v-model="topic" name="topic" class="form-control" />
        <label for="visibility">visibility</label>
        <input type="text" v-model="visibility" name="visibility" class="form-control" />
        <label for="depth">depth</label>
        <input type="text" v-model="depth" name="depth" class="form-control" />
        <button class="btn btn-primary">Search</button>
      </form>
      <ul>
        <li v-for="p in projects" :key="p.id">{{p.name}}</li>
      </ul>
    </div>
  </div>
</template>

<script>
import { apiService } from "../_services";
export default {
  data() {
    return {
      person: null,
      visibility: null,
      depth: null,
      topic: null,
      projects: []
    };
  },
  mounted() {
    //alert(this.projects.size);
  },

  methods: {
    onSubmit(e) {
      this.submitted = true;
      debugger;
      const { person, visibility, depth, topic } = this;

      this.loadProjects();
    },
    loadProjects(vm) {
      const { person, visibility, depth, topic } = this;
      apiService
        .post("api/v1/projects/search", { person, visibility, depth, topic })
        .then(function(response) {
          vm.projects = response.data.sort(function(a, b) {
            return a.name > b.name ? 1 : -1;
          });
        })
        .catch(function(error) {
          vm.$router.push("/error");
        });
    }
  }

  // beforeRouteEnter: function(to, from, next) {
  //   next(vm => vm.loadProjects(vm));
  // }
};
</script>
