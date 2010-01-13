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
    public DataTable getItems()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Items";

        SqlConnection cn = new SqlConnection(url);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT *, 0 FROM [PracticaDb].[dbo].[Items] ORDER BY orden";

        da.SelectCommand = new SqlCommand(query, cn);

        try{ da.Fill(dt);}
        finally{ cn.Close();}

        return dt;
    }

    [WebMethod]
    public DataTable getFlujos()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Flujos";

        SqlConnection cn = new SqlConnection(url);

        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT [itemName], SUM(credit)-SUM(debit)"+
                       " FROM [Maspan].[dbo].[OACT] T1"+ 
                       " INNER JOIN [Maspan].[dbo].[JDT1] T4 ON T4.[Account]=T1.[AcctCode]"+ 
                       " INNER JOIN [PracticaDb].[dbo].[ItemCuenta] T2 ON T1.AcctCode = T2.cuenta"+
                       " INNER JOIN [PracticaDb].[dbo].[Items] T3 ON T3.id = T2.item"+
                       " GROUP BY itemName, orden";

        da.SelectCommand = new SqlCommand(query, cn);

        try { da.Fill(dt); }
        finally { cn.Close(); }

        return dt;
    }

    
    /************************************************/
    /*                                              */
    /**DE AQUI HACIA ABAJO SON LA FUNCIONES USADAS **/
    /*                                              */
    /************************************************/

    [WebMethod]
    public DataTable detalle(int idItem, int mes, int ano)
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
                       " WHERE T3.id='" + idItem + "' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'" +
                       " ORDER BY AcctName, RefDate ";

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
    public Flujo getFlujo(int id, string itemName, int itemIndex, int ano)
    {
        Flujo f = new Flujo();
        f.cuenta = itemName;
        f.orden = itemIndex;
        List<int> m = new List<int>();

        double acum = 0;

        for (int i = 1; i < 13; i++)
        {
            DataTable dt = flujo(id, i, ano);
            if (dt.Rows.Count == 1)
            {
                m.Add(Int32.Parse(System.Math.Truncate(double.Parse((dt.Rows[0][1].ToString())+500)/1000) + ""));
                acum += double.Parse(dt.Rows[0][1].ToString());
            }
            else m.Add(0);
        }

        f.meses = m;

        DataTable dt2 = Presupuesto(id, ano);
        if (dt2.Rows.Count == 1) f.ppto = Int32.Parse(System.Math.Truncate(double.Parse((dt2.Rows[0][1].ToString()) + 500) / 1000) + "");
        else f.ppto = 0;
        
        f.ano = ano;
        return f;
    }

    public DataTable flujo(int idItem, int mes, int ano)
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
                       " WHERE T3.id='"+idItem+"' AND RefDate>='"+fi+"' AND RefDate<'"+ft+"'"+
                       " GROUP BY itemName";

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
	
    public DataTable Presupuesto(int idItem, int ano)
    {
        string query = 	" SELECT	t5.itemName, SUM(t1.CredLTotal-t1.DebLTotal)"+
						" FROM		Maspan.dbo.BGT1				t1"+
						" JOIN		Maspan.dbo.OBGT				t2		ON		t1.acctcode=t2.acctcode"+
						" JOIN		Maspan.dbo.OACT				t3		ON		t3.acctcode=t2.acctcode"+
						" JOIN		PracticaDB.dbo.ItemCuenta	t4		ON		t1.acctcode=t4.cuenta"+
						" JOIN		PracticaDB.dbo.Items		t5		ON		t5.id=t4.item"+
						" WHERE		t2.FinancYear>='"+ano+"-01-01 00:00.000' AND t5.id='"+idItem+"'"+
						" GROUP BY	t5.ItemName";

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
