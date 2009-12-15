using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;


/// <summary>
/// Descripción breve de LineaService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class LineaService : System.Web.Services.WebService 
{
    private string coneccionString = Coneccion.coneccionString;

    public LineaService () 
    {
    }

    [WebMethod]
    public int addLinea(Linea l)
    {
        String select = "SELECT COUNT(*) FROM Lineas WHERE codigo = '" + l.codigo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO Lineas(codigo,nombre,descripcion,encargado)" +
                               " VALUES('"+l.codigo+"','"+l.nombre+"','"+l.descripcion+"','"+l.encargado+"')";
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
    public DataTable allLineas()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Lineas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM Lineas";

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

    [WebMethod(Description = "Elimina una linea por codigo")]
    public int delLinea(string codigo)
    {
        String query = "DELETE FROM Lineas WHERE codigo='" + codigo + "'";
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        SqlCommand delete = new SqlCommand(query, cn);

        try
        {
            int result = delete.ExecuteNonQuery();
            cn.Close();
            return result;
        }
        catch
        {
            cn.Close();
            return -2;
        }
    }

    [WebMethod]
    public int addMantenciones(List<Mantencion> mantenciones, string codigo)
    {
        String queryDelete = "DELETE FROM ActividadMantencionLineas WHERE codigo='" + codigo + "'";
        SqlConnection cndel = new SqlConnection(coneccionString);
        cndel.Open();
        SqlCommand delete = new SqlCommand(queryDelete, cndel);

        try
        {
            delete.ExecuteNonQuery();
            cndel.Close();
        }
        catch
        {
            cndel.Close();
            return -2;
        }

        SqlConnection cn = new SqlConnection(coneccionString);
        int result = 0;
        cn.Open();
        try
        {
            int orden = 0;
            foreach (Mantencion m in mantenciones)
            {
                orden++;
                String query = "INSERT INTO ActividadMantencionLineas(actividad, orden, tipo, frecuencia, codigo)" +
                               " VALUES('" + m.actividad + "','" + orden + "','" + m.mantencion + "','" + m.frecuencia + "','" + codigo + "')";

                SqlCommand insert = new SqlCommand(query, cn);

                result += insert.ExecuteNonQuery();
            }
            cn.Close();
        }
        catch
        {//Puede ser que el codigo ya no exista, (por la concurrencia)
            cn.Close();
            return -2;
        }
        if (mantenciones.Count == result) return 1;
        return 0;
    }

    [WebMethod]
    public DataTable getMantencion(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "ActividadMantencionLineas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM ActividadMantencionLineas WHERE codigo='" + codigo + "'";

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

