﻿using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

[WebService(Namespace = "http://tempuri.org/Server/Service/")]
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
    public Flujo getFlujo(string sucursal, int ano)
    {
        Flujo f = new Flujo();
        
        f.FLUJOENE = flujo(sucursal, 1, ano);
        f.PPTOENE = PresupuestoMensual(sucursal, 0, ano);

        f.FLUJOFEB = flujo(sucursal, 2, ano);
        f.PPTOFEB = PresupuestoMensual(sucursal, 1, ano);

        f.FLUJOMAR = flujo(sucursal, 3, ano);
        f.PPTOMAR = PresupuestoMensual(sucursal, 2, ano);
        
        f.FLUJOABR = flujo(sucursal, 4, ano);
        f.PPTOABR = PresupuestoMensual(sucursal, 3, ano);

        f.FLUJOMAY = flujo(sucursal, 5, ano);
        f.PPTOMAY = PresupuestoMensual(sucursal, 4, ano);

        f.FLUJOJUN = flujo(sucursal, 6, ano);
        f.PPTOJUN = PresupuestoMensual(sucursal, 5, ano);

        f.FLUJOJUL = flujo(sucursal, 7, ano);
        f.PPTOJUL = PresupuestoMensual(sucursal, 6, ano);

        f.FLUJOAGO = flujo(sucursal, 8, ano);
        f.PPTOAGO = PresupuestoMensual(sucursal, 7, ano);

        f.FLUJOSEP = flujo(sucursal, 9, ano);
        f.PPTOSEP = PresupuestoMensual(sucursal, 8, ano);

        f.FLUJOOCT = flujo(sucursal, 10, ano);
        f.PPTOOCT = PresupuestoMensual(sucursal, 9, ano);

        f.FLUJONOV = flujo(sucursal, 11, ano);
        f.PPTONOV = PresupuestoMensual(sucursal, 10, ano);

        f.FLUJODIC = flujo(sucursal, 12, ano);
        f.PPTODIC = PresupuestoMensual(sucursal, 11, ano);
        
        return f;
    }

    public DataTable flujo(string sucursal, int mes, int ano)
    {
        DateTime f1 = new DateTime(ano,mes,01);
        DateTime f2 = f1.AddMonths(1);
        string fi;
        string ft;
        if(f1.Month>9) fi = f1.Year+"-"+f1.Month+"-01 00:00.000";
        else fi = f1.Year + "-0" + f1.Month + "-01 00:00.000";
        if(f2.Month>9) ft = f2.Year + "-" + f2.Month + "-01 00:00.000";
        else ft = f2.Year + "-0" + f2.Month + "-01 00:00.000";

        string query;
        if (sucursal.CompareTo("00") == 0)
        {
            query =    " SELECT T3.[itemName],SUM(T4.[Credit]-T4.[Debit])/1000" +
                       " FROM [Maspan].[dbo].[JDT1] T4" +
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2 ON T4.[Account] = T2.cuenta" +
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3 ON T3.id = T2.item" +
                       " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' GROUP BY itemName";
        }
        else if(sucursal.CompareTo("01") == 0)
        {
            query =    " SELECT T3.[itemName],SUM(T4.[Credit]-T4.[Debit])/1000" +
                       " FROM [Maspan].[dbo].[OACT] T1" +
                       " INNER JOIN [Maspan].[dbo].[JDT1] T4 ON T4.[Account]=T1.[AcctCode]" +
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2 ON T1.AcctCode = T2.cuenta" +
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3 ON T3.id = T2.item" +
                       " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' AND (T1.[Segment_1]='01' OR T1.[Segment_1]='05') GROUP BY itemName";
        }
        else if (sucursal.CompareTo("23") == 0)
        {
            query =    " SELECT T3.[itemName],SUM(T4.[Credit]-T4.[Debit])/1000" +
                       " FROM [Maspan].[dbo].[OACT] T1" +
                       " INNER JOIN [Maspan].[dbo].[JDT1] T4 ON T4.[Account]=T1.[AcctCode]" +
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2 ON T1.AcctCode = T2.cuenta" +
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3 ON T3.id = T2.item" +
                       " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' AND (T1.[Segment_1]='23' OR T1.AcctCode='_SYS00000001166') GROUP BY itemName";
        }
        else 
        {
            query =    " SELECT T3.[itemName],SUM(T4.[Credit]-T4.[Debit])/1000" +
                       " FROM [Maspan].[dbo].[OACT] T1" +
                       " INNER JOIN [Maspan].[dbo].[JDT1] T4 ON T4.[Account]=T1.[AcctCode]" +
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2 ON T1.AcctCode = T2.cuenta" +
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3 ON T3.id = T2.item" +
                       " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' AND T1.[Segment_1]='"+sucursal+"' GROUP BY itemName";
        }
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

    public DataTable PresupuestoMensual(string sucursal, int mes, int ano)
    {
        string query;
        if (sucursal.CompareTo("00") == 0)
        {
            query =  " SELECT 	T4.itemName, SUM(T1.CredLTotal - T1.DebLTotal)/1000 " +
                     " FROM 	[Maspan].[dbo].BGT1					T1 " +
                     " JOIN 	[Maspan].[dbo].OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	[PracticaDB].[dbo].ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	[PracticaDB].[dbo].Items			T4		ON		T4.id=T3.item " +
                     " JOIN     [Maspan].[dbo].OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' " +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }
        else if (sucursal.CompareTo("01") == 0)
        {
            query =  " SELECT 	T4.itemName, SUM(T1.CredLTotal - T1.DebLTotal)/1000 " +
                     " FROM 	[Maspan].[dbo].BGT1					T1 " +
                     " JOIN 	[Maspan].[dbo].OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	[PracticaDB].[dbo].ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	[PracticaDB].[dbo].Items			T4		ON		T4.id=T3.item " +
                     " JOIN     [Maspan].[dbo].OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND ([Segment_1]='01' OR [Segment_1]='05') " +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }
        else if (sucursal.CompareTo("23") == 0)
        {
            query =  " SELECT 	T4.itemName, SUM(T1.CredLTotal - T1.DebLTotal)/1000 " +
                     " FROM 	[Maspan].[dbo].BGT1					T1 " +
                     " JOIN 	[Maspan].[dbo].OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	[PracticaDB].[dbo].ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	[PracticaDB].[dbo].Items			T4		ON		T4.id=T3.item " +
                     " JOIN     [Maspan].[dbo].OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND ([Segment_1]='23' OR T1.AcctCode='_SYS00000001166')" +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }
        else
        {
            query =  " SELECT 	T4.itemName, SUM(T1.CredLTotal - T1.DebLTotal)/1000 " +
                     " FROM 	[Maspan].[dbo].BGT1					T1 " +
                     " JOIN 	[Maspan].[dbo].OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	[PracticaDB].[dbo].ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	[PracticaDB].[dbo].Items			T4		ON		T4.id=T3.item " +
                     " JOIN     [Maspan].[dbo].OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND [Segment_1]='"+sucursal+"'" +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }

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
    public DataTable getPresupuesto(string sucursal, int idItem, int ano)
    {
        string query = " SELECT T5.ItemName,T1.CredLTotal/1000, T1.DebLTotal/1000,t3.AcctName,Line_ID " +
                        " FROM [Maspan].[dbo].BGT1 T1 " +
                        " JOIN [Maspan].[dbo].OBGT T2 ON T1.BudgId = T2.AbsId " +
                        " JOIN Maspan.dbo.oact T3 ON T2.AcctCode=T3.AcctCode " +
                        " JOIN [PracticaDB].[dbo].ItemCuenta T4 ON T1.acctcode=T4.cuenta " +
                        " JOIN [PracticaDB].[dbo].Items T5 ON T5.id=T4.item " +
                        " WHERE T2.FinancYear>='"+ano+"-01-01 00:00.000' AND T2.FinancYear<='"+ano+"-12-01 00:00.000' " +
                        " AND T5.id='"+idItem+"' ";
        if (sucursal.CompareTo("00") != 0) query += " AND T3.Segment_1='" + sucursal + "'";

        DataTable dt = new DataTable();
        dt.TableName = "Presupuesto";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();

        cn.Open();
        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }

        return dt;
    }
}
