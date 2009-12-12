using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;


/// <summary>
/// Descripción breve de CombosService
/// </summary>
[WebService(Namespace = "http://tempuri.org/CombosService")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CombosService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;

    public CombosService ()
    {
    }

    [WebMethod]
    public int agregarPais(String pais)
    {
        String select = "SELECT COUNT(*) FROM Paises WHERE pais = '"+pais+"'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO Paises([pais]) VALUES('" + pais + "')";
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
    [WebMethod]
    public DataTable Paises()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Paises";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT pais FROM Paises";

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

    [WebMethod]
    public int agregarTipoComponente(String tipo)
    {
        String select = "SELECT COUNT(*) FROM TipoComponente WHERE tipo = '" + tipo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO TipoComponente([tipo]) VALUES('" + tipo + "')";
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
    [WebMethod]
    public DataTable TipoComponente()
    {
        DataTable dt = new DataTable();
        dt.TableName = "TipoComponente";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT tipo FROM TipoComponente";

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

    [WebMethod]
    public int agregarTipoMaquina(String tipo)
    {
        String select = "SELECT COUNT(*) FROM TipoMaquina WHERE tipo = '" + tipo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO TipoMaquina([tipo]) VALUES('" + tipo + "')";
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
    [WebMethod]
    public DataTable TipoMaquina()
    {
        DataTable dt = new DataTable();
        dt.TableName = "TipoMaquinas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT tipo FROM TipoMaquina";

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

    [WebMethod]
    public int agregarTipoEspecificacion(String tipo)
    {
        String select = "SELECT COUNT(*) FROM TipoEspecificacion WHERE tipo = '" + tipo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO TipoEspecificacion([tipo]) VALUES('" + tipo + "')";
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
    [WebMethod]
    public DataTable TipoEspecificacion()
    {
        DataTable dt = new DataTable();
        dt.TableName = "TipoEspecificacion";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT tipo FROM TipoEspecificacion";

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
}

