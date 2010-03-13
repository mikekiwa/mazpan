using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de EvaluacionService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/EvaluacionService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class EvaluacionService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;
    private string SAP = "[Maspan].[dbo]";
    private string MAER = "[PracticaDb].[dbo]";

    public EvaluacionService ()
    {
    }

    private DataTable obtenerTabla(string nombre, string query)
    {
        DataTable dt = new DataTable();
        dt.TableName = nombre;

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        
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
    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="query">
    /// La consulta que se desea ejecutar
    /// </param>
    private int Ejecutar(string query)
    {
        SqlConnection conn = new SqlConnection(coneccionString);
        conn.Open();
        SqlCommand insert = new SqlCommand(query, conn);

        try
        {
            insert.ExecuteNonQuery();
            conn.Close();
        }
        catch
        {
            conn.Close();
            return 0;
        }
        return 1;
    }
    
    public bool existe(string from, string where)
    {
        String query = " SELECT COUNT(*) FROM " + from + " WHERE " + where + " ";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand select = new SqlCommand(query, selectConn);
        SqlDataReader reader = select.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return false;
        }
    }



    [WebMethod]
    public DataTable getCategorias()
    {
        return obtenerTabla("Categorias"," SELECT * FROM "+MAER+".[Categoria]");
    }
    [WebMethod]
    public int guardarCategorias(List<Categoria> categorias)
    {
        string delete = " DELETE "+MAER+".[Categoria]";
        if(categorias.Count>0) delete += " WHERE id!="+categorias[0].id; 
        for(int i=1; i<categorias.Count; i++)
        {
            if (categorias[i].id!=null) delete += " AND id!=" + categorias[i].id; 
        }
        Ejecutar(delete);

        int result = 0;

        foreach (Categoria c in categorias)
        {
            if (c.id != null)
            {
                result += Ejecutar("UPDATE " + MAER + ".[Categoria] SET nombre='" + c.nombre + "', descripcion='" + c.descripcion + "', porcentaje='" + c.porcentaje + "' WHERE id='" + c.id + "'");
            }
            else
            {
                result += Ejecutar("INSERT INTO " + MAER + ".[Categoria] (nombre,descripcion,porcentaje) VALUES('" + c.nombre + "','" + c.descripcion + "','" + c.porcentaje + "') ");
            }
        }

        if (result == categorias.Count) return 1;
        else return 0;
    }

    
    [WebMethod]
    public DataTable getItemCategoria()
    {
        return obtenerTabla("ItemCategoria", " SELECT T2.*, T3.* FROM " + MAER + ".[ItemCategoria] T1 JOIN " + MAER + ".[ItemsEvaluacion] T2 ON T1.item=T2.id JOIN " + MAER + ".[Categoria] T3 ON T1.categoria=T3.id ");
    }
    [WebMethod]
    public DataTable getItemsLibres()
    {
        return obtenerTabla("ItemsLibres", " SELECT * FROM "+MAER+".[ItemsEvaluacion] WHERE id NOT IN (SELECT T2.id FROM "+MAER+".[ItemCategoria] T1 JOIN "+MAER+".[ItemsEvaluacion] T2 ON T1.item=T2.id JOIN "+MAER+".[Categoria] T3 ON T1.categoria=T3.id) ");
    }
    [WebMethod]
    public int delItemCategoria(string item, string categoria)
    {
        return Ejecutar(" DELETE "+MAER+".[ItemCategoria] WHERE item='"+item+"' AND categoria='"+categoria+"' ");
    }
    [WebMethod]
    public int addItemCategoria(string item, string categoria)
    {
        if (!existe(MAER + ".[ItemCategoria]", "item='"+item+"' AND categoria='"+categoria+"' "))
            return Ejecutar(" INSERT INTO " + MAER + ".[ItemCategoria] (item,categoria) VALUES('" + item + "','" + categoria + "') ");
        else return 0;
    }


    [WebMethod]
    public DataTable getItems()
    {
        return obtenerTabla("ItemsEvaluacion", " SELECT * FROM " + MAER + ".[ItemsEvaluacion]");
    }
    [WebMethod]
    public int guardarItem(string item, string descripcion)
    {
        return Ejecutar("INSERT INTO " + MAER + ".[ItemsEvaluacion] (item,descripcion) VALUES('" + item + "','" + descripcion + "') ");
    }
    [WebMethod]
    public int editarItem(string id, string item, string descripcion)
    {
        return Ejecutar("UPDATE " + MAER + ".[ItemsEvaluacion] SET item='" + item + "', descripcion='" + descripcion + "' WHERE id = '" + id + "' ");
    }
    [WebMethod]
    public int eliminarItem(string id)
    {
        return Ejecutar("DELETE " + MAER + ".[ItemsEvaluacion] WHERE id = '" + id + "' ");
    }


    [WebMethod]
    public DataTable getSecciones()
    {
        return obtenerTabla("Secciones", " SELECT * FROM " + MAER + ".[Seccion] ");
    }
    [WebMethod]
    public int guardarSeccion(string nombre, string descripcion)
    {
        return Ejecutar("INSERT INTO " + MAER + ".[Seccion] (nombre,descripcion) VALUES('" + nombre + "','" + descripcion + "') ");
    }
    [WebMethod]
    public int editarSeccion(string id, string nombre, string descripcion)
    {
        return Ejecutar("UPDATE " + MAER + ".[Seccion] SET nombre='" + nombre + "', descripcion='" + descripcion + "' WHERE id = '" + id + "' ");
    }
    [WebMethod]
    public int eliminarSeccion(string id)
    {
        return Ejecutar("DELETE " + MAER + ".[Seccion] WHERE id = '" + id + "' ");
    }
    

    [WebMethod]
    public DataTable getItemSeccion(string seccion)
    {
        return obtenerTabla("ItemsSeccion", " SELECT T1.*,T2.* FROM "+MAER+".[ItemsSeccion] T1 RIGHT JOIN "+MAER+".[ItemsEvaluacion] T2 ON T1.item=T2.id AND T1.seccion = '"+seccion+"'");
    }
    [WebMethod]
    public int addItemSeccion(string seccion, string item)
    {
        return Ejecutar("INSERT INTO " + MAER + ".[ItemsSeccion] (seccion,item) VALUES('"+seccion+"','"+item+"') ");
    }
    [WebMethod]
    public int delItemSeccion(string id)
    {
        return Ejecutar("DELETE " + MAER + ".[ItemsSeccion] WHERE id = '" + id + "' ");
    }

    [WebMethod]
    public int editClienteSeccion(string id, string seccion)
    {
        return Ejecutar(" UPDATE "+MAER+".[Clientes] SET seccion='"+seccion+"' WHERE id='"+id+"' ");
    }
    [WebMethod]
    public int addClienteSeccion(string cliente, string seccion)
    {
        return Ejecutar(" INSERT INTO " + MAER + ".[Clientes] (cliente,seccion) VALUES ('" + cliente + "','" + seccion + "') ");
    }
    [WebMethod]
    public int delClienteSeccion(string id)
    {
        return Ejecutar(" DELETE " + MAER + ".[Clientes] WHERE id='"+id+"' ");
    }
    [WebMethod]
    public DataTable getSociosDe(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T2.CardName,T2.CardCode,T2.LicTradNum,T3.*,T4.* FROM "+SAP+".[OWHS] T1 JOIN "+SAP+".[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj LEFT JOIN "+MAER+".Clientes T3 ON T3.cliente=T2.CardCode LEFT JOIN "+MAER+".[Seccion] T4 ON T4.id = T3.seccion WHERE WhsCode='"+local+"' ";

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
    public DataTable getSocios(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T2.CardName,T2.CardCode,T2.LicTradNum,T3.*,T4.* FROM " + SAP + ".[OWHS] T1 JOIN " + SAP + ".[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj JOIN " + MAER + ".Clientes T3 ON T3.cliente=T2.CardCode LEFT JOIN " + MAER + ".[Seccion] T4 ON T4.id = T3.seccion WHERE WhsCode='" + local + "' ";

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
    public DataTable getItemsDe(string cliente)
    {
        return obtenerTabla("Items"," SELECT T4.*,T6.* FROM "+MAER+".[Clientes] T1 JOIN "+MAER+".[Seccion] T2 ON T1.seccion=T2.id JOIN "+MAER+".[ItemsSeccion] T3 ON T3.seccion=T2.id JOIN "+MAER+".[ItemsEvaluacion] T4 ON T3.item=T4.id JOIN "+MAER+".[ItemCategoria] T5 ON T5.item=T4.id JOIN "+MAER+".[Categoria] T6 ON T5.categoria=T6.id WHERE T1.cliente='"+cliente+"' ");
    }
}

