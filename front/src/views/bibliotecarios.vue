<template>
  <div>
      <h1 class="display-4">Sección Bibliotecarios</h1>
      <section>
          <h2>Administración de Libros</h2>
          <kendo-datasource ref="libros"
                            :transport-read-url="libros_url"
                            :transport-read-data-type="'json'"
                            :schema-model-fields="libros_schema"
                            :transport-create-url="insert_libros_url"
                            :transport-create-data-type="'json'"
                            :transport-create-type="'POST'"
                            :schema-model-id="'isbn'"
                            v-on:error.prevent="errorHandler"
                            >
        </kendo-datasource>
        <kendo-grid :height="400"
                    :data-source-ref="'libros'"
                    :editable="'popup'"
                    v-on:change.prevent="consultar_ejemplares"
                    :selectable="true"
                    :toolbar="['create']">
            <kendo-grid-column :field="'isbn'"
                              :title="'ISBN'">
                              </kendo-grid-column>  
             <kendo-grid-column :field="'titulo'"
                              :title="'Titulo'">
                              </kendo-grid-column>     
               <kendo-grid-column :field="'edicion'"
                              :title="'Edicion'">
                              </kendo-grid-column>                  
                                                                                                                      
        </kendo-grid>
        <h3>Ejemplares</h3>
        <kendo-grid 
        :data-source="ejemplares"
         :editable="'inline'">
        </kendo-grid>
      </section>
  </div>
</template>

<script>
import * as _ from "lodash";

export default {
  name: "profesores",
  data:function(){
    return {
      libros_url:`${process.env.VUE_APP_API}/libros`,
      insert_libros_url:`${process.env.VUE_APP_API}/update_libros`,
      ejemplares:[],
      libros_schema:{
        isbn:{ type:'text'},
        titulo: {type:'text'},
        edicion:{type:'text'}
      }
    }
  },
  methods:{
    errorHandler:_.debounce(function(error){
      alert(error.xhr.responseText);
    },300),
    consultar_ejemplares:function(event){
      const grid = event.sender;
      const row = grid.select();
      const dataItem = grid.dataItem(row);
      this.axios.post(`${process.env.VUE_APP_API}/ejemplares`,dataItem)
    .then((response) => {
      this.ejemplares= response.data;
    })
    .catch((error)=>{
      alert(error.response.data);
    })
  }
  }
};
</script>

<style lang="scss">
  section{
    margin: 40px;
  }
</style>
