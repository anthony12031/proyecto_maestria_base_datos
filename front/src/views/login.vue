<template >
<section class="row align-items-center justify-content-center h-100">
   <form v-on:submit.prevent="login">
    <div class="form-group">
      <label for="user">Usuario</label>
      <input type="text" class="form-control" id="user" placeholder="Usuario" v-model="user" required>
    </div>
    <div class="form-group">
      <label for="password">Contraseña</label>
      <input type="password" class="form-control" id="password" placeholder="Contraseña"  v-model="password" required>
    </div>
    <div class="form-group">
      <label for="dashboard">Ingreso de:</label>
      <select class="custom-select" id="dashboard" v-model="dashboard" required> 
        <option value="estudiantes">estudiantes</option>
        <option value="profesores">profesores</option>
        <option value="coordinadores">coordinadores</option>
        <option value="bibliotecarios">bibliotecarios</option>
    </select>
    </div>
    <button type="submit" class="btn btn-primary">Ingresar</button> 
</form>
</section>
</template>

<script>
export default {
  name: "login",
  data:function(){
     return {
        password:'',
        user:'',
        dashboard:'estudiantes'
      }
    },
  methods:{
    login: function(){
      this.axios.post(`${process.env.VUE_APP_API}/login`,{
        user:this.user,
        password:this.password,
        dataBase:process.env.VUE_APP_BASEDATOS
    })
    .then((response) => {
      this.$router.push(this.dashboard);
    })
    .catch((error)=>{
      alert(error.response.data);
    })
    }
  }
};
</script>

<style lang="scss">
 body,html {
   height: 100%;
 }
</style>
