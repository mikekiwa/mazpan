using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : System.Web.Services.WebService
{
    private string url = Coneccion.coneccionStringSVRMASPAN;

    public Service ()
    { 
    }

    [WebMethod]
    public DataTable getSucursales()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Sucursales";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM [Maspan].[dbo].[OASC] WHERE SegmentId='1'";

        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }

        return dt;
    }

    [WebMethod]
    public DataTable getItems()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Items";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM [PracticaDb].[dbo].[Items] ORDER BY orden";

        da.SelectCommand = new SqlCommand(query, cn);

        try{ da.Fill(dt);}
        finally{ cn.Close();}

        return dt;
    }

    [WebMethod]
    public DataTable especifico(string sucursal, int idItem, int mes, int ano, string codigoCuenta)
    {
        DateTime f1 = new DateTime(ano, mes, 01);
        DateTime f2 = f1.AddMonths(1);
        string fi;
        string ft;
        if (f1.Month > 9) fi = f1.Year + "-" + f1.Month + "-01 00:00.000";
        else fi = f1.Year + "-0" + f1.Month + "-01 00:00.000";
        if (f2.Month > 9) ft = f2.Year + "-" + f2.Month + "-01 00:00.000";
        else ft = f2.Year + "-0" + f2.Month + "-01 00:00.000";

        string query = " SELECT T1.AcctName, T4.[Credit]-T4.[Debit], RefDate" +
                       " FROM [Maspan].[dbo].[OACT] T1" +
                       " INNER JOIN [Maspan].[dbo].[JDT1] T4            ON T4.[Account]=T1.[AcctCode]" +
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2  ON T1.AcctCode = T2.cuenta" +
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3       ON T3.id = T2.item" +
                       " WHERE T3.id='" + idItem + "' AND T1.AcctCode='"+codigoCuenta+"' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'";
		if (sucursal.CompareTo("00") != 0) 
            query +=   " AND T1.Segment_1='" + sucursal + "'";
        query +=       " ORDER BY AcctName, RefDate ";

        DataTable dt = new DataTable();
        dt.TableName = "Especifico";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();

        cn.Open();
        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }


        return dt;
    }

    [WebMethod]
    public DataTable detalle(string sucursal, int idItem, int mes, int ano)
    {
        DateTime f1 = new DateTime(ano, mes, 01);
        DateTime f2 = f1.AddMonths(1);
        string fi;
        string ft;
        if (f1.Month > 9) fi = f1.Year + "-" + f1.Month + "-01 00:00.000";
        else fi = f1.Year + "-0" + f1.Month + "-01 00:00.000";
        if (f2.Month > 9) ft = f2.Year + "-" + f2.Month + "-01 00:00.000";
        else ft = f2.Year + "-0" + f2.Month + "-01 00:00.000";

        string query = " SELECT T1.Segment_0,T1.Segment_1,T1.Segment_2,T1.Segment_3,T1.Segment_4, T1.AcctName, sum(T4.[Credit]-T4.[Debit]),AcctCode" +
                       " FROM [Maspan].[dbo].[OACT] T1" +
                       " INNER JOIN [Maspan].[dbo].[JDT1] T4            ON T4.[Account]=T1.[AcctCode]" +
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2  ON T1.AcctCode = T2.cuenta" +
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3       ON T3.id = T2.item" +
                       " WHERE T3.id='" + idItem + "' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'";
        if (sucursal.CompareTo("00") != 0) 
            query +=   " AND T1.Segment_1='" + sucursal + "'";
        query +=       " GROUP BY AcctName, segment_0,segment_1,segment_2,segment_3,segment_4,AcctCode";

        DataTable dt = new DataTable();
        dt.TableName = "Detalle";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();

        cn.Open();
        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }


        return dt;
    }
    [WebMethod]
    public Flujo getFlujo(string sucursal, int id, string itemName, int itemIndex, int ano)
    {
        Flujo f = new Flujo();
        f.cuenta = itemName;
        f.orden = itemIndex;
        List<int> m = new List<int>();
		List<int> pm = new List<int>();
		
        double acum = 0;

        for (int i = 1; i < 13; i++)
        {
            DataTable dt = flujo(sucursal,id, i, ano);
            if (dt.Rows.Count == 1)
            {
                m.Add(Int32.Parse(System.Math.Truncate(double.Parse((dt.Rows[0][1].ToString())+500)/1000) + ""));
                acum += double.Parse(dt.Rows[0][1].ToString());
            }
            else m.Add(0);

            DataTable dt3 = PresupuestoMensual(sucursal, id, i - 1, ano);
            if (dt3.Rows.Count != 1) pm.Add(0);
            else pm.Add(Int32.Parse(System.Math.Truncate(double.Parse((dt3.Rows[0][1].ToString())+500)/1000) + ""));

        }

        f.meses = m;
		f.pptoMensual = pm;

        f.ano = ano;
        return f;
    }

    public DataTable flujo(string sucursal, int idItem, int mes, int ano)
    {
        DateTime f1 = new DateTime(ano,mes,01);
        DateTime f2 = f1.AddMonths(1);
        string fi;
        string ft;
        if(f1.Month>9) fi = f1.Year+"-"+f1.Month+"-01 00:00.000";
        else fi = f1.Year + "-0" + f1.Month + "-01 00:00.000";
        if(f2.Month>9) ft = f2.Year + "-" + f2.Month + "-01 00:00.000";
        else ft = f2.Year + "-0" + f2.Month + "-01 00:00.000";

        string query = "SELECT T3.[itemName],SUM(T4.[Credit]-T4.[Debit])" +
                       " FROM [Maspan].[dbo].[OACT] T1" +
                       " INNER JOIN [Maspan].[dbo].[JDT1] T4 ON T4.[Account]=T1.[AcctCode]" +
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2 ON T1.AcctCode = T2.cuenta" +
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3 ON T3.id = T2.item"+
                       " WHERE T3.id='"+idItem+"' AND RefDate>='"+fi+"' AND RefDate<'"+ft+"'";
        if (sucursal.CompareTo("00") != 0) query += " AND T1.Segment_1='"+sucursal+"'";
        query  += " GROUP BY itemName";

        DataTable dt = new DataTable();
        dt.TableName = "MES";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();

        cn.Open();
        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }

        return dt;
    }

    [WebMethod]
    public DataTable getCuentas()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Cuentas";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "select distinct(AcctName), AcctCode, Segment_0, Segment_1, Segment_2, Segment_3, Segment_4, GroupMask" +
                       " from [Maspan].[dbo].[OACT], [PracticaDB].[dbo].[ItemCuenta]" +
                       " where AcctCode NOT IN (select cuenta from [PracticaDB].[dbo].[itemcuenta]) AND levels=5 AND GroupMask>3" +
                       " order by GroupMask,Segment_0,Segment_1,AcctName";

        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }

        return dt;
    }

    [WebMethod]
    public int guardar(List<string> codigos, string itemId)
    {
        int result=0;
        foreach (string c in codigos)
        {
            String query = "INSERT INTO [PracticaDb].[dbo].[ItemCuenta](cuenta,item) VALUES('" + c + "','" + itemId + "')";
            SqlConnection cn = new SqlConnection(url);
            cn.Open();
            SqlCommand insert = new SqlCommand(query, cn);

            result += insert.ExecuteNonQuery();
            cn.Close();
        }
        if (result < codigos.Count) return - 1;
        if (result == codigos.Count) return 1;
        return 0;
    }

    [WebMethod]
    public DataTable getCuentasItem(int id)
    {
        DataTable dt = new DataTable();
        dt.TableName = "CuentasItem";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();
        //La primera linea de la query es para borrar cuentas que ya no existan en SAP
        //Esto lo debo preguntar porque los registros de las cuentas me imagino que se mantienen
        String query = " DELETE [PracticaDb].[dbo].[itemCuenta] WHERE cuenta NOT IN (SELECT AcctCode FROM [Maspan].[dbo].[OACT]);"+
                       " SELECT DISTINCT(AcctName), AcctCode, Segment_0, Segment_1, Segment_2, Segment_3, Segment_4, GroupMask"+
                       " FROM [PracticaDb].[dbo].[ItemCuenta] T1 INNER JOIN [Maspan].[dbo].[OACT] T2"+
                       " ON T1.cuenta=T2.AcctCode"+
                       " WHERE T1.item='"+id+"'"+
                       " ORDER BY GroupMask,Segment_0,Segment_1,AcctName";

        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }

        return dt;
    }

    [WebMethod]
    public int quitar(List<string> cuentas)
    {
        int results = 0;
        foreach (string c in cuentas)
        {
            String query = "DELETE [PracticaDb].[dbo].[ItemCuenta] WHERE cuenta='"+c+"'";
            SqlConnection cn = new SqlConnection(url);
            cn.Open();
            SqlCommand insert = new SqlCommand(query, cn);

            results += insert.ExecuteNonQuery();
            cn.Close();
        }
        if (results < cuentas.Count) return -1;
        if (results == cuentas.Count) return 1;
        return 0;
    }
	
    [WebMethod]
	public DataTable PresupuestoMensual(string sucursal, int idItem, int mes, int ano)
    {
        string query = " SELECT 	T4.itemName, SUM(T1.CredLTotal - T1.DebLTotal) " +
                        " FROM 		[Maspan].[dbo].BGT1					T1 " +
                        " JOIN 		[Maspan].[dbo].OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                        " JOIN 		[PracticaDB].[dbo].ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                        " JOIN 		[PracticaDB].[dbo].Items			T4		ON		T4.id=T3.item " +
                        " JOIN      [Maspan].[dbo].OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                        " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' " +
                        " AND 		T4.id='" + idItem + "' " +
                        " AND 		Line_ID='" + mes + "' ";
        if(sucursal.CompareTo("00")!=0) query += " AND T5.Segment_1='"+sucursal+"'";
        query  +=       " GROUP BY 	T4.ItemName ";

        DataTable dt = new DataTable();
        dt.TableName = "PresupuestoMensual";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();

        cn.Open();
        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }

        return dt;
    }
}
