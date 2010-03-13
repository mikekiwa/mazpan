using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de LocalesService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/LocalesService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class LocalesService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;
    //private string SAP = "[Pruebas Maspan].[dbo]";
    private string SAP = "[Maspan].[dbo]";

    public LocalesService ()
    {
    }

    [WebMethod]
    public DataTable getLocales()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Locales";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName FROM [Maspan].[dbo].[OWHS] WHERE location='4' ";

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
    public DataTable getSociosDe(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName,CardName,T2.CardCode,asistencia,atraso,fecha FROM "+SAP+".[OWHS] T1 JOIN "+SAP+".[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj LEFT JOIN [PracticaDb].[dbo].[Asistencia] T3 ON T3.CardCode=T2.CardCode AND fecha='"+DateTime.Now.Year+"-"+DateTime.Now.Month+"-"+DateTime.Now.Day+"' WHERE WhsCode='"+local+"' ";

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

    private bool existeAsistencia(string CardCode)
    {
        String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[Asistencia] WHERE CardCode = '" + CardCode + "' AND fecha='"+DateTime.Now.Year+"-"+DateTime.Now.Month+"-"+DateTime.Now.Day+"' ";
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
    public int guardarAsistencia(string CardCode, string asistencia, string atraso)
    {
        if (existeAsistencia(CardCode))
        {
            return Ejecutar("UPDATE [PracticaDB].[dbo].[Asistencia] SET asistencia='" + asistencia + "', atraso='" + atraso + "' WHERE CardCode = '" + CardCode + "' AND fecha='" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "' ");
        }
        else
        {
            return Ejecutar("INSERT INTO [PracticaDB].[dbo].[Asistencia] (CardCode,asistencia,atraso,fecha) VALUES('" + CardCode + "','" + asistencia + "','" + atraso + "','" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "') ");
        }
    }

    [WebMethod]
    public DataTable getDesviaciones(string local, string desde, string hasta)
    {
        if (desde == "HOY") desde = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        if (hasta == "HOY") hasta = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;

        DataTable dt = new DataTable();
        dt.TableName = "Desviaciones";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T1.[ItemName],T0.[U_CantElab] CantidadElaborada, T0.[CmpltQty] CantidadCompletada, (T0.[CmpltQty] - T0.[U_CantElab]) Diferencia, ((T0.CmpltQty * 100)/T0.U_CantElab) Logrado, (((T0.CmpltQty - T0.U_CantElab ) * 100) / T0.U_CantElab) NoLogrado"+
                       " FROM "+SAP+".OWOR T0 JOIN "+SAP+".OITM T1 ON T0.ItemCode = T1.ItemCode JOIN "+SAP+".OWHS T2 ON T0.Warehouse = T2.WhsCode "+
                       " WHERE T0.CmpltQty >= '1' and T0.U_CantElab >= '1' AND T0.[DueDate] >='"+desde+"' AND T0.[DueDate] <='"+hasta+"' AND t2.WhsCode='"+local+"' ";

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
    public DataTable getStock(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Stock";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T0.ItemCode, T0.ItemName, T1.OnHand, T0.InvntryUom " +
                        " FROM [Maspan].[dbo].[OITM] T0 JOIN [Maspan].[dbo].[OITW] T1 ON T0.ItemCode = T1.ItemCode JOIN [Maspan].[dbo].[OWHS] T2 ON T1.WhsCode = T2.WhsCode " +
                        " WHERE T1.[Locked]='N' AND InvntryUom!='NULL' AND T2.WhsCode='" + local + "' " +
                        " ORDER BY T0.ItemName";

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
    public DataTable getProductosLocal(string local, string fecha)
    {
        if (fecha == "") fecha = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        DataTable dt = new DataTable();
        dt.TableName = "Productos";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T0.[ItemCode],T0.[ItemName],T0.[InvntryUom], T1.[Total] as Local FROM " + SAP + ".OITM T0 JOIN [PracticaDb].[dbo].StockLocal T1 ON T0.[ItemCode]=T1.[ItemCode] AND T1.[fecha]='"+fecha+"' AND T1.[local]='"+local+"' WHERE T0.[Canceled]!='Y' AND T0.[InvntryUom]!='NULL' ";

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
    public DataTable getProductos(string local, string fecha)
    {
        if (fecha == "") fecha = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        DataTable dt = new DataTable();
        dt.TableName = "Productos";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T0.[ItemCode],T0.[ItemName],T0.[InvntryUom], T1.[Total] as Local FROM " + SAP + ".OITM T0 LEFT JOIN [PracticaDb].[dbo].StockLocal T1 ON T0.[ItemCode]=T1.[ItemCode] AND T1.[fecha]='"+fecha+"' AND T1.[local]='"+local+"' WHERE T0.[Canceled]!='Y' AND T0.[InvntryUom]!='NULL' ";

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
    public int guardarStock(string local,string fecha, string item, string total)
    {
        if (existeStock(local,fecha,item))
        {
            return Ejecutar("UPDATE [PracticaDB].[dbo].[StockLocal] SET total='" + total + "' WHERE local = '" + local + "' AND fecha='"+fecha+"' AND ItemCode='"+item+"' ");
        }
        else
        {
            return Ejecutar("INSERT INTO [PracticaDB].[dbo].[StockLocal] (local,fecha,ItemCode,total) VALUES('"+local+"','"+fecha+"','"+item+"','"+total+"') ");
        }
    }

    private bool existeStock(string local,string fecha, string item)
    {
        String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[StockLocal] WHERE local = '" + local + "' AND fecha='"+fecha+"' AND ItemCode='"+item+"'";
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
    public DataTable getAsistencia(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Asistencia";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName,CardName,T2.CardCode,asistencia,atraso,fecha FROM " + SAP + ".[OWHS] T1 JOIN " + SAP + ".[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj JOIN [PracticaDb].[dbo].[Asistencia] T3 ON T3.CardCode=T2.CardCode AND fecha='" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "' WHERE WhsCode='" + local + "' ";

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
    public DataTable getGastos(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Gastos";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT * FROM [PracticaDb].[dbo].[GastosLocal] T1 WHERE T1.fecha='" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "' AND T1.local='" + local + "' ";

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
    public int editarGasto(string id, string total, string obsevaciones)
    {
        return Ejecutar(" UPDATE [PracticaDb].[dbo].[GastosLocal] SET total='" + total + "',observaciones='"+obsevaciones+"' WHERE id='"+id+"' ");
    }

    [WebMethod]
    public int guardarGasto(string gasto, string local, string total, string obsevaciones)//fecha.now
    {
        return Ejecutar(" INSERT INTO [PracticaDb].[dbo].[GastosLocal] (fecha,gasto,total,observaciones,local) VALUES('" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "','" + gasto + "','" + total + "','" + obsevaciones + "','" + local + "') ");
    }

}

