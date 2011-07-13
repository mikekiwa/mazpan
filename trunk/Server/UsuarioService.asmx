<%@ WebService Language="C#" CodeBehind="/App_Code/UsuarioService.cs" Class="UsuarioService" %>

using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Descripci�n breve de UsuarioService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/UsuarioService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class UsuarioService : System.Web.Services.WebService
{
    private String coneccionString = ConeccionMaspan.coneccionStringSVRMASPAN;
    private string MAER = ConeccionMaspan.PracticaDb;
   
    public UsuarioService ()
    { 
    }


    /// <summary>
    /// return 1 s� la insercion fue exitosa, 0 EOC
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
    /// Permite ver si un usuario es valido.
    /// retorna el usuario si este es valido, 0 EOC
    /// </summary>
    /// <param name="userName">nombre de usuario del usuario que se intenta logear</param>
    /// <param name="password">contrase�a del usuario que se intenta logear</param>
    /// <returns>usuario si este es valido, null EOC</returns>
    [WebMethod]
    public Usuario validarUsuario(String userName, String password)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = "SELECT T1.estadoResultado+T1.amarre+T1.general+T1.agentesExternos+T1.personal+T1.mantenciones+T1.planMantecion+T1.ventas+T1.locales+T1.configurarEvaluacion+T1.evaluacion+T1.sistema as privilegio,T2.planta,T1.rut_persona FROM PracticaDb.dbo.Usuario T1 JOIN PracticaDb.dbo.Personal T2 ON T1.rut_persona=T2.rut WHERE T1.userName='" + userName + "' AND T1.password='" + password + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        Usuario u = null;

        if (reader.Read())
        {
            u = new Usuario();
            u.user = userName;
            u.pass = password;
            u.privilegio = reader.GetString(0);
            if (!reader.IsDBNull(1)) u.planta = reader.GetString(1); else u.planta = null;
            if (!reader.IsDBNull(2)) u.rut_persona = reader.GetString(2); else u.rut_persona=null;
        }

        return u;
    }


    /// <summary>
    /// Permite obtener los datos personales de un usuario en el sistema
    /// </summary>
    /// <param name="u">El usuario por el que se esta consultando</param>
    /// <returns>Datos personales de un usuario en el sistema</returns>
    [WebMethod]
    public Personal getUsuario(Usuario u)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = " SELECT T1.* FROM " + MAER + ".Personal T1 JOIN " + MAER + ".Usuario T2 ON T1.rut=T2.rut_persona WHERE T2.userName='" + u.user + "' AND T2.password='" + u.pass + "' ";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        Personal p = null;

        if (reader.Read())
        {
            p = new Personal();
            p.rut = reader.GetString(0);
            p.nombres = reader.GetString(1);
            p.apellidoPaterno = reader.GetString(2);
            p.apellidoMaterno = reader.GetString(3);
        }

        return p;
    }


    /// <summary>
    /// Permite obtener los usuarios en el sistema
    /// </summary>
    /// <returns>Lista de usuarios en el sistema</returns>
    [WebMethod]
    public DataTable allUsuario()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Usuarios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
//        String query = " SELECT T1.estadoResultado+'3'+T1.amarre+'3'+T1.general+'3'+T1.agentesExternos+'3'+T1.personal+'3'+T1.mantenciones+'3'+T1.planMantecion+'3'+T1.ventas+'3'+T1.locales+'3'+T1.configurarEvaluacion+'3'+T1.evaluacion+'3'+T1.sistema+'3' as privilegio,* FROM " + MAER + ".Usuario T1 JOIN " + MAER + ".Personal T2 ON T1.rut_persona=T2.rut WHERE visible='True' ";
        String query = " SELECT T1.estadoResultado+"+
                                "T1.amarre+"+
                                "T1.general+"+
                                "T1.agentesExternos+"+
                                "T1.personal+"+
                                "T1.mantenciones+"+
                                "T1.planMantecion+"+
                                "T1.ventas+"+
                                "T1.locales+"+
                                "T1.configurarEvaluacion+"+
                                "T1.evaluacion+"+
                                "T1.sistema as privilegio"+
                                ",*"+
                        "FROM " + MAER + ".Usuario T1 JOIN " + MAER + ".Personal T2 ON T1.rut_persona=T2.rut WHERE visible='True' ";

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
    /// Permite eliminar un usuario.
    /// retorna 1 s� la eliminaci�n fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El usuario que se desea eliminar</param>
    /// <returns>1 s� la eliminaci�n fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int delUsuario(Usuario u)
    {
        string query = " DELETE " + MAER + ".Usuario WHERE id='" + u.id + "' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// Permite insertar un nuevo usuario.
    /// retorna 1 s� la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El usuario que se desea agregar</param>
    /// <returns>1 s� la insercion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int addUsuario(Usuario u)
    {
        string query = " INSERT INTO " + MAER + ".Usuario (rut_persona,userName,password,privilegio,visible) VALUES ('" + u.rut_persona + "','" + u.user + "','" + u.pass + "','" + u.privilegio + "','True') ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// Permite editar los datos de un Usuario
    /// retona 1 si la edicion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="nuevo">Datos del usuario editado</param>
    /// <param name="actual">Copia datos viejos (� actuales) del usuario</param>
    /// <returns>1 si la edicion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int editUsuario(Usuario nuevo, Usuario actual)
    {
        string query = " UPDATE " + MAER + ".Usuario SET userName='"+nuevo.user+"',password='"+nuevo.pass+"',privilegio='"+nuevo.privilegio+"' WHERE rut_persona='"+actual.rut_persona+"' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    private DataTable obtenerTabla(string nombre, string query)
    {
        DataTable dt = new DataTable();
        dt.TableName = nombre;

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();


        SqlCommand cmd = new SqlCommand(query, cn);
        cmd.CommandTimeout = 180;
        da.SelectCommand = cmd;

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

    [WebMethod]
    public DataTable getMenus()
    {
        string sql = "SELECT * from " + MAER + ".Menus T0 JOIN " + MAER + ".Opciones T1 ON T0.id=T1.menu";
        return obtenerTabla("Menus",sql);
    }
}

