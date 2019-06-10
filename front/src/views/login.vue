<template >
<section class="row align-items-center justify-content-center h-100">
   <form v-on:submit.prevent="login">
    <div class="form-group">
      <label for="user">Usuario</label>
      <input type="text" class="form-control" id="user" placeholder="Usuario" v-model="user">
    </div>
    <div class="form-group">
      <label for="password">Contraseña</label>
      <input type="password" class="form-control" id="password" placeholder="Contraseña"  v-model="password">
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
        user:''
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
      debugger;
    })
    .catch((error)=>{
      debugger;
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
