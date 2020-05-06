<%-- 
    Document   : consultarSolicitudes
    Created on : 05/10/2020, 12:06:34
    Author     : bryan
--%>

<div class="main col pt-2" style="margin-top: 20px">
    <div class="col-xl-12 col-lg-8 col-md-12 mx-auto">
        <div class="bg-faded rounded p-3">
            <div class="loader">
                <img src="${pageContext.request.contextPath}/images/spinner-reload.gif" alt="Loading..."/>
            </div>
            <form style="font-size: 0.95em" autocomplete="off">
                <div class="card">
                    <div class="card-body">
                        <div class="form-row">
                            <div class="form-group col-md-1"></div>
                            <div class="form-group col-md-1">
                                <label>Buscar: </label>
                            </div>
                            <div class="form-group col-md-3">
                                <fieldset id="testForm">
                                    <div class="form-group col-md-11" required>
                                        <input selected disabled hidden style='display: none' type="radio" id="grupoSistemaCS" name="grupo" value="" required>
                                        <div>
                                            <input type="radio" name="solicitudesR" id="g1" value="mSolicitudes">
                                            <label for="sistemas">Mis Solicitudes</label>
                                        </div>
                                        <div>
                                            <input type="radio" name="solicitudesR" id="g2" value="rSolicitudes">
                                            <label for="mantenimiento">Solicitudes Gestionadas</label>
                                        </div>
                                    </div>
                                </fieldset> 
                            </div>
                            <div class="form-group col-md-1"></div>
                            <div class="form-group col-md-5" id="filtroGE" style="display: none">
                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label>Buscar por grupo: </label>
                                    </div>
                                    <div class="form-group col-md-1"></div>
                                    <div class="form-group col-md-5">
                                        <select  name="buscarGrupo" id="buscarGrupo" class="form-control" model="selected">
                                            <option selected disabled hidden style='display: none' value=''></option>
                                            <option value="sist">Sistemas</option>   
                                            <option value="mant">Mantenimiento</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label>Buscar por Estado: </label>
                                    </div>
                                    <div class="form-group col-md-1"></div>
                                    <div class="form-group col-md-5">
                                        <select  name="buscarEstado" id="buscarEstado" class="form-control" model="selected">
                                            <option selected disabled hidden style='display: none' value=''></option>
                                            <option value="pendiente">Pendiente</option>   
                                            <option value="asignada">Asignada</option>
                                            <option value="finalizada">Finalizada</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br>
                <div class="text-center">
                    <button type="button" class="btn-cambiar-color btn btn-primary"  id="cargarSelectC" style="margin-right: 15px;"><i class="fas fa-search"></i> Cargar</button>
                    <button type="reset" class="btn-cambiar-color btn btn-primary"  id="resetSelectC"><i class="fas fa-undo"></i></button>
                </div>
            </form>
            
        </div>
    </div>
    <br>
    <div class="col-xl-12 col-lg-8 mx-auto">
        <div class="bg-faded rounded p-3">
            <div id="tableM" class="table-responsive" style="display: none;">
                <table id="tableConsultarSolicitudM" class="table table-striped table-bordered" style="width:100%">
                    <thead id="headTableCargarSolicitudes">
                        <tr>
                            <th class="th-sm" style="font-size: 0.85em ">Cod</th>
                            <th class="th-sm" style="font-size: 0.85em; max-width: 260px; text-align: justify">Descripci�n</th>
                            <th class="th-sm" style="font-size: 0.85em ">Grupo</th>
                            <th class="th-sm" style="font-size: 0.85em ">Tipo</th>
                            <th class="th-sm" style="font-size: 0.85em ">T�cnico</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Inicio</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Fin</th>
                            <th class="th-sm" style="font-size: 0.85em ">Estado</th>
                            <th class="th-sm" style="font-size: 0.85em ">Observaci�n</th>
                        </tr>
                    </thead>
                    <tbody id="bodyTableCargarSolicitudes" style="font-size: 0.85em;">
                        
                    </tbody>
                </table>
            </div>
            <div id="tableR" class="table-responsive" style="display: none;">    
                <table id="tableConsultarSolicitudR" class="table table-striped table-bordered" style="width:100%">
                    <thead id="headTableCargarSolicitudesR">
                        <tr>
                            <th class="th-sm" style="font-size: 0.85em ">Cod</th>
                            <th class="th-sm" style="font-size: 0.85em; max-width: 260px; text-align: justify">Descripci�n</th>
                            <th class="th-sm" style="font-size: 0.85em ">Usuario Solicita Ayuda</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Inicio</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Fin</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Inicio T�cnico</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Fin nT�cnico</th>
                            <th class="th-sm" style="font-size: 0.85em ">Estado Solicitud</th>
                            <th class="th-sm" style="font-size: 0.85em ">Observaci�n</th>
                        </tr>
                    </thead>
                    <tbody id="bodyTableCargarSolicitudesR" style="font-size: 0.85em;">
                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- modal para cargar mensaje -->
<div class="modal fade" id="modalMensaje" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body " id="mensajeModal">

            </div>
        </div>
    </div>
</div>
<!-- Modal observacion-->
<div class="modal fade" id="modalObservacion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <div class="text-center" style="width: 100%;"><h4 class="modal-title" id="exampleModalLabel" style="color: #032345;">Observaciones</h4></div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="overflow-y: auto; height:300px;" id="listaObservaciones">
                <div class="form-row">
                    <div class="form-group col-12">
                        <label style="color: #054182;"> <i> Nombre:</i></label>
                        <div style="font-size: 0.85em;">kvbsjkvbk</div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-12">
                        <label style="color: #054182;"> <i> Nombre:</i></label>
                        <div style="font-size: 0.85em;">
                            kvbsjkvbk Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto 
                            in cupiditate hic nobis sapiente. Consequuntur reiciendis nesciunt, perspiciatis 
                            optio labore voluptatem corporis adipisci dolor, illum quia libero autem, aliquam deserunt.
                        </div>
                    </div>
                </div>
            </div>
            <form id="" autocomplete="off">
                <div class="modal-footer justify-content-between ">
                    <div class="form-row col">
                        <div class="form-group col-11">
                            <input type="text" class="form-control" name="observacionM" id="observacionM" required>
                        </div>
                        <div class="form-group col-1">
                            <button type="submit" class="btn-cambiar-color btn btn-primary" id="enviarObservacion"><i class="fas fa-paper-plane"></i></button>
                        </div>
                    </div>
                </div>
            </form> 
        </div>
    </div>
</div>