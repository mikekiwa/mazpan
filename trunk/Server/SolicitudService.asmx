<%@ WebService Language="C#" CodeBehind="/App_Code/SolicitudService.cs" Class="SolicitudService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de SolicitudService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/SolicitudService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class SolicitudService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;
    private string MAER = Coneccion.PracticaDbMaspan;


    public SolicitudService()
    {
    }

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="query">
    /// La consulta que se desea ejecutar
    /// </param>
    private int Ejecutar(string query)
    {
        SqlConnection conn = new SqlConnection(coneccionString);
        conn.Open();
        SqlCommand insert = new SqlCommand(query, conn);

        try
        {
            insert.ExecuteNonQuery();
            conn.Close();
        }
        catch
        {
            conn.Close();
            return 0;
        }
        return 1;
    }


    /// <summary>
    /// Permite obtener todos las solicitudes de trabajos en el sistema que ha ingresado un usuario en particular
    /// </summary>
    /// <returns>Lista de solicitudes de trabajos en el sistema que ha ingresado un usuario en particular</returns>
    [WebMethod]
    public DataTable allSolicitudes(Usuario u)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Solicitudes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T1.*,convert(varchar(20),T1.solicitada, 105) solicitadaString,convert(varchar(20),T1.limite, 105) limiteString,T5.*,T4.especialidad,T4.otro FROM " + MAER + ".Solicitudes T1 JOIN " + MAER + ".Personal T2 ON T1.rutSolicitante=T2.rut JOIN " + MAER + ".Usuario T3 ON T2.rut=T3.rut_persona JOIN " + MAER + ".Tecnico T4 ON T1.idSolicitado=T4.id JOIN " + MAER + ".Personal T5 ON T4.rutTecnico=T5.rut WHERE T3.userName='" + u.user + "' AND T3.password='" + u.pass + "' AND T1.realizada<T1.solicitada ";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Permite obtener todas las solicitudes de trabajos en el sistema
    /// </summary>
    /// <returns>Lista de solicitudes de trabajos en el sistema</returns>
    [WebMethod]
    public DataTable listSolicitudes(Usuario u)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Solicitudes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T1.*,convert(varchar(20),T1.solicitada, 105) solicitadaString,convert(varchar(20),T1.limite, 105) limiteString,T5.*,T4.especialidad,T4.otro FROM " + MAER + ".Solicitudes T1 JOIN " + MAER + ".Personal T2 ON T1.rutSolicitante=T2.rut JOIN " + MAER + ".Usuario T3 ON T2.rut=T3.rut_persona JOIN " + MAER + ".Tecnico T4 ON T1.idSolicitado=T4.id JOIN " + MAER + ".Personal T5 ON T4.rutTecnico=T5.rut WHERE T1.realizada<T1.solicitada AND T2.planta='" + u.planta + "'";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }

    /// <summary>
    /// Permite eliminar tecnico.
    /// retorna 1 sí la eliminación fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El tecnico que se desea eliminar</param>
    /// <returns>1 sí la eliminación fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int delSolicitud(Solicitud s)
    {
        string query = " DELETE " + MAER + ".Solicitudes WHERE id='" + s.id + "' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// Permite insertar un nuevo tecnico
    /// retorna 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El tecnico que se desea agregar</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int addSolicitud(Solicitud s)
    {
        DateTime hoy = DateTime.Now;
        s.solicitada = hoy.Year + "-" + hoy.Month + "-" + hoy.Day;
        DateTime limit = hoy.AddDays(int.Parse(s.plazo));
        s.limite = limit.Year + "-" + limit.Month + "-" + limit.Day;

        string query = " INSERT INTO " + MAER + ".Solicitudes (solicitada,prioridad,actividad,plazo,detalle,rutSolicitante,idSolicitado,limite,realizada) VALUES ('" + s.solicitada + "','" + s.prioridad + "','" + s.actividad + "','" + s.plazo + "','" + s.detalle + "','" + s.rutSolicitante + "','" + s.idSolicitado + "','" + s.limite + "','') ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// retorna 1 sí la insercion de todos las activiades fue exitosa
    ///        -1 sí la insercion de algunos datos fue exitosa
    ///         0 EOC
    /// </summary>
    /// <param name="actividades">Lista de las actividades de mantencion que se quieren marcar como realizadas</param>
    /// <returns>1 sí la insercion de todos las activiades fue exitosa, -1 sí la insercion de algunos datos fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int realizarSolicitudes(List<Solicitud> solicitudes)
    {
        int result = 0;
        DateTime t = DateTime.Now;
        string hoy = t.Year + "-" + t.Month + "-" + t.Day;

        foreach (Solicitud s in solicitudes)
        {
            result += Ejecutar(" UPDATE " + MAER + ".Solicitudes SET realizada='" + hoy + "' WHERE id='" + s.id + "' ");
        }

        if (solicitudes.Count == result) return 1;
        else return -1;
    }
}

