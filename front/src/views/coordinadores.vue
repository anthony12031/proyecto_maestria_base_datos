<template>
  <div>
      <h1>Sección coordinadores</h1>
      <section v-if="true">
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
                            :schema-model-fields="schema_estudiantes"
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
      </section>
       <section>
          <h2 class="text-left">Gestión de Notas</h2>
          <kendo-datasource ref="notas_data_source"
                            :transport-read-url="notas_carrera_url"
                            :transport-read-data-type="'json'"
                            :transport-update-url="notas_carrera_url"
                            :transport-update-data-type="'json'"
                            :transport-update-type="'PUT'"
                            :schema-model-id="'cod_e'"
                            :schema-model-fields="schema__notas_estudiantes"
                            v-on:error.prevent="errorHandler" 
                            >
        </kendo-datasource>
        <kendo-grid :height="600"
                    :data-source-ref="'notas_data_source'"
                    :editable="'popup'">
            <kendo-grid-column :field="'id_carr'"
                              :title="'Id Carrera'"
                              :hidden ="true" >
                              </kendo-grid-column>
            <kendo-grid-column :field="'nom_carr'"
                              :title="'Carrera Asignatura'"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'cod_e'"
                              :title="'Código estudiante'" 
                              :hidden ="true">
                              </kendo-grid-column>
            <kendo-grid-column :field="'id_p'"
                              :title="'Id Profesor'"
                              :hidden ="true"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'cod_a'"
                              :title="'Codigo Asignatura'"
                              :hidden ="true"
                              ></kendo-grid-column>
            <kendo-grid-column :field="'grupo'"
                              :title="'Grupo'">
                              </kendo-grid-column>
            <kendo-grid-column :field="'nom_e'"
                              :title="'Estudiante'">
                              </kendo-grid-column>
             <kendo-grid-column :field="'nom_p'"
                              :title="'Profesor'">
                              </kendo-grid-column>
              <kendo-grid-column :field="'nom_a'"
                              :title="'Asignatura'">
                              </kendo-grid-column> 
              <kendo-grid-column :field="'n1'"
                              :title="'Nota 1'">
                              </kendo-grid-column>   
              <kendo-grid-column :field="'n2'"
                              :title="'Nota 2'">
                              </kendo-grid-column>   
              <kendo-grid-column :field="'n3'"
                              :title="'Nota 3'">
                              </kendo-grid-column> 
              <kendo-grid-column :command="['edit']"
                              :title="'Opciones;'"
                              ></kendo-grid-column>                                         
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
      estudiantes_carrera: [],
      estudiantes_carrera_url:`${process.env.VUE_APP_API}/estudiantes_carrera`,
      notas_carrera_url:`${process.env.VUE_APP_API}/notas_estudiantes_carrera`,
      schema_estudiantes: {
            cod_e: { type:'number',validation: { required: true },format:'{0:n}'  },
            nom_e: { validation: { required: true } },
            dir_e: { type:'text'  },
            tel_e: { type: 'text'  },
            f_nac:{type:'date', format : "{0:dd-MMM-yyyy hh:mm:ss tt}",parseFormats: ["MM/dd/yyyy h:mm:ss"]},
            cod_carr: { type: 'number' ,validation: { required: true } }
        },
       schema__notas_estudiantes: {
            id_carr: { type:'text',editable:false},
            nom_carr: { type:'text',editable:false },
            cod_e: { type:'text',editable:false },
            id_p: { type:'text',editable:false },
            cod_a: { type:'text',editable:false  },
            grupo: { type: 'text',editable:false  },
            nom_e:{type:'text',editable:false},
            nom_p:{type:'text',editable:false},
            nom_a:{type:'text',editable:false},
            n1:{type:'number',validation: { min: 0 , max:5 } },
            n2:{type:'number',validation: { min: 0 , max:5 } },
            n3:{type:'number',validation: { min: 0 , max:5 } }

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
</style>
