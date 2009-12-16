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

    private String coneccionString = Coneccion.coneccionString;
    
    public UsuarioService ()
    { 
    }

    [WebMethod]
    public string validarUsuario(String userName, String password)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = "SELECT privilegio FROM Usuario WHERE Usuario.userName='" + userName + "' AND Usuario.password='" + password + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            return reader.GetInt32(0) + "";
        }

        return "0";
    }
}

