﻿using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;


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
    public int addComponente(string tipo, string codigo,string sistema,string nombre,string costo,string vidaUtil,
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

    [WebMethod]
    public DataTable allComponentes()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Componentes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM Componentes";

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

    [WebMethod(Description = "Elimina un componente por codigo")]
    public int delComponente(string codigo)
    {
        String query = "DELETE FROM Componentes WHERE codigo='" + codigo + "'";
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
    public DataTable getComponente(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Componente";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM Componentes WHERE codigo='"+codigo+"'";

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
    public int addEspecificacion(List<Especificacion> especificaciones, string codigo)
    {
        String queryDelete = "DELETE FROM DatosRelevantesComponentes WHERE codigo='" + codigo + "'";
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
        int result=0;
        cn.Open();
        try
        {
            foreach (Especificacion e in especificaciones)
            {
                String query = "INSERT INTO DatosRelevantesComponentes(especificacion, valor, codigo)" +
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
        if(especificaciones.Count==result) return 1;
        return 0;
    }

    [WebMethod]
    public DataTable getEspecificacion(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "DatosRelevantesComponentes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM DatosRelevantesComponentes WHERE codigo='" + codigo + "'";

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
    public int addMantencion(List<Mantencion> mantenciones, string codigo)
    {
        String queryDelete = "DELETE FROM ActividadMantencionComponentes WHERE codigo='" + codigo + "'";
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
                String query = "INSERT INTO ActividadMantencionComponentes(actividad, orden, tipo, frecuencia, codigo)" +
                               " VALUES('"+m.actividad+"','"+orden+"','"+m.mantencion+"','"+m.frecuencia+"','"+codigo+"')";

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
        dt.TableName = "ActividadMantencionComponentes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM ActividadMantencionComponentes WHERE codigo='" + codigo + "'";

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

