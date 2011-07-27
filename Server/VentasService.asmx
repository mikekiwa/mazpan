<%@ WebService Language="C#" CodeBehind="/App_Code/VentasService.cs" Class="VentasService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de VentasService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/VentasService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class VentasService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;
    private string SAP = Coneccion.SapDbMaspan;
    private string MAER = Coneccion.PracticaDbMaspan;

    public VentasService ()
    { 
    }

    [WebMethod]
    public DataTable getSocios()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT CardCode,CardName FROM " + SAP + ".[OCRD] ";

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
    public DataTable getSociosSucursal(string sucursal)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT CardCode,CardName FROM " + SAP + ".[OASC] T1 JOIN " + MAER + ".[AmarreClienteSector] T2 ON T1.ShortName=T2.sucursal JOIN " + SAP + ".[OCRD] T3 ON T3.CardCode=T2.cliente WHERE SegmentId='1' AND T2.sucursal='"+sucursal+"'";

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
    public DataTable allSociosSinSucursal()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT CardCode,CardName,LicTradNum,CardFName,City FROM " + SAP + ".[OCRD] WHERE CardCode NOT IN (SELECT CardCode FROM " + SAP + ".[OASC] T1 JOIN " + MAER + ".[AmarreClienteSector] T2 ON T1.ShortName=T2.sucursal JOIN " + SAP + ".[OCRD] T3 ON T3.CardCode=T2.cliente WHERE SegmentId='1') ";

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
    public DataTable allSociosConSucursal()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT CardCode,CardName,LicTradNum,CardFName,T1.ShortName,City FROM " + SAP + ".[OASC] T1 JOIN " + MAER + ".[AmarreClienteSector] T2 ON T1.ShortName=T2.sucursal JOIN " + SAP + ".[OCRD] T3 ON T3.CardCode=T2.cliente WHERE SegmentId='1' ";

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
    public int quitar(List<ClienteZona> clientesZonas)
    {
        int result=0;
        foreach (ClienteZona cz in clientesZonas)
        {
            result += Ejecutar("DELETE " + MAER + ".[AmarreClienteSector] WHERE sucursal='"+cz.ShortName+"' AND cliente='"+cz.CardCode+"'");
        }
        if (result == clientesZonas.Count) return 1;
        else return 0;
    }

    [WebMethod]
    public int guardar(List<string> codigosClientes,string codigoZona)
    {
        int result = 0;
        string query = "";
        foreach (String codigo in codigosClientes)
        {
            query = " INSERT INTO " + MAER + ".[AmarreClienteSector] (sucursal,cliente) VALUES ('"+codigoZona+"','"+codigo+"') ";
            result += Ejecutar(query);
        }

        if (result == codigosClientes.Count) return 1;
        else if (result > 0) return -1;
        else return 0;
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

    private DataTable obtenerTabla(string nombre, string query)
    {
        DataTable dt = new DataTable();
        dt.TableName = nombre;

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();

        SqlCommand cmd = new SqlCommand(query, cn);
        cmd.CommandTimeout = 180;
        da.SelectCommand = cmd;

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
    public Tablas getVentas(int mes, int ano, string codigoCliente,string cliente)
    {
        DateTime fecha = new DateTime(ano, mes, 1);
        string inicio = fecha.Year + "-" + fecha.Month + "-" + fecha.Day;
        DateTime fecha2 = fecha.AddMonths(1);
        string termino = fecha2.Year + "-" + fecha2.Month + "-" + fecha2.Day;

        DateTime fecha0 = new DateTime(ano-1, mes, 1);
        string inicio0 = fecha0.Year + "-" + fecha0.Month + "-" + fecha0.Day;
        DateTime fecha20 = fecha0.AddMonths(1);
        string termino0 = fecha20.Year + "-" + fecha20.Month + "-" + fecha20.Day;
        
        String query1 = " SELECT itemname,sum(T1.quantity) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[INV1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio + "' AND T1.docdate<'" + termino + "' AND (T2.QryGroup1='Y' OR T2.QryGroup2='Y') AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2";
        String query2 = " SELECT itemname,sum(T1.quantity*-1) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[RIN1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio + "' AND T1.docdate<'" + termino + "' AND (T2.QryGroup1='Y' OR T2.QryGroup2='Y') AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2";
        String query3 = " SELECT itemname,sum(T1.quantity) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[INV1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio0 + "' AND T1.docdate<'" + termino0 + "' AND (T2.QryGroup1='Y' OR T2.QryGroup2='Y') AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2";
        String query4 = " SELECT itemname,sum(T1.quantity*-1) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[RIN1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio0 + "' AND T1.docdate<'" + termino0 + "' AND (T2.QryGroup1='Y' OR T2.QryGroup2='Y') AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2";
        String query5 = " SELECT T1.*,T2.itemcode, T2.itemname,T2.QryGroup1, T2.QryGroup2 FROM " + MAER + ".[Presupuesto] T1 JOIN " + SAP + ".[OITM] T2 ON T1.articulo=T2.itemCode WHERE T1.cliente='" + codigoCliente + "' AND T1.ano='" + ano + "' AND tipo='1' ";

        Tablas t = new Tablas();
        t.t1 = obtenerTabla("Ventas1", query1);
        t.t2 = obtenerTabla("Ventas2", query2);
        t.t3 = obtenerTabla("Ventas3", query3);
        t.t4 = obtenerTabla("Ventas4", query4);
        t.t5 = obtenerTabla("Presupuesto", query5);
        t.CardCode = codigoCliente;
        t.CardName = cliente;
        t.mes = mes;
        t.ano = ano;

        return t;
    }

    [WebMethod]
    public Tablas getVentasPesos(int mes, int ano, string codigoCliente, string cliente)
    {
        Tablas sal = new Tablas();
        DataTable dt1 = new DataTable();
        dt1.TableName = "Ventas1";
        DataTable dt2 = new DataTable();
        dt2.TableName = "Ventas2";
        DataTable dt3 = new DataTable();
        dt3.TableName = "Ventas3";
        DataTable dt4 = new DataTable();
        dt4.TableName = "Ventas4";
        DataTable dt5 = new DataTable();
        dt5.TableName = "Presupuesto";

        DateTime fecha = new DateTime(ano, mes, 1);
        string inicio = fecha.Year + "-" + fecha.Month + "-" + fecha.Day;
        DateTime fecha2 = fecha.AddMonths(1);
        string termino = fecha2.Year + "-" + fecha2.Month + "-" + fecha2.Day;

        DateTime fecha0 = new DateTime(ano - 1, mes, 1);
        string inicio0 = fecha0.Year + "-" + fecha0.Month + "-" + fecha0.Day;
        DateTime fecha20 = fecha0.AddMonths(1);
        string termino0 = fecha20.Year + "-" + fecha20.Month + "-" + fecha20.Day;


        SqlConnection cn1 = new SqlConnection(coneccionString);
        SqlDataAdapter da1 = new SqlDataAdapter();
        String query1 = " SELECT itemname,sum(T1.price*T1.quantity) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[INV1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio + "' AND T1.docdate<'" + termino + "' AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2 ";

        SqlConnection cn2 = new SqlConnection(coneccionString);
        SqlDataAdapter da2 = new SqlDataAdapter();
        String query2 = " SELECT itemname,sum(T1.price*-1*T1.quantity) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[RIN1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio + "' AND T1.docdate<'" + termino + "' AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2 ";

        SqlConnection cn3 = new SqlConnection(coneccionString);
        SqlDataAdapter da3 = new SqlDataAdapter();
        String query3 = " SELECT itemname,sum(T1.price*T1.quantity) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[INV1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio0 + "' AND T1.docdate<'" + termino0 + "' AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2 ";

        SqlConnection cn4 = new SqlConnection(coneccionString);
        SqlDataAdapter da4 = new SqlDataAdapter();
        String query4 = " SELECT itemname,sum(T1.price*-1*T1.quantity) quantity,T2.QryGroup1,T2.QryGroup2 FROM " + SAP + ".[RIN1] T1 JOIN " + SAP + ".[OITM] T2 ON T1.itemcode=T2.itemcode WHERE T1.docdate>='" + inicio0 + "' AND T1.docdate<'" + termino0 + "' AND T1.baseCard='" + codigoCliente + "' GROUP BY itemname, T2.QryGroup1, T2.QryGroup2 ";

        SqlConnection cn5 = new SqlConnection(coneccionString);
        SqlDataAdapter da5 = new SqlDataAdapter();
        String query5 = " SELECT T1.*,T2.itemcode, T2.itemname,T2.QryGroup1,T2.QryGroup2 FROM " + MAER + ".[Presupuesto] T1 JOIN " + SAP + ".[OITM] T2 ON T1.articulo=T2.itemCode WHERE T1.cliente='" + codigoCliente + "' AND T1.ano='" + ano + "' AND tipo='2' ";

        da1.SelectCommand = new SqlCommand(query1, cn1);
        da2.SelectCommand = new SqlCommand(query2, cn2);
        da3.SelectCommand = new SqlCommand(query3, cn3);
        da4.SelectCommand = new SqlCommand(query4, cn4);
        da5.SelectCommand = new SqlCommand(query5, cn5);

        try
        {
            da1.Fill(dt1);
            da2.Fill(dt2);
            da3.Fill(dt3);
            da4.Fill(dt4);
            da5.Fill(dt5);
            sal.t1 = dt1;
            sal.t2 = dt2;
            sal.t3 = dt3;
            sal.t4 = dt4;
            sal.t5 = dt5;
            sal.CardCode = codigoCliente;
            sal.CardName = cliente;
            sal.mes = mes;
            sal.ano = ano;
        }
        finally
        {
            cn1.Close();
            cn2.Close();
        }
        return sal;
    }

    [WebMethod]
    public DataTable getProductos(string cliente, string ano, string en)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Productos";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT itemCode, itemName, T2.* FROM " + SAP + ".[OITM] T1 LEFT JOIN " + MAER + ".[Presupuesto] T2 ON T1.itemCode=T2.articulo AND cliente='" + cliente + "' AND ano='" + ano + "' AND tipo='" + en + "' WHERE itmsgrpcod='102' AND (T1.QryGroup1='Y' OR T1.QryGroup2='Y') ORDER BY itemName ";

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

    private Boolean existePresupuesto(string articulo,string cliente,string ano, string tipo)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = " SELECT count (*) FROM " + MAER + ".[Presupuesto] WHERE articulo='"+articulo+"' AND cliente='"+cliente+"' AND ano='"+ano+"' AND tipo='"+tipo+"' ";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 1) return true;
        }
        return false;
    }

    [WebMethod]
    public int guardarPresupuesto(string cliente, string ano, Presupuesto p, string tipo)
    {
        if (existePresupuesto(p.itemCode,cliente, ano, tipo))
        {
            return Ejecutar(" UPDATE " + MAER + ".[Presupuesto] SET enero='"+p.enero+"', febrero='"+p.febrero+"', marzo='"+p.marzo+"', abril='"+p.abril+"', mayo='"+p.mayo+"', junio='"+p.junio+"', julio='"+p.julio+"', agosto='"+p.agosto+"', septiembre='"+p.septiembre+"', octubre='"+p.octubre+"', noviembre='"+p.noviembre+"', diciembre='"+p.diciembre+"' WHERE articulo='"+p.itemCode+"' AND cliente='"+cliente+"' AND ano='"+ano+"' AND tipo='"+tipo+"'");
        }
        else
        {
            return Ejecutar(" INSERT INTO " + MAER + ".[Presupuesto] (articulo,cliente,ano,enero,febrero,marzo,abril,mayo,junio,julio,agosto,septiembre,octubre,noviembre,diciembre,tipo) VALUES ('"+p.itemCode+"','"+cliente+"','"+ano+"','"+p.enero+"','"+p.febrero+"','"+p.marzo+"','"+p.abril+"','"+p.mayo+"','"+p.junio+"','"+p.julio+"','"+p.agosto+"','"+p.septiembre+"','"+p.octubre+"','"+p.noviembre+"','"+p.diciembre+"','"+tipo+"')");
        }
    }
}

