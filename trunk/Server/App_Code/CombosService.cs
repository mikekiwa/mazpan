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
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;

    public CombosService ()
    {
    }

    [WebMethod]
    public int agregarPais(String pais)
    {
        String select = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[Paises] WHERE pais = '" + pais + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO [PracticaDb].[dbo].[Paises](pais) VALUES('" + pais + "')";
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
        String query = "SELECT T1.pais, T1.nombreCorto FROM [PracticaDb].[dbo].[Paises] T1";

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
        String select = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[TipoElemento] WHERE tipo = '" + tipo + "' AND codigo='CMP'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO [PracticaDb].[dbo].[TipoElemento](tipo, codigo) VALUES('" + tipo + "', 'CMP')";
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
        String query = " SELECT tipo FROM [PracticaDb].[dbo].[TipoElemento] T1 WHERE T1.codigo='CMP' ";

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
        String select = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[TipoElemento] WHERE tipo = '" + tipo + "' AND codigo='MAQ'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO [PracticaDb].[dbo].[TipoElemento](tipo,codigo) VALUES('" + tipo + "', 'MAQ')";
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
        String query = " SELECT tipo FROM [PracticaDb].[dbo].[TipoElemento] T1 WHERE T1.codigo='MAQ' ";

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
    public int agregarTipoEspecificacion(String especificacion)
    {
        String select = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[TipoEspecificacion] WHERE tipo = '" + especificacion + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO [PracticaDb].[dbo].[TipoEspecificacion](especificacion) VALUES('" + especificacion + "')";
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
        String query = " SELECT especificacion FROM [PracticaDb].[dbo].[TipoEspecificacion] ";

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

