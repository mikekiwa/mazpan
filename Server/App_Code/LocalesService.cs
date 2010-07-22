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
    private string MAER = "[PracticaDb].[dbo]";



    public LocalesService ()
    {
    }

/*********************************************************************************************************************/

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


    /// <summary>
    /// Recive una cadana de texto con formato dd/mm/aaaa y la lleva a un DateTime
    /// </summary>
    /// <param name="fecha">Cadana de texto con formato dd/mm/aaaa</param>
    /// <returns>Fecha como un tipo DateTime</returns>
    private DateTime toDateTime(string fecha)
    {
        string[] date = fecha.Split('/');
        int dia = Convert.ToInt32(date[0]);
        int mes = Convert.ToInt32(date[1]);
        int año = Convert.ToInt32(date[2]);

        return new DateTime(año, mes, dia);
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
   
    
/*********************************************************************************************************************/

    [WebMethod]
    public DataTable getLocales()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Locales";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName FROM [Maspan].[dbo].[OWHS] WHERE location='4' ";
        da.SelectCommand = new SqlCommand(query, cn);

        SqlConnection cn1 = new SqlConnection(coneccionString);
        SqlDataAdapter da1 = new SqlDataAdapter();
        String query1 = " SELECT 'P01' as WhsCode,'Planta Curicó' AS WhsName ";
        da1.SelectCommand = new SqlCommand(query1, cn1);

        SqlConnection cn2 = new SqlConnection(coneccionString);
        SqlDataAdapter da2 = new SqlDataAdapter();
        String query2 = " SELECT 'P02' as WhsCode,'Planta Temuco' AS WhsName ";
        da2.SelectCommand = new SqlCommand(query2, cn2);


        try
        {
            da.Fill(dt);
            da1.Fill(dt);
            da2.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }

/*********************************************************************************************************************/
   
    [WebMethod]
    public DataTable getSociosDe(string local, string ddmmaa)
    {
        DateTime date = toDateTime(ddmmaa);
        string fecha = date.Year + "-" + date.Month + "-" + date.Day;
        
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName,CardName,T2.CardCode,asistencia,atraso,fecha FROM " + SAP + ".[OWHS] T1 RIGHT JOIN " + SAP + ".[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj LEFT JOIN [PracticaDb].[dbo].[Asistencia] T3 ON T3.CardCode=T2.CardCode AND fecha='" + fecha + "' WHERE U_LTrabj='" + local + "' ";

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
    public DataTable getSociosMayorista(string local, string ddmmaa)
    {
        DateTime date = toDateTime(ddmmaa);
        string fecha = date.Year + "-" + date.Month + "-" + date.Day;

        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName,(nombres+' '+apellidoPaterno+' '+apellidoMaterno) as CardName,rut as CardCode,asistencia,atraso,fecha  FROM " + SAP + ".[OWHS] T1 RIGHT JOIN [PracticaDb].[dbo].[Personal] T2 ON T1.WhsCode=T2.mayorista LEFT JOIN [PracticaDb].[dbo].[Asistencia] T3 ON T3.CardCode=T2.rut AND fecha='" + fecha + "' WHERE T2.mayorista='" + local + "' ";

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

/*********************************************************************************************************************/

    private bool existeAsistencia(string CardCode, string fecha)
    {
        String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[Asistencia] WHERE CardCode = '" + CardCode + "' AND fecha='"+fecha+"' ";
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
    public DataTable getAsistencia(string local, string ddmmaa1, string ddmmaa2)
    {
        string desde;
        string hasta;
        if (ddmmaa1 == "" || ddmmaa1 == "HOY") desde = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        else
        {
            DateTime dt1 = toDateTime(ddmmaa1);
            desde = dt1.Year + "-" + dt1.Month + "-" + dt1.Day;
        }
        if (ddmmaa2 == "" || ddmmaa2 == "HOY") hasta = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        else
        {
            DateTime dt2 = toDateTime(ddmmaa2);
            hasta = dt2.Year + "-" + dt2.Month + "-" + dt2.Day;
        }
        String query = " SELECT WhsCode,WhsName,(nombres+' '+apellidoPaterno+' '+apellidoMaterno) as CardName,rut as CardCode,asistencia,atraso,convert(varchar(50),fecha,105) as fecha FROM " + SAP + ".[OWHS] T1 RIGHT JOIN [PracticaDb].[dbo].[Personal] T2 ON T1.WhsCode=T2.mayorista JOIN [PracticaDb].[dbo].[Asistencia] T3 ON T3.CardCode=T2.rut AND fecha>='" + desde + "' AND fecha<='" + hasta + "' WHERE T2.mayorista='" + local + "' ORDER BY fecha";

        return obtenerTabla("Asistencia",query);
    }

    [WebMethod]
    public int guardarAsistencia(string CardCode, string asistencia, string atraso, string ddmmaa)
    {
        DateTime dt = toDateTime(ddmmaa);
        string fecha = dt.Year + "-" + dt.Month + "-" + dt.Day;
        
        if (existeAsistencia(CardCode, fecha))
        {
            return Ejecutar("UPDATE [PracticaDB].[dbo].[Asistencia] SET asistencia='" + asistencia + "', atraso='" + atraso + "' WHERE CardCode = '" + CardCode + "' AND fecha='"+fecha+"' ");
        }
        else
        {
            return Ejecutar("INSERT INTO [PracticaDB].[dbo].[Asistencia] (CardCode,asistencia,atraso,fecha) VALUES('" + CardCode + "','" + asistencia + "','" + atraso + "','"+fecha+"') ");
        }
    }

/*********************************************************************************************************************/

    [WebMethod]
    public DataTable getDesviaciones(string local, string ddmmaa1, string ddmmaa2)
    {
        string desde;
        if (ddmmaa1 == "" || ddmmaa1 == "HOY") desde = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        else
        {
            DateTime dt = toDateTime(ddmmaa1);
            desde = dt.Year + "-" + dt.Month + "-" + dt.Day;
        }

        string hasta;
        if (ddmmaa2 == "" || ddmmaa2 == "HOY") hasta = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        else
        {
            DateTime dt = toDateTime(ddmmaa2);
            hasta = dt.Year + "-" + dt.Month + "-" + dt.Day;
        }

        String query = " SELECT *, ((CantidadCompletada*100)/CantidadElaborada) AS Logrado, (((CantidadCompletada-CantidadElaborada) * 100) / CantidadElaborada) AS NoLogrado " +
                       " FROM (SELECT T1.[ItemName],SUM(T0.[U_CantElab]) AS CantidadElaborada, SUM(T0.[CmpltQty]) AS CantidadCompletada, SUM((T0.[CmpltQty] - T0.[U_CantElab])) AS Diferencia " +
                       " FROM "+SAP+".OWOR T0 JOIN "+SAP+".OITM T1 ON T0.ItemCode = T1.ItemCode JOIN "+SAP+".OWHS T2 ON T0.Warehouse = T2.WhsCode "+
                       " WHERE T0.CmpltQty >= '1' and T0.U_CantElab >= '1' AND T0.[DueDate] >='"+desde+"' AND T0.[DueDate] <='"+hasta+"' AND t2.WhsCode='"+local+"' "+
                       " GROUP BY T1.[ItemName]) Tx";

        return obtenerTabla("Desviaciones",query);
    }

/*********************************************************************************************************************/
   
    private bool existeProducto(string producto)
    {
        String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[Productos] WHERE producto='" + producto + "'";
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
    public DataTable getProductosStock()
    {
        return obtenerTabla("Productos", " SELECT T1.[ItemCode],T1.[ItemName],T1.[InvntryUom], T2.visible as EnUso, T2.bloqueado as Bloqueado" +
                                         " FROM "+SAP+".OITM T1 LEFT JOIN "+MAER+".Productos T2 ON T2.producto=T1.ItemCode AND T2.visible='True'"+
                                         " WHERE T1.[Canceled]!='Y' AND T1.[InvntryUom]!='NULL'");
    }

    [WebMethod]
    public int utilizarProductos(List<string> productos)
    {
        int results = 0;
        foreach (string p in productos)
        {
            if (!existeProducto(p)) results += Ejecutar("INSERT INTO " + MAER + ".[Productos] (producto) VALUES ('" + p + "') ");
            else results += Ejecutar("UPDATE " + MAER + ".[Productos] SET visible='True' AND bloqueado='False' WHERE producto='"+p+"'");
        }
        if (results < productos.Count) return -1;
        if (results == productos.Count) return 1;
        return 0;
    }

    [WebMethod]
    public int bloquearProductos(List<string> productos)
    {
        int results = 0;
        foreach (string p in productos)
        {
            results += Ejecutar("UPDATE " + MAER + ".[Productos] SET bloqueado='True' WHERE producto='" + p + "'");
        }
        if (results < productos.Count) return -1;
        if (results == productos.Count) return 1;
        return 0;
    }

    [WebMethod]
    public DataTable getProductosLocal(string local, string ddmmaa)
    {
        string fecha;
        string query;
        if (ddmmaa == "" || ddmmaa == "HOY") fecha = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        else
        {
            DateTime dt = toDateTime(ddmmaa);
            fecha = dt.Year + "-" + dt.Month + "-" + dt.Day;
        }

        query = " SELECT T1.[ItemCode],T1.[ItemName],T1.[InvntryUom], T3.[Total] as Local " +
                " FROM "+SAP+".OITM T1 JOIN "+MAER+".Productos T2 ON T2.producto=T1.ItemCode AND T2.bloqueado='False' " +
                " LEFT JOIN "+MAER+".StockLocal T3 ON T1.[ItemCode]=T3.[ItemCode] AND T3.[fecha]='" + fecha + "' AND T3.[local]='" + local + "'";

        return obtenerTabla("Productos", query);
    }

/*********************************************************************************************************************/

    [WebMethod]
    public Stock getStock(string local, string ddmmaa)
    {
        DateTime dt = toDateTime(ddmmaa);
        string fecha = dt.Year + "-" + dt.Month + "-" + dt.Day;

        String query1 = " SELECT T3.ItemCode, T3.ItemName, OnHand = CASE WHEN T1.Total IS NULL THEN '0' ELSE REPLACE(T1.Total,',','.') END, T3.InvntryUom " +
                        " FROM " + MAER + ".[StockLocal] T1 RIGHT JOIN " + MAER + ".[Productos] T2 ON T1.ItemCode=T2.Producto " +
                        " AND [local]='" + local + "' AND [fecha]='" + fecha + "' " +
                        " JOIN " + SAP + ".[OITM] T3 ON T2.producto=T3.ItemCode";

        String query2 = " SELECT T3.ItemCode, T3.ItemName, OnHand = CASE WHEN T1.Total IS NULL THEN '0' ELSE REPLACE(T1.Total,',','.') END, T3.InvntryUom " +
                        " FROM " + MAER + ".[StockSistema] T1 RIGHT JOIN " + MAER + ".[Productos] T2 ON T1.ItemCode=T2.Producto " +
                        " AND [local]='" + local + "' AND [fecha]='" + fecha + "' " +
                        " JOIN "+SAP+".[OITM] T3 ON T2.producto=T3.ItemCode";

        Stock st = new Stock();
        st.StockLocal = obtenerTabla("StockLocal",query1);
        st.StockSistema = obtenerTabla("StockSistema",query2);

        return st;
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
    public int addStockSistema(List<Stock> stockSistema, string local, string ddmmaa)
    {
        DateTime t = toDateTime(ddmmaa);
        string fecha = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";

        Ejecutar("DELETE [PracticaDb].[dbo].[StockSistema] WHERE fecha='" + fecha + "' and local='" + local + "'");

        foreach (Stock s in stockSistema)
        {
            string sql = " INSERT INTO [PracticaDb].[dbo].[StockSistema] ([fecha],[local],[ItemCode],[total],[valorAcumulado]) " +
                         " VALUES ('" + fecha + "','" + local + "','" + s.codigo + "','" + s.cantidad + "','" + s.valor + "')";
            if (existeArticulo(s.codigo)) Ejecutar(sql);
        }

        return 1;
    }
    private bool existeArticulo(string producto)
    {
        String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[Productos] WHERE producto = '" + producto + "'";
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
/*********************************************************************************************************************/
    
    [WebMethod]
    public DataTable getGastos(string local, string ddmmaa1, string ddmmaa2)
    {
        if (ddmmaa2 == null || ddmmaa2 == "") ddmmaa2 = ddmmaa1;
        DateTime dt = toDateTime(ddmmaa1);
        string desde = dt.Year + "-" + dt.Month + "-" + dt.Day;
        DateTime dt2 = toDateTime(ddmmaa2);
        string hasta = dt2.Year + "-" + dt2.Month + "-" + dt2.Day;

        string sql = "";
        if (desde.CompareTo(hasta)==0) sql = " SELECT * " +
                                             " FROM [PracticaDb].[dbo].[GastosLocal] T1 " +
                                             " WHERE T1.fecha>='" + desde + "' AND T1.fecha<='" + hasta + "' AND T1.local='" + local + "'";
        else sql = " SELECT gasto,SUM(convert(int,total)) as total,'Item Agrupado' as observaciones, '"+hasta+"' as fecha, '"+local+"' as [local] "+
                   " FROM [PracticaDb].[dbo].[GastosLocal] T1 "+
                   " WHERE T1.fecha>='"+desde+"' AND T1.fecha<='"+hasta+"' AND T1.local='"+local+"' "+
                   " GROUP BY Gasto";
        return obtenerTabla("Gastos", sql);
    }

    [WebMethod]
    public int editarGasto(string id, string total, string obsevaciones)
    {
        return Ejecutar(" UPDATE [PracticaDb].[dbo].[GastosLocal] SET total='" + total + "',observaciones='"+obsevaciones+"' WHERE id='"+id+"' ");
    }

    [WebMethod]
    public int guardarGasto(string gasto, string local, string total, string obsevaciones, string ddmmaa)
    {
        DateTime dt = toDateTime(ddmmaa);
        string fecha = dt.Year + "-" + dt.Month + "-" + dt.Day;

        return Ejecutar(" INSERT INTO [PracticaDb].[dbo].[GastosLocal] (fecha,gasto,total,observaciones,local) VALUES('" + fecha + "','" + gasto + "','" + total + "','" + obsevaciones + "','" + local + "') ");
    }

/*********************************************************************************************************************/

    [WebMethod]
    public DataTable getMermas(string local, string ddmmaa1, string ddmmaa2)
    {
        DateTime dt1 = toDateTime(ddmmaa1);
        DateTime dt2 = toDateTime(ddmmaa2);
        string desde = dt1.Year + "-" + dt1.Month + "-" + dt1.Day;
        string hasta = dt2.Year + "-" + dt2.Month + "-" + dt2.Day;
        string sql = "";

        if (desde.CompareTo(hasta) == 0)
        {
            sql =  " SELECT T1.[Dscription],T1.[Quantity], U_FechSal,(T1.[Quantity] * T1.[StockPrice])*-1 as 'Monto' " +
                   " FROM " + SAP + ".OIGE T0 INNER JOIN " + SAP + ".IGE1 T1 ON T0.DocEntry = T1.DocEntry " +
                   " INNER JOIN " + SAP + ".OWHS T2 ON T1.WhsCode = T2.WhsCode " +
                   " INNER JOIN " + SAP + ".OACT T3 ON T1.AcctCode = T3.AcctCode " +
                   " WHERE T2.[WhsName] Like '%Mayorista%' AND " +
                   " T0.[DocDate] >='" + desde + "' AND " +
                   " T0.[DocDate] <='" + hasta + "' AND " +
                   " T3.[AcctName] NOT Like '%Productos%' AND " +
                   " T3.[AcctName] Like '%Merma%' AND " +
                   " T2.WhsCode='" + local + "'";
        }
        else
        {
            sql = " SELECT T1.[Dscription],SUM(T1.[Quantity]) as Quantity, '" + ddmmaa2 + "' as U_FechSal,SUM((T1.[Quantity] * T1.[StockPrice])*-1) as 'Monto' " +
                  " FROM " + SAP + ".OIGE T0 INNER JOIN " + SAP + ".IGE1 T1 ON T0.DocEntry = T1.DocEntry " +
                  " INNER JOIN " + SAP + ".OWHS T2 ON T1.WhsCode = T2.WhsCode " +
                  " INNER JOIN " + SAP + ".OACT T3 ON T1.AcctCode = T3.AcctCode " +
                  " WHERE T2.[WhsName] Like '%Mayorista%' AND " +
                  " T0.[DocDate] >='" + desde + "' AND " +
                  " T0.[DocDate] <='" + hasta + "' AND " +
                  " T3.[AcctName] NOT Like '%Productos%' AND " +
                  " T3.[AcctName] Like '%Merma%' AND " +
                  " T2.WhsCode='" + local + "' " +
                  " GROUP BY T1.[Dscription]";
        }
        return obtenerTabla("Mermas", sql);
    }

    [WebMethod]
    public DataTable getProducidoVsMermas(string local, string ddmmaa1, string ddmmaa2)
    {
        DateTime dt1 = toDateTime(ddmmaa1);
        DateTime dt2 = toDateTime(ddmmaa2);
        string desde = dt1.Year + "-" + dt1.Month + "-" + dt1.Day;
        string hasta = dt2.Year + "-" + dt2.Month + "-" + dt2.Day;
        string sql = " SELECT T1.[ItemCode], T1.[Dscription], SUM(T1.[Quantity]) AS 'PRODUCIDO', SUM(T2.[Quantity]) AS 'MERMADO' " +
                     " FROM " + SAP + ".ODLN T0 " +
                     " JOIN " + SAP + ".DLN1 T1 ON T0.DocEntry = T1.DocEntry " +
                     " JOIN " + SAP + ".IGE1 T2 ON T1.ItemCode=T2.ItemCode " +
                     " JOIN " + SAP + ".OIGE T3 ON T2.DocEntry = T3.DocEntry " +
                     " WHERE T1.[WhsCode]='" + local + "' AND T2.[WhsCode] ='" + local + "' AND " +
                     " T0.[DocDate] >='" + desde + "' AND T0.[DocDate] <='" + hasta + "' AND " +
                     " T3.[DocDate] >='" + desde + "' AND T3.[DocDate] <='" + hasta + "' " +
                     " GROUP BY T1.[ItemCode], T1.[Dscription]";
        return obtenerTabla("Mermas", sql);
    }
}

