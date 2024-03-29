<%@ WebService Language="C#" CodeBehind="CombosService.cs" Class="CombosService" %>

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
[WebService(Namespace = "http://tempuri.org/Server/CombosService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CombosService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;
    private string MAER = Coneccion.PracticaDbMaspan;
    

    public CombosService ()
    {
    }


    [WebMethod]
    public DataSet getExcel(string nombre)
    {
        File f = new File();
        DataSet dataset = f.getExcel2(nombre);
        return dataset;
    }

    [WebMethod]
    public int agregarPais(String pais)
    {
        String select = "SELECT COUNT(*) FROM " + MAER + ".[Paises] WHERE pais = '" + pais + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO " + MAER + ".[Paises](pais) VALUES('" + pais + "')";
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
        String query = "SELECT T1.pais, T1.nombreCorto FROM " + MAER + ".[Paises] T1";

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
        String select = "SELECT COUNT(*) FROM " + MAER + ".[TipoElemento] WHERE tipo = '" + tipo + "' AND codigo='CMP'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO " + MAER + ".[TipoElemento](tipo, codigo) VALUES('" + tipo + "', 'CMP')";
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
        String query = " SELECT tipo FROM " + MAER + ".[TipoElemento] T1 WHERE T1.codigo='CMP' ";

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
        String select = "SELECT COUNT(*) FROM " + MAER + ".[TipoElemento] WHERE tipo = '" + tipo + "' AND codigo='MAQ'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO " + MAER + ".[TipoElemento](tipo,codigo) VALUES('" + tipo + "', 'MAQ')";
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
        String query = " SELECT tipo FROM " + MAER + ".[TipoElemento] T1 WHERE T1.codigo='MAQ' ";

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
        String select = "SELECT COUNT(*) FROM " + MAER + ".[TipoEspecificacion] WHERE tipo = '" + especificacion + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO " + MAER + ".[TipoEspecificacion](especificacion) VALUES('" + especificacion + "')";
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
        String query = " SELECT especificacion FROM " + MAER + ".[TipoEspecificacion] ";

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
    public string getFecha()
    {
        DateTime hoy = DateTime.Now;
        string h = hoy.Day + "-";

        if (hoy.Month == 1) h += "Enero-";
        else if (hoy.Month == 2) h += "Febrero-";
        else if (hoy.Month == 3) h += "Marzo-";
        else if (hoy.Month == 4) h += "Abril-";
        else if (hoy.Month == 5) h += "Mayo-";
        else if (hoy.Month == 6) h += "Junio-";
        else if (hoy.Month == 7) h += "Julio-";
        else if (hoy.Month == 8) h += "Agosto-";
        else if (hoy.Month == 9) h += "Septiembre-";
        else if (hoy.Month == 10) h += "Octubre-";
        else if (hoy.Month == 11) h += "Noviembre-";
        else h += "Diciembre-";

        h += hoy.Year;

        return h;
    }
}


