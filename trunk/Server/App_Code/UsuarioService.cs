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
[WebService(Namespace = "http://tempuri.org/")]
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
}

