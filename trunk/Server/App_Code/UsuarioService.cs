using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Descripción breve de UsuarioService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/UsuarioService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class UsuarioService : System.Web.Services.WebService
{

    private String coneccionString = Coneccion.coneccionStringSVRMASPAN;
    
    public UsuarioService ()
    { 
    }

    [WebMethod]
    public string validarUsuario(String userName, String password)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = "SELECT privilegio FROM PracticaDb.dbo.Usuario T1 WHERE T1.userName='" + userName + "' AND T1.password='" + password + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            return reader.GetString(0);
        }

        return "0";
    }

    [WebMethod]
    public Personal getUsuario(Usuario u)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = " SELECT T1.* FROM [PracticaDb].[dbo].Personal T1 JOIN [PracticaDb].[dbo].Usuario T2 ON T1.rut=T2.rut_persona WHERE T2.userName='" + u.user + "' AND T2.password='" + u.pass + "' ";
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
}

