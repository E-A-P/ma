<%-- 
    Document   : consultarSolicitudes
    Created on : 13/03/2020, 12:06:34
    Author     : bryan
--%>

<div class="main col pt-2" style="margin-top: 20px">
    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 mx-auto">
        <div class="bg-faded rounded p-3">
            <div class="loader">
                <img src="${pageContext.request.contextPath}/images/spinner-reload.gif" alt="Loading..."/>
            </div>
            <div class="card">
                <form style="font-size: 0.95em" autocomplete="off">
                    <div class="card-body">
                        <div class="form-row" style="padding-left: 30px;">
                            <div class="form-row col-5">
                                <div class="form-group col-5">
                                    <label>Buscar por grupo: </label>
                                </div>
                                <div class="form-group col-6">
                                    <select  name="buscarGrupo" id="buscarGrupo" class="form-control" model="selected">
                                        <option selected disabled hidden style='display: none' value=''></option>
                                        <option value="sist">Sistemas</option>   
                                        <option value="mant">Mantenimiento</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row col-5">
                                <div class="form-group col-5">
                                    <label>Buscar por Estado: </label>
                                </div>
                                <div class="form-group col-6">
                                    <select  name="buscarEstado" id="buscarEstado" class="form-control" model="selected">
                                        <option selected disabled hidden style='display: none' value=''></option>
                                        <option value="pendiente">Pendiente</option>   
                                        <option value="asignada">Asignada</option>
                                        <option value="reevaluar">Reevaluar</option>
                                        <option value="finalizada">Finalizada</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="form-row" style="padding-left: 30px;">
                            <div class="form-row col-5">
                                <div class="form-group col-4">
                                    <label>Desde: </label>
                                </div>
                                <div class="form-group col-7">
                                    <div class="form-group">
                                        <div class="input-group date" id="datetimeDesde" data-target-input="nearest">
                                            <input type="text" id="dtpDesde" class="form-control datetimepicker-input" data-target="#datetimeDesde"/>
                                             <div class="input-group-append" data-target="#datetimeDesde" data-toggle="datetimepicker">
                                                 <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                             </div>
                                         </div>
                                     </div>
                                </div>
                            </div>
                            <div class="form-row col-5">
                                <div class="form-group col-4">
                                    <label>Hasta: </label>
                                </div>
                                <div class="form-group col-7">
                                    <div class="form-group">
                                        <div class="input-group date" id="datetimeHasta" data-target-input="nearest">
                                             <input type="text"id="dtpHasta" class="form-control datetimepicker-input" data-target="#datetimeHasta"/>
                                             <div class="input-group-append" data-target="#datetimeHasta" data-toggle="datetimepicker">
                                                 <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                             </div>
                                         </div>
                                     </div>
                                </div>
                            </div>
                        </div>   
                        <div class="form-row col" style="padding-left: 30px;">
                            <div class="text-center" style="width: 100%">
                                <button type="button" class="btn-cambiar-color btn btn-primary"  id="cargarSelectC" style="margin-right: 15px;"><i class="fas fa-search"></i> Cargar</button>
                                <button type="reset" class="btn-cambiar-color btn btn-primary"  id="resetSelectC"><i class="fas fa-undo"></i></button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <br>
        </div>
    </div>
    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 mx-auto">
        <div class="bg-faded rounded p-3">
            <div class="table-responsive">
                <table id="tableConsultarSolicitud" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th class="th-sm" style="font-size: 0.85em ">Cod</th>
                            <th class="th-sm" style="font-size: 0.85em; max-width: 260px; text-align: justify">Descripci�n</th>
                            <th class="th-sm" style="font-size: 0.85em ">Grupo</th>
                            <th class="th-sm" style="font-size: 0.85em ">Tipo</th>
                            <th class="th-sm" style="font-size: 0.85em ">T�cnico</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Inicio</th>
                            <th class="th-sm" style="font-size: 0.85em ">Fecha Fin</th>
                            <th class="th-sm" style="font-size: 0.85em ">Estado</th>
                            <th class="th-sm" style="font-size: 0.85em">Observaci�n</th>
                        </tr>
                    </thead>
                    <tbody id="bodyTableCargarSolicitudes" style="font-size: 0.85em;">
                    
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
            <div class="modal-body" style="overflow-y: auto; height:300px; overflow-x: hidden;" id="listaObservaciones">
                
            </div>
            <form id="formObservacion" autocomplete="off">
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