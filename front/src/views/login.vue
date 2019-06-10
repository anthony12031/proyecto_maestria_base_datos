<template >
<section class="row align-items-center justify-content-center h-100">
   <form>
    <div class="form-group">
      <label for="user">Usuario</label>
      <input type="email" class="form-control" id="user" placeholder="Usuario">
    </div>
    <div class="form-group">
      <label for="password">Contraseña</label>
      <input type="password" class="form-control" id="password" placeholder="Contraseña">
    </div>
    <button type="submit" class="btn btn-primary">Ingresar</button>
</form>
</section>
</template>

<script>
export default {
  name: "login",
  mounted(){
    this.axios.get(process.env.VUE_APP_API)
    .then((response) => {
      debugger;
    })
    .catch((error)=>{
      debugger;
    })
  }
};
</script>

<style lang="scss">
 body,html{
   height: 100%;
 }
</style>
