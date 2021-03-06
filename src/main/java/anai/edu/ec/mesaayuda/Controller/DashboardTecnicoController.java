
package anai.edu.ec.mesaayuda.Controller;

import anai.edu.ec.mesaayuda.DAO.ISolicitudDao;
import anai.edu.ec.mesaayuda.DAO.IUsuarioDao;
import anai.edu.ec.mesaayuda.DaoImplementacion.SolicitudImpl;
import anai.edu.ec.mesaayuda.DaoImplementacion.UsuarioImpl;
import anai.edu.ec.mesaayuda.Entity.SolicitudAyuda;
import anai.edu.ec.mesaayuda.Entity.SolicitudTabla;
import anai.edu.ec.mesaayuda.Entity.Usuario;
import anai.edu.ec.mesaayuda.Service.ServiceResponse;
import static anai.edu.ec.mesaayuda.Service.SessionUsuario.obtenerSessionUsuario;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author bryan
 */
@Controller
@RequestMapping( "/dashboard" )
@RestController
public class DashboardTecnicoController {
    private Usuario usuario;
    private ISolicitudDao solicitudDao = new SolicitudImpl();
    private IUsuarioDao usuarioDao = new UsuarioImpl();
    private DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

    /***
     * 
     * @param request
     * @param response
     * @return list de técnico con sus solicitudes que tienen como estado inactiva, proceso, reevaluar, y finalizada en caso
     * de que la solicitud tenga como fechaFinTecnico la fecha del dia actual
     */
    @GetMapping( "/tecnico")
    public ResponseEntity<Object> cargarNuevasSolicitudes(HttpServletRequest request, HttpServletResponse response){
        ServiceResponse<Map<Integer,List<SolicitudTabla>>> respo = null;
        usuario = obtenerSessionUsuario(request, response);
        String grupo = usuario.getRol().split("_")[1];
//        List<Usuario> listaTecnicos = usuarioDao.obtenerElementos(grupo);
        try{
            Map<Integer,List<SolicitudTabla>> listaTecnicoS = new HashMap<>();
            List<SolicitudAyuda> listaSolicitud = solicitudDao.solicitudesDashboardTecnico(grupo);
            for(SolicitudAyuda sol : listaSolicitud){
                if(!listaTecnicoS.containsKey(sol.getUsuarioByIdUserTecnico().getIdUsuario())){
                    List<SolicitudTabla> st = new ArrayList<>();
                    SolicitudTabla solicitud = retornoSolicitud(sol);
                    if(solicitud != null){
                        st.add(solicitud);
                        listaTecnicoS.put(sol.getUsuarioByIdUserTecnico().getIdUsuario(), st);
                    }

                }
                else if(listaTecnicoS.containsKey(sol.getUsuarioByIdUserTecnico().getIdUsuario())){
                    SolicitudTabla solicitud = retornoSolicitud(sol);
                    if(solicitud != null){
                        List<SolicitudTabla> st = listaTecnicoS.get(sol.getUsuarioByIdUserTecnico().getIdUsuario());
                        st.add(solicitud);
                        listaTecnicoS.put(sol.getUsuarioByIdUserTecnico().getIdUsuario(), st);
                    }
                }
            }
            
            respo = new ServiceResponse<>("success",listaTecnicoS);
        }
        catch(Exception exc){
            exc.printStackTrace();
        }
        return new ResponseEntity<Object>(respo, HttpStatus.OK);   
    }
    
    private SolicitudTabla retornoSolicitud(SolicitudAyuda sol){
        SolicitudTabla solicitud = new SolicitudTabla();
        try{
                solicitud.setId(sol.getId().getIdSolicitud());
                solicitud.setUserSolicitaAyuda(sol.getUsuarioByIdUserSolicitaAyuda().getNombre()+" "+sol.getUsuarioByIdUserSolicitaAyuda().getApellido());
                solicitud.setUserTecnico(sol.getUsuarioByIdUserTecnico().getNombre()+" "+sol.getUsuarioByIdUserTecnico().getApellido());
                solicitud.setDescripcion(sol.getDescripcion());
                solicitud.setTipo(sol.getUsuarioByIdUserTecnico().getTipoGrupo().getNombreTipo());
                solicitud.setFechaInicio(dateFormat.format(sol.getFechaInicio()));
                solicitud.setFechaFin(dateFormat.format(sol.getFechaFin()));
                solicitud.setEstadoSolicitudTecnico(sol.getEstadoSolicitudTecnico());
                if(sol.getFechaInicioTecnico() == null || String.valueOf(sol.getFechaInicioTecnico()).equals("null"))
                    solicitud.setFechaInicioTecnico("");
                else 
                    solicitud.setFechaInicioTecnico(dateFormat.format(sol.getFechaInicioTecnico()));
                if(sol.getFechaFinTecnico()== null || String.valueOf(sol.getFechaFinTecnico()).equals("null"))
                    solicitud.setFechaFinTecnico("");
                else
                    solicitud.setFechaFinTecnico(dateFormat.format(sol.getFechaFinTecnico()));
        }
        catch(Exception exc){
            exc.printStackTrace();
        }
        return solicitud;
    }
    
    
}
