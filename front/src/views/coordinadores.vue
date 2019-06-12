<template>
  <section>
      <h1>Sección coordinadores</h1>
      <h2 class="text-left">Gestión de Estudiantes</h2>
      <kendo-datasource ref="estudiantes_data_source"
                        :transport-read-url="estudiantes_carrera_url"
                        :transport-read-data-type="'json'"
                        :transport-update-url="estudiantes_carrera_url"
                        :transport-update-data-type="'json'"
                        :transport-update-type="'PUT'"
                        :transport-create-url="estudiantes_carrera_url"
                        :transport-create-data-type="'json'"
                        :transport-create-type="'POST'"
                        :schema-model-id="'cod_e'"
                        :schema-model-fields="schemaModelFields"
                         v-on:error.prevent="errorHandler" 
                        >
    </kendo-datasource>
    <kendo-grid :height="600"
                :data-source-ref="'estudiantes_data_source'"
                :editable="'popup'"
                :toolbar="['create']">
        <kendo-grid-column :field="'cod_e'"
                           :title="'Código estudiante'" >
                           </kendo-grid-column>
        <kendo-grid-column :field="'nom_e'"
                           :title="'Nombre estudiante'"
                           ></kendo-grid-column>
        <kendo-grid-column :field="'dir_e'"
                           :title="'Dirección'"
                           ></kendo-grid-column>
        <kendo-grid-column :field="'tel_e'"
                           :title="'Telefono'">
                           </kendo-grid-column>
        <kendo-grid-column :field="'cod_carr'"
                           :title="'Carrera'">
                           </kendo-grid-column>    
        <kendo-grid-column :field="'f_nac'"
                           :title="'fecha nacimiento'">
                           </kendo-grid-column>                                  
        <kendo-grid-column :command="['edit']"
                           :title="'Opciones;'"
                           ></kendo-grid-column>
    </kendo-grid>
      <!-- <kendo-grid
        :height="300" 
        :data-source="estudiantes_carrera">
      </kendo-grid> -->
  </section>
</template>

<script>
import * as _ from "lodash";

export default {
  name: "coordinadores",
  data:function(){
    return {
      estudiantes_carrera: [],
      estudiantes_carrera_url:`${process.env.VUE_APP_API}/estudiantes_carrera`,
      schemaModelFields: {
            cod_e: { type:'number',validation: { required: true },format:'{0:n}'  },
            nom_e: { validation: { required: true } },
            dir_e: { type:'text'  },
            tel_e: { type: 'text'  },
            f_nac:{type:'date', format : "{0:dd-MMM-yyyy hh:mm:ss tt}",parseFormats: ["MM/dd/yyyy h:mm:ss"]},
            cod_carr: { type: 'number' ,validation: { required: true } }
        }
    }
  },
  methods:{
    errorHandler:_.debounce(function(error){
      alert(error.xhr.responseText);
    },300)
  },
  mounted:function(){
    //  this.axios.get(`${process.env.VUE_APP_API}/estudiantes_carrera`)
    // .then((response) => {
    //   this.estudiantes_carrera = response.data;
    // })
    // .catch((error)=>{
    //   alert(error.response.data);
    // })
  }
};
</script>

<style lang="scss">
</style>
