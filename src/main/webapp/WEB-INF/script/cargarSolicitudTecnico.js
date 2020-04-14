
function postAjaxTabla(datos){
    console.log("se hizo un post ajax");
    $.ajax({
       type: 'POST',
       contentType: 'application/json',
       url: '/mesaayuda/tecnico/actualizarSolicitud',
       data: JSON.stringify(datos),
       success: function(response){
            if(response.status == "proceso"){
               getAjaxTabla();
               $("#mensajePost").html("Ha comenzado a trabajar en la solicitud");
            }
            if(response.status == "finalizado"){
               getAjaxTabla();
               $("#mensajePost").html("Ha culminado con está solicitud");
            }
            else if(response.status == "error"){
                $("#mensajePost").html("No se ha podido comenzar a trabajar en la solicitud");
            }
            $("#procesoSolicitud").modal();
        }
    });
}

function getAjaxTabla(){
    $.ajax({
    type: "GET",
    url: "/mesaayuda/tecnico/cargarSolicitudes",
    async: true,
    success: function(result){
        if(result.status == "success"){
            $("#bodyTableCargarSolicitudes").empty();
            var tr = '';
            $.each(result.data, function(i, dato){
                tr += "<tr>"+
                         "<th class='idsolicitud' style='font-size: 0.8em' scope='row'>"+dato.id+"</th>"+
                         "<td style='max-width: 260px; font-size: 0.8em; text-align: justify'>"+dato.descripcion+"</td>"+
                         "<td style='font-size: 0.8em'>"+dato.fechaInicio+"</td>"+
                         "<td style='font-size: 0.8em'>"+dato.fechaFin+"</td>"+
                         "<td style='font-size: 0.8em'>"+dato.userSolicitaAyuda+"</td>";
                if(dato.estadoSolicitudTecnico == "inactiva"){
                    tr+='<td class="text-center">'+
                            '<button type="button" class="btn btn-success btn-sm comenzarSolicitud"'+' value="'+dato.id+'"><i class="far fa-edit"></i> Comenzar</button>'+
                        '</td>';
                }
                else if(dato.estadoSolicitudTecnico == "proceso"){
                         tr+='<td class="text-center">'+
                                 '<button type="button" class="btn btn-danger btn-sm finalizarSolicitud"'+' value="'+dato.id+'"><i class="far fa-times-circle"></i> Finalizar</button>'+
                             '</td>';
                }
                else{
                    tr+='<td class="text-center"></td>';
                }
                tr+="</tr>";
            });
            $("#bodyTableCargarSolicitudes").html(tr);
        }
    },
    error : function(e) {
            $("#bodyTableCargarSolicitudes").html("<strong>Error</strong>");
        }
    });
}


$(document).ready(function () {
    $(document).on('click','.comenzarSolicitud', function(){
    //$('.comenzarSolicitud').click(function(){
        console.log("comenzar solicitud")
        let cod;
        $(this).parents("tr").find(".idsolicitud").each(function() {
            cod = $(this).html();
        });
        var datos = {
            id: cod,
            estadoSolicitudTecnico: 'proceso',
            estadoSolicitud: 'null'
            };
        console.log("se hizo clic en el boton comenzar solciitud");
        postAjaxTabla(datos);
    });
});

$(document).ready(function () {
    getAjaxTabla();
    
    $('#recargartabla').click(function(){
        getAjaxTabla();
        console.log("se recargo la tabla");
    });
});

$(document).ready(function () {
    $(document).on('click','.finalizarSolicitud', function(){
    //$('.finalizarSolicitud').click(function(){
        let cod;
        $(this).parents("tr").find(".idsolicitud").each(function() {
            cod = $(this).html();
        });
        localStorage.setItem("idSolicitud", cod);
        $("#finalSolicitudModal").modal();
        console.log("se hizo clic en finalizar boton");
    });
});
$(document).ready(function () {
    $(document).on('click','#finalSolicitud', function(){
    //$('#finalSolicitud').click(function(){
        let cod = localStorage.getItem("idSolicitud");
        let descripcion = $("#descripcion_st").val();
        var datos = {
            id: cod,
            estadoSolicitudTecnico: 'finalizada',
            descripcionTecnico: descripcion,
            estadoSolicitud: 'finalizada'
            };
        $("#descripcion_st").val("");
        postAjaxTabla(datos);
        console.log("se hizo clic en el boton final solciitud");
    });
});
$(document).ready(function () {
    $(document).on('click','#reevaluarSolicitud', function(){
    //$('#reevaluarSolicitud').click(function(){
        let cod = localStorage.getItem("idSolicitud");
        let descripcion = $("#descripcion_st").val();
        var datos = {
            id: cod,
            estadoSolicitudTecnico: 'finalizada',
            descripcionTecnico: descripcion,
            estadoSolicitud: 'reevaluar'
            };
        $("#descripcion_st").val("");
        postAjaxTabla(datos);
        console.log("se hizo clic en el boton reevaluar solciitud");
    });
});
