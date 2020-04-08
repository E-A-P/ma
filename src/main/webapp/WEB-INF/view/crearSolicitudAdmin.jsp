<%-- 
    Document   : crearSolicitud
    Created on : 13/03/2020, 11:56:46
    Author     : bryan
--%>

<div>
    <h2 class="mt-4 text-center">Crear Solicitud de Ayuda</h2>
    <div class="col-xl-10 col-lg-12 col-md-12 mx-auto">
        <div class="bg-faded rounded p-5">
            <form action="${pageContext.request.contextPath}/admin/enviarSolicitud" method="post" style="font-size: 0.95em" autocomplete="off">
                <div class="card">
                    <div class="form-row card-body">
                        <div class="form-group col-md-4">
                            <label><h6>Grupo</h6></label>
                            <fieldset>
                                <div class="form-group col-md-11">
                                    <div>
                                        <input type="radio" id="grupoSistemaCS" name="grupo" id="g1" value="sist"checked>
                                        <label for="sistemas">Sistemas</label>
                                    </div>
                                    <div>
                                        <input type="radio" id="grupoMantenimientoCS" name="grupo" id="g2" value="mant">
                                        <label for="mantenimiento">Mantenimiento</label>
                                    </div>
                                </div>
                            </fieldset> 
                        </div>
                        <div class="form-group col-md-1"></div>
                        <div class="form-group col-md-3">
                            <label><h6>Tipo</h6></label>
                            <select id="selectTipo" name="tipoGrupo_CS" class="form-control" model="selected" onchange="filtrarSubtipo(this.value)" required>
                                <option selected disabled hidden style='display: none' value=''></option>
                                <c:forEach items="${listarTiposCS}" var="tipoGrupo">
                                    <option value="${tipoGrupo.idTipo}">${tipoGrupo.nombreTipo}</option> 
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-md-1"></div>       
                        <div class="form-group col-md-3">
                            <label><h6>Subtipo</h6></label>
                            <select id="selectSubtipo" name="subtipo_CS" class="form-control" model="selected" required>
                                <option selected disabled hidden style='display: none' value=''></option>
                                <c:forEach items="${listarSubtipo_CS}" var="subtipo">
                                    <option value="${subtipo.tipoGrupo.idTipo}-${subtipo.idSubtipo}">${subtipo.nombreSubtipo}</option> 
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <br>
                <div class="card">
                    <div class="form-row card-body">
                        <div class="form-group col-md-8">
                            <label><h6>Descripcion</h6></label>
                            <textarea class="form-control" name="descripcion" id="descripcionCS" v-model="text" rows="5" required></textarea>
                        </div>
                        <div class="form-group col-md-1"></div>
                        <div class="form-group col-md-3">
                            <label><h6>N� de Reincidencias</h6></label>
                            <select id="reincidencia" name="nvez" class="form-control" model="selected" required>
                                <option selected disabled hidden style='display: none' value=''></option>
                                <option value="1">1vez</option>   
                                <option value="2">2vez</option>
                                <option value="3">3vez</option>
                                <option value="4">4vez</option>
                            </select>
                            <br>
                            <label><h6>IDs de ayudas</h6></label>
                            <input type="text" class="form-control" name="idsnvez" id="ids_aydudasCS" value="null" readonly="readonly">
                        </div>
                    </div>
                </div>
                <br>
                <div class="card">
                    <div class="form-row card-body">
                        <div class="form-group col-md-3">
                            <label><h6>ID Administrador</h6></label>
                            <input type="text" class="form-control" name="idAdmin" value="${idAdmin}" readonly="readonly">
                        </div>
                        <div class="form-group col-md-1"></div>
                        <div class="form-group col-md-3">
                            <label><h6>Tecnico</h6></label>
                            <select id="selectTecnico" name="tecnico_cs" class="form-control" model="selected" required>
                                <option selected disabled hidden style='display: none' value=''></option>
                                <c:forEach items="${listarTecnicoCS}" var="tecnico">
                                    <option value="${tecnico.idUsuario}">${tecnico.nombre} ${tecnico.apellido}</option> 
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-md-2"></div>
                        <div class="form-group col-md-3">
                            <label><h6>Usuario Solicita Ayuda</h6></label>
                            <input type="text" class="form-control cargarTogleUsuarios" name="idUserSolicitaA" id="idUserSolicitaA" required>
                        </div>
                    </div>
                </div>
                <br>
                <div class="card">
                    <div class="form-row card-body">
                        <div class="form-group col-md-9">
                            <div class="form-row">
                                <label class="col-md-3"><h6>Fecha Inicio</h6></label>
                                <div class="form-group col-md-1"> </div>
                                <div class="form-group">
                                    <div class="input-group date" id="dtPickerFI" data-target-input="nearest">
                                         <input type="text" name="fechaInicio_cs" class="form-control datetimepicker-input" data-target="#dtPickerFI" required="true"/>
                                         <div class="input-group-append" data-target="#dtPickerFI" data-toggle="datetimepicker">
                                             <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                         </div>
                                     </div>
                                 </div>
                            </div>
                        </div>
                        <div class="form-group col-md-3">
                            <label><h6>Estado Solicitud</h6></label>
                        </div>
                        <div class="form-group col-md-9">
                            <div class="form-row">
                                <label class="col-md-3"><h6>Fecha Fin</h6></label>
                                <div class="form-group col-md-1"> </div>
                                <div class="form-group">
                                    <div class="input-group date" id="dtPickerFF" data-target-input="nearest">
                                         <input type="text" name="fechaFin_cs" class="form-control datetimepicker-input" data-target="#dtPickerFF" required="true"/>
                                         <div class="input-group-append" data-target="#dtPickerFF" data-toggle="datetimepicker">
                                             <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                         </div>
                                     </div>
                                 </div>
                            </div>
                        </div>
                        <div class="form-group col-md-3">
                            <select id="estadoSolicitud_cs" name="estado_cs" class="form-control" model="selected" required>
                                <option selected disabled hidden style='display: none' value=''></option>
                                <option value="pendiente">pendiente</option>   
                                <option value="asignada">asignada</option>
                                <option value="finalizada">finalizada</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary"  id="enviarSolicitud_CS">Enviar Solicitud</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--Modal o mop up de la tabla emergente para escoger las ayudas solicitidas-->
<div id="myModalCS" class="modal fade bd-example" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title">Seleccione el Usuario que solicita ayuda</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                  <form id="idsUSA">
                      <table id="dtUsuariosSA" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Id</th>
                                <th class="th-sm">Usuario</th>
                                <th class="th-sm"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listaUsuariosSA}" var="usuariosSA">
                                <tr>
                                    <th class="idsolicitud" scope="row">${usuariosSA.idUsuario}</th>
                                    <td>${usuariosSA.nombre} ${usuariosSA.apellido}</td>
                                    <td><input type="checkbox" name="name1" value="${usuariosSA.idUsuario}"/>&nbsp;</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                  </form>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-primary" id="cargarIdUSA" data-dismiss="modal">Aceptar</button>
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
              </div>
          </div>
      </div>
  </div>
                                
