import Vue from "vue";
import Router from "vue-router";
import Login from "./views/login.vue";
import Estudiantes from "./views/estudiantes.vue";
import Profesores from "./views/profesores.vue";
import Coordinadores from "./views/coordinadores.vue";
import Bibliotecarios from "./views/bibliotecarios.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/",
      name: "login",
      component: Login
    },
    {
      path: "/estudiantes",
      name: "estudiantes",
      component: Estudiantes
    },
    {
      path: "/profesores",
      name: "profesores",
      component: Profesores
    },
    {
      path: "/coordinadores",
      name: "coordinadores",
      component: Coordinadores
    },
    {
      path: "/bibliotecarios",
      name: "bibliotecarios",
      component: Bibliotecarios
    }
  ]
});
