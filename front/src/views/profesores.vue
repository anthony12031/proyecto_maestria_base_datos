<template>
  <div>
      <h1 class="display-4">Sección Profesores</h1>
      <section v-if="true">
          <h2 class="text-left">Asignaturas que Imparte</h2>
          <kendo-datasource ref="asignaturas_profesor"
                            :transport-read-url="asignaturas_profesor_url"
                            :transport-read-data-type="'json'"
                            :schema-model-id="'cod_e'"
                            :schema-model-fields="schema_asignaturas"
                            v-on:error.prevent="errorHandler" 
                            >
        </kendo-datasource>
        <kendo-grid :height="200"
                    :selectable="true"
                    :data-source-ref="'asignaturas_profesor'"
                    v-on:change.prevent="consultarEstudiantes">
            <kendo-grid-column :field="'cod_a'"
                              :title="'Codigo Asignatura'" >
                              </kendo-grid-column>
            <kendo-grid-column :field="'nom_a'"
                              :title="'Asignatura'" >
                              </kendo-grid-column>
            <kendo-grid-column :field="'grupo'"
                              :title="'Grupo'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'horario'"
                              :title="'Horario'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'modalidad'"
                              :title="'Modalidad'">
                              </kendo-grid-column>
        </kendo-grid>
        <h2 class="text-left mt-5">Estudiantes asignatura</h2>
        <kendo-grid :data-source="estudiantes_data">
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
      asignaturas_profesor_url:`${process.env.VUE_APP_API}/asignaturas_profesor`,
      estudiantes_profesor_url:`${process.env.VUE_APP_API}/asignaturas_profesor`,
      estudiantes_data:[],
      schema_asignaturas: {
            cod_a: { type:'text'},
            nom_a: { type:'text'},
            grupo: { type:'text'  },
            horario: { type:'text'  },
            modalidad: { type:'text'  }
        },
      estudiantes_schema: {
        cod_e: { type:'text'},
        nom_e: { type:'text'},
        grupo: { type:'text'},
        id_p: { type:'text'},
        cod_a: { type:'text'},
        n1: { type:'number'},
        n2: { type:'number'},
        n3: { type:'number'} 
      }
    }
  },
  methods:{
    errorHandler:_.debounce(function(error){
      alert(error.xhr.responseText);
    },300),
    consultarEstudiantes: function(event){
      const grid = event.sender;
      const row = grid.select();
      const dataItem = grid.dataItem(row);
      this.axios.post(`${process.env.VUE_APP_API}/estudiantes_asignatura`,dataItem)
    .then((response) => {
      debugger;
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
