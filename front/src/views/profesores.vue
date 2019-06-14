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
                    :data-source-ref="'asignaturas_profesor'">
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
      schema_asignaturas: {
            nom_a: { type:'text'},
            grupo: { type:'text'  },
            horario: { type:'text'  },
            modalidad: { type:'text'  }
        }
    }
  },
  methods:{
    errorHandler:_.debounce(function(error){
      alert(error.xhr.responseText);
    },300)
  }
};
</script>

<style lang="scss">
  section{
    margin: 40px;
  }
</style>
