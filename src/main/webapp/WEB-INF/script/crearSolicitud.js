/*activar modal en crearSolicitud.jsp*/
function myFunction() {
    var option_value = document.getElementById("reincidencia").value;
    if (option_value == "2" || option_value == "3" || option_value == "4") {
       $("#myModal").modal();
     }
};

function postAjaxTablaSolicitudes(datos){
    $.ajax({
       type: 'POST',
       contentType: 'application/json',
       url: '/mesaayuda/usuario/solicitudes',
       data: JSON.stringify(datos),
       success: function(response){
            if(response.status == "success"){
               $("#bodyTableCargarSolicitudes").empty();
                var tr = '';
                $.each(response.data, function(i, dato){
                    tr+= '<tr>'+
                            '<th class="idsolicitud" scope="row">'+dato.id+'</th>'+
                            '<td>'+dato.grupo+'</td>'+
                            '<td>'+dato.tipo+'</td>'+
                            '<td style="max-width: 260px; text-align: justify">'+dato.descripcion+'</td>'+
                            '<td><input  type="checkbox" name="ug-checkbox" value="'+dato.id+'"/>&nbsp;</td>'+
                        '</tr>';
                });
                $("#bodyTableCargarSolicitudes").html(tr);
                limitarChecks();
            }
        },
        error : function(e) {
            $("#bodyTableCargarSolicitudes").html("<strong>No se ha podido cargar</strong>");
        }
    });
}

$( document ).ready(function() {
    $(document).on('click','#testForm', function(){
        var datos;
        var grupoT = $('input[name=grupo]:checked', '#testForm').val();
        if(grupoT =="sist" || grupoT =="mant"){
            datos={
                grupo: grupoT
            };
            postAjaxTablaSolicitudes(datos);
        }
    });
});

/*diseño del table*/
$(document).ready(function () {
    $('#dtBasicExample').DataTable({
    //para cambiar el lenguaje a español
        "language": {
            "lengthMenu": "Mostrar _MENU_ registros",
            "zeroRecords": "No se encontraron resultados",
            "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            "infoFiltered": "(filtrado de un total de _MAX_ registros)",
            "sSearch": "Buscar:",
            "oPaginate": {
                "sFirst": "Primero",
                "sLast":"Último",
                "sNext":"Siguiente",
                "sPrevious": "Anterior"
                         },
                         "sProcessing":"Procesando...",
        }
    });
});
/*obtener ids y colocarlos el en input de crearSolicitud.jsp*/
$(document).ready(function() {
    $(document).on('click','#cargarIds', function(){
        var selected = '';    
        $('#idsItems input[type=checkbox]').each(function(){
            if(this.checked){
                selected += $(this).val()+',';
                console.log($(this).val());
            } 
        }); 
    document.getElementById("ids_aydudaas").value= selected.slice(0,(selected.length-1));
    $('#ids_aydudaas').attr('value', selected.slice(0,(selected.length-1)));
    });         
});  

/*limitar numero de checks en crearSolicitud.jsp*/
function limitarChecks() {
   $("input[name='ug-checkbox']").change(function () {
      var limit = document.getElementById("reincidencia").value;
      var cantidadCkb = $("input[name='ug-checkbox']:checked").length;
      if (cantidadCkb > limit) 
      {
         $(this).prop("checked", "");
         alert("Solo puede seleccionar: "+ limit+" veces");
     }
  });
};