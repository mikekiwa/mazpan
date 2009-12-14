using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

/// <summary>
/// Descripción breve de MaquinaService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class MaquinaService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;

    public MaquinaService ()
    {
    }

    [WebMethod]
    public int addMaquina(Maquina m)
    {
        String select = "SELECT COUNT(*) FROM Maquinas WHERE codigo = '" + m.codigo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO Maquinas(tipo,codigo,puestaMarcha,nombre,ubicacion,planta,estado,condicionRecepcion,costo,horasVidaUtil,horasActuales,horasDiariasPromedio,descripcion,marca,ano,pais,modelo,serie,fabricante)" +
                               " VALUES('"+m.tipo+"','"+m.codigo+"','"+m.puestaMarcha+"','"+m.nombre+"','"+m.ubicacion+"','"+m.planta+"','"+m.estado+"','"+m.condicionRecepcion+"','"+m.costo+"','"+m.horasVidaUtil+"','"+m.horasActuales+"','"+m.horasDiariasPromedio+"','"+m.descripcion+"','"+m.marca+"','"+m.ano+"','"+m.pais+"','"+m.modelo+"','"+m.serie+"','"+m.fabricante+"')";
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
    public DataTable allMaquinas()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Maquinas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM Maquinas";

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

    [WebMethod(Description = "Elimina una maquina por codigo")]
    public int delMaquina(string codigo)
    {
        String query = "DELETE FROM Maquinas WHERE codigo='" + codigo + "'";
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
    public int addEspecificaciones(List<Especificacion> especificaciones, string codigo)
    {
        String queryDelete = "DELETE FROM DatosRelevantesMaquinas WHERE codigo='" + codigo + "'";
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
            foreach (Especificacion e in especificaciones)
            {
                String query = "INSERT INTO DatosRelevantesMaquinas(especificacion, valor, codigo)" +
                               " VALUES('" + e.especificacion + "','" + e.valor + "','" + codigo + "')";

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
        if (especificaciones.Count == result) return 1;
        return 0;
    }

    [WebMethod]
    public DataTable getEspecificacion(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "DatosRelevantesMaquinas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM DatosRelevantesMaquinas WHERE codigo='" + codigo + "'";

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
    public int addMantenciones(List<Mantencion> mantenciones, string codigo)
    {
        String queryDelete = "DELETE FROM ActividadMantencionMaquinas WHERE codigo='" + codigo + "'";
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
                String query = "INSERT INTO ActividadMantencionMaquinas(actividad, orden, tipo, frecuencia, codigo)" +
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
        dt.TableName = "ActividadMantencionMaquinas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM ActividadMantencionMaquinas WHERE codigo='" + codigo + "'";

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
    public int addComponentes(List<Componente> componentes, string codigo)
    {
        String queryDelete = "DELETE FROM ComponenteMaquina WHERE codigoMaquina='" + codigo + "'";
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
            foreach (Componente c in componentes)
            {
                String query = "INSERT INTO ComponenteMaquina(codigoComponente, codigoMaquina)" +
                               " VALUES('"+c.codigo+"','"+codigo+"')";

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
        if (componentes.Count == result) return 1;
        return 0;
    }

    [WebMethod(Description="Entrega una lista de componentes asociados a una maquina en particular")]
    public DataTable getComponentes(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "ComponenteMaquina";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM ComponenteMaquina WHERE codigo='" + codigo + "'";

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

