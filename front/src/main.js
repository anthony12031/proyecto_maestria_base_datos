import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import BootstrapVue from "bootstrap-vue";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";
import axios from "axios";
import VueAxios from "vue-axios";
import "@progress/kendo-ui";
import "@progress/kendo-theme-default/dist/all.css";
import {
  Grid,
  GridInstaller,
  GridColumn
} from "@progress/kendo-grid-vue-wrapper";
import {
  DataSource,
  DataSourceInstaller
} from "@progress/kendo-datasource-vue-wrapper";

Vue.use(GridInstaller);
Vue.use(DataSourceInstaller);

Vue.use(BootstrapVue);
Vue.use(VueAxios, axios);
Vue.config.productionTip = false;

new Vue({
  router,
  store,
  components: {
    Grid,
    GridColumn,
    DataSource
  },
  render: h => h(App)
}).$mount("#app");
