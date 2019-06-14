<template>
  <div>
      <h1 class="display-4">Sección Estudiantes</h1>
      <section v-if="true">
          <h2 class="text-left">Reporte de Notas</h2>
          <kendo-datasource ref="estudiantes_data_source"
                            :transport-read-url="notas_estudiante"
                            :transport-read-data-type="'json'"
                            :schema-model-id="'cod_e'"
                            :schema-model-fields="schema_estudiantes"
                            v-on:error.prevent="errorHandler" 
                            >
        </kendo-datasource>
        <kendo-grid :height="200"
                    :data-source-ref="'estudiantes_data_source'">
            <kendo-grid-column :field="'nom_a'"
                              :title="'Asignatura'" >
                              </kendo-grid-column>
            <kendo-grid-column :field="'n1'"
                              :title="'Nota 1'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'n2'"
                              :title="'Nota 2'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'n3'"
                              :title="'Nota 3'">
                              </kendo-grid-column>
             <kendo-grid-column :field="'notafinal'"
                              :title="'Nota Final'">
                              </kendo-grid-column>
        </kendo-grid>
      </section>
      <section v-if="true">
          <h2 class="text-left">Libros y Autores</h2>
          <kendo-datasource ref="libros_autores"
                            :transport-read-url="libros_url"
                            :transport-read-data-type="'json'"
                            :schema-model-id="'cod_e'"
                            :schema-model-fields="schema_estudiantes"
                            v-on:error.prevent="errorHandler" 
                            >
        </kendo-datasource>
        <kendo-grid :height="200"
                    :data-source-ref="'libros_autores'">
            <kendo-grid-column :field="'isbn'"
                              :title="'ISBN'" >
                              </kendo-grid-column>
            <kendo-grid-column :field="'titulo'"
                              :title="'Titulo'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'edicion'"
                              :title="'Edicion'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'nom_a'"
                              :title="'Autor'">
                              </kendo-grid-column>
        </kendo-grid>
      </section>
        <section v-if="true">
          <h2 class="text-left">Libros Prestados</h2>
          <kendo-datasource ref="libros_data"
                            :transport-read-url="prestamos_url"
                            :transport-read-data-type="'json'"
                            :schema-model-id="'cod_e'"
                            :schema-model-fields="schema_prestamos"
                            v-on:error.prevent="errorHandler" 
                            >
        </kendo-datasource>
        <kendo-grid :height="200"
                    :data-source-ref="'libros_data'">
            <kendo-grid-column :field="'num_ej'"
                              :title="'Ejemplar'" >
                              </kendo-grid-column>
            <kendo-grid-column :field="'titulo'"
                              :title="'Titulo'" >
                              </kendo-grid-column>                  
            <kendo-grid-column :field="'fecha_p'"
                              :title="'Fecha Prestamo'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'fecha_d'"
                              :title="'Fecha Devolucion'">
                              </kendo-grid-column>
        </kendo-grid>
      </section>
  </div>
</template>

<script>
import * as _ from "lodash";

export default {
  name: "coordinadores",
  data:function(){
    return {
      notas_estudiante:`${process.env.VUE_APP_API}/notasEstudiantes`,
      libros_url:`${process.env.VUE_APP_API}/consultaLibrosAutores`,
      prestamos_url:`${process.env.VUE_APP_API}/consultaPrestamos`,
      schema_estudiantes: {
            nom_a: { type:'text'},
            n1: { type:'number'  },
            n2: { type:'number'  },
            n3: { type:'number'  },
            notaFinal: { type: 'text'  },
        },
      schema_libros: {
        isbn:{type:'text'},
        titulo:{type:'text'},
        edicion:{type:'text'},
        nom_a:{type:'text'}
      },
       schema_prestamos: {
        num_ej:{type:'text'},
        titulo:{type:'text'},
        fecha_p:{type:'date'},
        fecha_d:{type:'date'}
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
