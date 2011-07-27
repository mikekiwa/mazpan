<%@ WebService Language="C#" CodeBehind="/App_Code/EvaluacionService.cs" Class="EvaluacionService" %>

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
    private string coneccionString = Coneccion.coneccionString;
    private string SAP = Coneccion.SapDbMaspan;
    private string MAER = Coneccion.PracticaDbMaspan;
    
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

    public string getId(string from, string where)
    {
        string query = " SELECT convert(varchar(50),id) FROM " + from + " WHERE " + where + " ";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand select = new SqlCommand(query, selectConn);
        SqlDataReader reader = select.ExecuteReader();

        if (reader.Read())
        {
            return reader.GetString(0);
        }
         
        return "";
    }

    /**
     * -666 : demonio, inyeccion ect
     * -9   : la seccion existe, pero se intenta agregar una con el mismo nombre
     * -8   : fallo en la insercion de una nueva seccion
     * -7   : no todas las categorias han sido guardadas, quiza ninguna lo fue
     * -6   : falla la actualizacion de la seccion
     * -5   : no todas las categorias han sido guardadas o actualizadas, quiza ninguna lo fue
     */
    [WebMethod]
    public int guardarSeccion(Usuario u, Seccion seccion, List<Categoria> categorias)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            if (seccion.id==null)
            {
                if (!existe(MAER + ".[Seccion]", "nombre='" + seccion.nombre + "'"))
                {
                    if (Ejecutar("INSERT INTO " + MAER + ".[Seccion] (nombre,descripcion) VALUES('" + seccion.nombre + "','" + seccion.descripcion + "') ") == 1)
                    {
                        seccion.id = getId(MAER + ".[Seccion]", "nombre='" + seccion.nombre + "' AND descripcion='" + seccion.descripcion + "'");
                        int result = 0;

                        foreach (Categoria c in categorias)
                        {
                            result += Ejecutar("INSERT INTO " + MAER + ".[Categoria] (nombre,descripcion,porcentaje,seccion) VALUES('" + c.nombre + "','" + c.descripcion + "','" + c.porcentaje + "','" + seccion.id + "')");
                        }

                        if (result == categorias.Count) return 1;
                        else return -7;
                    }
                    else return -8;
                }
                else return -9;
            }
            else
            {
                if (Ejecutar("UPDATE " + MAER + ".[Seccion] set nombre='" + seccion.nombre + "',descripcion='" + seccion.descripcion + "' WHERE id='"+seccion.id+"'") == 1)
                {
                    int result = 0;

                    foreach (Categoria c in categorias)
                    {
                        if(c.id.CompareTo("0")==0)  result += Ejecutar("INSERT INTO " + MAER + ".[Categoria] (nombre,descripcion,porcentaje,seccion) VALUES('" + c.nombre + "','" + c.descripcion + "','" + c.porcentaje + "','" + seccion.id + "')");
                        else result += Ejecutar("UPDATE " + MAER + ".[Categoria] SET nombre='" + c.nombre + "',descripcion='" + c.descripcion + "',porcentaje='" + c.porcentaje + "',seccion='"+seccion.id + "' WHERE id='"+c.id+"'");
                    }

                    if (result == categorias.Count) return 1;
                    else return -5;
                }
                else return -6;
            }
        }
        else return -666;//inyeccion
    }
    [WebMethod]
    public DataTable getSecciones(Usuario u)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("Secciones", " SELECT * FROM " + MAER + ".[Seccion] T1 JOIN " + MAER + ".[Categoria] T2 ON T2.seccion=T1.id WHERE T1.visible='True' AND T2.visible='True' AND T1.eliminado='False' AND T2.eliminado='False' ORDER BY t1.id ");
        }
        else return null;
    }
    [WebMethod]
    public int eliminarSeccion(Usuario u ,string id)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            if (!existe(MAER + ".[Clientes]", "seccion='" + id + "'") && !existe(MAER+".[Categoria] T1 JOIN "+MAER+".[ItemCategoria] T2 ON T1.id=T2.categoria JOIN "+MAER+".[Evaluaciones] T3 ON T3.itemCategoria=T2.id", "T1.seccion='"+id+"'"))
            {
                return Ejecutar("DELETE " + MAER + ".[Seccion] WHERE id = '" + id + "' ");
            }
            else
            {
                return Ejecutar("UPDATE " + MAER + ".[Seccion] SET eliminado='True' WHERE id = '" + id + "'");

            }
        }
        else return -666;
    }
    [WebMethod]
    public DataTable getItems(Usuario u)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("ItemsEvaluacion", " SELECT * FROM " + MAER + ".[ItemsEvaluacion] WHERE visible='True' AND eliminado='False'");
        }
        else return null;
    }
    [WebMethod]
    public int eliminarItem(Usuario u, string id)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            if (!existe(MAER + ".[ItemCategoria]", "item='" + id + "'"))
            {
                return Ejecutar("DELETE FROM " + MAER + ".[ItemsEvaluacion] WHERE id='" + id + "'");
            }
            else
            {
                return Ejecutar("UPDATE " + MAER + ".[ItemsEvaluacion] SET eliminado='True' WHERE id = '" + id + "'");
            }
        }
        else return -666;
    }
    [WebMethod]
    public int guardarItem(Usuario u, string item, string descripcion)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return Ejecutar("INSERT INTO " + MAER + ".[ItemsEvaluacion] (nombre,descripcion,editable,visible,eliminado) VALUES('" + item + "','" + descripcion + "','True','True','False') ");
        }
        else return -666;
    }
    [WebMethod]
    public int editarItem(Usuario u, string id, string item, string descripcion)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return Ejecutar("UPDATE " + MAER + ".[ItemsEvaluacion] SET nombre='" + item + "', descripcion='" + descripcion + "' WHERE id = '" + id + "' ");
        }
        else return -666;
    }
    [WebMethod]
    public DataTable getSociosDe(Usuario u, string local)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("Socios", " SELECT T2.CardName,T2.CardCode,T2.LicTradNum,T3.*,T4.* FROM " + SAP + ".[OWHS] T1 RIGHT JOIN " + SAP + ".[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj LEFT JOIN " + MAER + ".Clientes T3 ON T3.cliente=T2.CardCode LEFT JOIN " + MAER + ".[Seccion] T4 ON T4.id = T3.seccion WHERE U_LTrabj='" + local + "' ");
        }
        else return null;
    }
    [WebMethod]
    public DataTable getNombreSecciones(Usuario u)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("Secciones", " SELECT * FROM "+MAER+".[Seccion] T1 WHERE T1.visible='True' AND T1.eliminado='False' ");
        }
        else return null;
    }
    [WebMethod]
    public DataTable getSeccionCategoria(Usuario u)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("SeccionCategoria", " SELECT T1.id, (T1.nombre + ' - ' + T2.nombre) as nombre, T2.id FROM "+MAER+".[Seccion] T1 JOIN "+MAER+".[Categoria] T2 ON T2.seccion=T1.id WHERE T1.visible='True' AND T2.visible='True' AND T1.eliminado='False' AND T2.eliminado='False' ");
        }
        else return null;
    }
    [WebMethod]
    public DataTable getItemSeccion(Usuario u)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("ItemsSeccion", " SELECT *,T4.nombre+' - '+T3.nombre as nombre FROM " + MAER + ".[ItemsEvaluacion] T1 LEFT JOIN " + MAER + ".[ItemCategoria] T2 ON T1.id=T2.item AND T1.visible='True' AND T1.eliminado='False' AND T2.eliminado='false' LEFT JOIN " + MAER + ".[Categoria] T3 ON T3.id=T2.categoria LEFT JOIN " + MAER + ".[Seccion] T4 ON T3.seccion=T4.id ");
        }
        return null;
    }
    [WebMethod]
    public int amarrarItemSeccion(Usuario u, string id_C, string id_I)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            if (!existe(MAER + ".[ItemCategoria]", "item='" + id_I + "'"))
            {
                return Ejecutar("INSERT INTO " + MAER + ".[ItemCategoria] (categoria,item) VALUES('" + id_C + "','" + id_I + "') ");
            }
            else
            {
                string id = getId(MAER + ".[ItemCategoria]","item='"+id_I+"'");
                if(id!="" && !existe(MAER+".[Evaluaciones]","itemCategoria='"+id+"'"))
                {
                    return Ejecutar("UPDATE " + MAER + ".[ItemCategoria] SET categoria='" + id_C + "' WHERE item='" + id_I + "' ");
                }
                else return -10;
            }
        }
        else return -666;
    }
    [WebMethod]
    public int delItemSeccion(Usuario u, string id_i)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {       
            string id = getId(MAER + ".[ItemCategoria]","item='"+id_i+"'");
            if (!existe(MAER + ".[Evaluaciones]", "itemCategoria='" + id + "'"))
            {
                return Ejecutar("DELETE " + MAER + ".[ItemsSeccion] WHERE id = '" + id + "' ");
            }
            else
            {
                return Ejecutar("UPDATE " + MAER + ".[ItemsSeccion] SET eliminado='True' WHERE id = '" + id + "' ");
            }
        }
        else return -666;
    }
    [WebMethod]
    public DataTable getSocios(Usuario u, string local)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("Socios", " SELECT T2.CardName,T2.CardCode,T2.LicTradNum,T3.*,T4.* FROM " + SAP + ".[OCRD] T2 JOIN " + MAER + ".Clientes T3 ON T3.cliente=T2.CardCode LEFT JOIN " + MAER + ".[Seccion] T4 ON T4.id = T3.seccion WHERE U_LTrabj='" + local + "' ");
        }
        else return null;
    }
    [WebMethod]
    public DataTable getItemsDe(Usuario u, string cliente)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("Items", " SELECT T3.*,T4.*,T5.* FROM " + MAER + ".[Clientes] T1 JOIN " + MAER + ".[Seccion] T2 ON T1.seccion=T2.id JOIN " + MAER + ".[Categoria] T3 ON T3.seccion=T2.id AND T3.eliminado='False' JOIN " + MAER + ".[ItemCategoria] T4 ON T4.categoria=T3.id AND T4.eliminado='False' JOIN " + MAER + ".[ItemsEvaluacion] T5 ON T5.id=T4.item AND T5.eliminado='False' WHERE T1.cliente='" + cliente + "' ");
        }
        else return null;
    }
    [WebMethod]
    public DataTable getCategoriasDe(Usuario u, string cliente)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("Categorias", " SELECT T3.* FROM " + MAER + ".[Clientes] T1 JOIN " + MAER + ".[Seccion] T2 ON T1.seccion=T2.id JOIN " + MAER + ".[Categoria] T3 ON T3.seccion=T2.id AND T3.eliminado='False' WHERE T1.cliente='" + cliente + "' ");
        }
        else return null;
    }

    [WebMethod]
    public int addEvaluacion(Usuario u,string cliente,List<Evaluacion> evaluaciones,List<Categoria> categorias)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            int result = 0;
            DateTime h = DateTime.Now;
            string hoy = h.Year + "-" + h.Month + "-" + h.Day + " 00:00.000";
            Ejecutar("DELETE " + MAER + ".[Evaluaciones] WHERE cliente='" + cliente + "' AND fecha='" + hoy + "'");
            
            foreach (Evaluacion e in evaluaciones)
            {
                result += Ejecutar("INSERT INTO " + MAER + ".[Evaluaciones] (cliente,itemCategoria,cumple,fecha) VALUES('" + cliente + "','" + e.id + "','" + e.cumple + "','" + hoy + "')");
            }

            Ejecutar("DELETE " + MAER + ".[ResumenEvaluacion] WHERE cliente='" + cliente + "' AND fecha='" + hoy + "'");
            foreach (Categoria c in categorias)
            {
                result += Ejecutar("INSERT INTO " + MAER + ".[ResumenEvaluacion] (cliente,fecha,categoria,items,cumplidos) VALUES('" + cliente + "','" + hoy + "','" + c.id + "','" + c.items + "','" + c.cumplidos + "')");
            }

            if ((evaluaciones.Count + categorias.Count) == result) return 1;
            else
            {
                Ejecutar("DELETE " + MAER + ".[ResumenEvaluacion] WHERE cliente='" + cliente + "' AND fecha='" + hoy + "'");
                Ejecutar("DELETE " + MAER + ".[Evaluaciones] WHERE cliente='" + cliente + "' AND fecha='" + hoy + "'");
                return 12;
            }
        }
        else return -666;
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

    private DateTime toDateTime(string fecha)
    {
        string[] date = fecha.Split('/');
        int dia = Convert.ToInt32(date[0]);
        int mes = Convert.ToInt32(date[1]);
        int año = Convert.ToInt32(date[2]);

        return new DateTime(año, mes, dia);
    }
    [WebMethod]
    public DataTable getEvaluaciones(Usuario u, string fi, string ft)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            string f1="", f2="";
            string sql = "SELECT convert(varchar(20),T1.fecha,103) as fecha, T1.cumplidos, T1.items, T2.nombre, T2.porcentaje,T3.CardCode,T3.CardName FROM " + MAER + ".[ResumenEvaluacion] T1 RIGHT JOIN " + MAER + ".[Categoria] T2 ON T1.categoria=T2.id JOIN " + SAP + ".[OCRD] T3 ON T3.CardCode=T1.cliente";
            
            if(fi.Length>0)
            {
                DateTime inicio = toDateTime(fi);
                f1 = inicio.Year + "-" + inicio.Month + "-" + inicio.Day + " 00:00.000";
            }
            if (ft.Length > 0)
            {
                DateTime termino = toDateTime(ft);
                f2 = termino.Year + "-" + termino.Month + "-" + termino.Day + " 00:00.000";
            }

            if (fi.Length > 0 && ft.Length > 0)
            {
                sql += " WHERE T1.fecha>='" + f1 + "' AND T1.fecha<='" + f2 + "'";
            }
            else if(fi.Length > 0 && ft.Length == 0)
            {
                sql += " WHERE T1.fecha>='" + f1 + "'";
            }
            else if(fi.Length == 0 && ft.Length > 0)
            {
                sql += " WHERE T1.fecha<='" + f2 + "'";
            }
            return obtenerTabla("Evaluaciones",sql);
        }
        else return null;
    }

    private String getLocal(string cliente)
    {
        String query = "SELECT WhsName,U_LTrabj FROM " + SAP + ".[OWHS] T1 RIGHT JOIN " + SAP + ".[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj WHERE CardCode='" + cliente + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand select = new SqlCommand(query, selectConn);
        SqlDataReader reader = select.ExecuteReader();

        if (reader.Read())
        {
            if (!reader.IsDBNull(0)) return reader.GetString(0);
            else
            {
                if (!reader.IsDBNull(1) && reader.GetString(1).CompareTo("P01") == 0) return "Planta Curicó";
                if (!reader.IsDBNull(1) && reader.GetString(1).CompareTo("P02") == 0) return "Planta Temuco";
                return "";
            }
        }
        else
        {
            return "";
        }
    }
    private DataTable getEvaluacion(string cliente, string fecha)
    {
        return obtenerTabla("Evaluacion", "SELECT T2.cumple,T3.nombre,T3.descripcion,T4.id,T4.nombre,T4.porcentaje,T4.descripcion FROM " + MAER + ".[ItemCategoria] T1 JOIN " + MAER + ".[Evaluaciones] T2 ON T1.id=T2.itemCategoria AND T1.eliminado='False' JOIN " + MAER + ".[ItemsEvaluacion] T3 ON T1.item=T3.id AND T3.visible='True' AND T3.eliminado='False' JOIN " + MAER + ".[Categoria] T4 ON T4.id=T1.categoria WHERE T2.cliente='"+cliente+"' AND T2.fecha='"+fecha+"'");
    }
    [WebMethod]
    public Evaluacion getEvaluacionDe(Usuario u, string cliente1, string cliente2, string fecha)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            DateTime date = toDateTime(fecha);
            string f = date.Year + "-" + date.Month + "-" + date.Day + " 00:00.000";
            Evaluacion e = new Evaluacion();
            e.fecha = fecha;
            e.trabajador = cliente1;
            e.nombreTrabajador = cliente2;
            e.evaluacion = getEvaluacion(cliente1,f);
            e.local = getLocal(cliente1);
            e.categorias = getCategoriasDe(u,cliente1);
            return e;
        }
        else return null;
    }
}
