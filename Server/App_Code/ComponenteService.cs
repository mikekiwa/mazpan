using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;


/// <summary>
/// Descripción breve de ComponenteService
/// </summary>
[WebService(Namespace = "http://tempuri.org/ComponentesService")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class ComponenteService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;

    public ComponenteService ()
    {
    }

    [WebMethod]
    public int agregarComponentes(string tipo, string codigo,string sistema,string nombre,string costo,string vidaUtil,
					             string descripcion,string marca,string ano,string pais,string modelo,string fabricante)
    {
        String select = "SELECT COUNT(*) FROM Componentes WHERE codigo = '" + codigo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO Componentes([tipo],[codigo],[sistema],[nombre],[costo],[vidaUtil],[descripcion],[marca],[ano],[pais],[modelo],[fabricante])"+
                                " VALUES('"+tipo+"','"+codigo+"','"+sistema+"','"+nombre+"','"+costo+"','"+vidaUtil+"','"+descripcion+"','"+marca+"','"+ano+"','"+pais+"','"+modelo+"','"+fabricante+"')";
                SqlConnection cn = new SqlConnection(coneccionString);
                cn.Open();
                SqlCommand insert = new SqlCommand(query, cn);

                int result = insert.ExecuteNonQuery();
                cn.Close();
                return result;
            }
            else 
            {
                return -1;
            }
        }

        selectConn.Close();

        return 0;
    }
    
    
}

