<%@ WebService Language="C#" CodeBehind="/App_Code/Service.cs" Class="Service" %>

using System;
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
    private string coneccionString = Coneccion.coneccionString;
    private string SAP = Coneccion.SapDbMaspan;
    private string MAER = Coneccion.PracticaDbMaspan;


    public Service ()
    {
        
        //Server.ScriptTimeout = 60;
    }

    [WebMethod]
    public DataTable getSucursales()
    {
        String query = "SELECT T1.*,T2.Nivel FROM " + SAP + ".[OASC] T1 LEFT JOIN " + MAER + ".[NivelSucursal] T2 ON T1.Code=T2.codigo WHERE SegmentId='1' AND Code!='05'";

        return obtenerTabla("Sucursales", query);
    }

    [WebMethod]
    public DataTable getItems()
    {
        String query = "SELECT * FROM " + MAER + ".[Items] ORDER BY orden";

        return obtenerTabla("Items",query);
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
                       " FROM " + SAP + ".[OACT] T1" +
                       " INNER JOIN " + SAP + ".[JDT1] T4            ON T4.[Account]=T1.[AcctCode]" +
                       " INNER JOIN " + MAER + ".[ItemCuenta] T2  ON T1.AcctCode = T2.cuenta" +
                       " INNER JOIN " + MAER + ".[Items] T3       ON T3.id = T2.item" +
                       " WHERE T3.id='" + idItem + "' AND T1.AcctCode='"+codigoCuenta+"' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'" +
                       " ORDER BY AcctName, RefDate ";

        return obtenerTabla("Especifico",query);
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

        string query;
        if (sucursal.CompareTo("00") == 0)
        {
            query = " SELECT T1.Segment_0,T1.Segment_1,T1.Segment_2,T1.Segment_3,T1.Segment_4, T1.AcctName, sum(convert(int,T4.[Credit]/1000)-convert(int,T4.[Debit]/1000)),AcctCode" +
                    " FROM " + SAP + ".[OACT] T1" +
                    " INNER JOIN " + SAP + ".[JDT1] T4            ON T4.[Account]=T1.[AcctCode]" +
                    " INNER JOIN " + MAER + ".[ItemCuenta] T2  ON T1.AcctCode = T2.cuenta" +
                    " INNER JOIN " + MAER + ".[Items] T3       ON T3.id = T2.item" +
                    " WHERE T3.id='" + idItem + "' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'" +
                    " GROUP BY AcctName, segment_0,segment_1,segment_2,segment_3,segment_4,AcctCode";
        }
        else if (sucursal.CompareTo("01") == 0)
        {
            query = " SELECT T1.Segment_0,T1.Segment_1,T1.Segment_2,T1.Segment_3,T1.Segment_4, T1.AcctName, sum(convert(int,T4.[Credit]/1000)-convert(int,T4.[Debit]/1000)),AcctCode" +
                    " FROM " + SAP + ".[OACT] T1" +
                    " INNER JOIN " + SAP + ".[JDT1] T4            ON T4.[Account]=T1.[AcctCode]" +
                    " INNER JOIN " + MAER + ".[ItemCuenta] T2  ON T1.AcctCode = T2.cuenta" +
                    " INNER JOIN " + MAER + ".[Items] T3       ON T3.id = T2.item" +
                    " WHERE T3.id='" + idItem + "' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'" +
                    " AND (T1.[Segment_1]='01' OR T1.[Segment_1]='05' OR (T1.[Segment_1]='00' AND T1.AcctCode!='_SYS00000001166')) "+
                    " GROUP BY AcctName, segment_0,segment_1,segment_2,segment_3,segment_4,AcctCode";
        }
        else if (sucursal.CompareTo("23") == 0)
        {
            query = " SELECT T1.Segment_0,T1.Segment_1,T1.Segment_2,T1.Segment_3,T1.Segment_4, T1.AcctName, sum(convert(int,T4.[Credit]/1000)-convert(int,T4.[Debit]/1000)),AcctCode" +
                    " FROM " + SAP + ".[OACT] T1" +
                    " INNER JOIN " + SAP + ".[JDT1] T4            ON T4.[Account]=T1.[AcctCode]" +
                    " INNER JOIN " + MAER + ".[ItemCuenta] T2  ON T1.AcctCode = T2.cuenta" +
                    " INNER JOIN " + MAER + ".[Items] T3       ON T3.id = T2.item" +
                    " WHERE T3.id='" + idItem + "' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'" +
                    " AND (T1.[Segment_1]='23' OR T1.AcctCode='_SYS00000001166') " +
                    " GROUP BY AcctName, segment_0,segment_1,segment_2,segment_3,segment_4,AcctCode"; 
        }
        else
        {
            query = " SELECT T1.Segment_0,T1.Segment_1,T1.Segment_2,T1.Segment_3,T1.Segment_4, T1.AcctName, sum(convert(int,T4.[Credit]/1000)-convert(int,T4.[Debit]/1000)),AcctCode" +
                     " FROM " + SAP + ".[OACT] T1" +
                     " INNER JOIN " + SAP + ".[JDT1] T4            ON T4.[Account]=T1.[AcctCode]" +
                     " INNER JOIN " + MAER + ".[ItemCuenta] T2  ON T1.AcctCode = T2.cuenta" +
                     " INNER JOIN " + MAER + ".[Items] T3       ON T3.id = T2.item" +
                     " WHERE T3.id='" + idItem + "' AND RefDate>='" + fi + "' AND RefDate<'" + ft + "'" +
                     " AND T1.Segment_1='" + sucursal + "'" +
                     " GROUP BY AcctName, segment_0,segment_1,segment_2,segment_3,segment_4,AcctCode";
        }

        return obtenerTabla("Detalle", query);
    }

    private List<Monto> getMontos(DataTable FLUJO, DataTable ITEMS)
    {
        List<Monto> montos = new List<Monto>();

        foreach (DataRow row1 in ITEMS.Rows)
        {
            foreach (DataRow row2 in FLUJO.Rows)
            {
                if (row1[1].ToString() == row2[1].ToString())
                {
                    Monto m = new Monto();
                    m.itemName = row1[0].ToString();
                    m.Column1 = row2[0].ToString();
                    montos.Add(m);
                }
            }
        }

        int monto = 0;
        string item="";
        if(montos.Count>0) item = montos[0].itemName;

        List<Monto> montos2 = new List<Monto>();
        foreach (Monto m in montos)
        {
            if (item != m.itemName)
            {
                Monto mo = new Monto();
                mo.itemName = item;
                int redondeo = monto / 1000;
                mo.Column1 = redondeo.ToString();
                montos2.Add(mo);

                monto = 0;
                item = m.itemName;
            }
            monto += Int32.Parse(m.Column1);
        }
        Monto aux = new Monto();
        aux.itemName = item;
        int redondeo2 = monto / 1000;
        aux.Column1 = redondeo2.ToString();
        montos2.Add(aux);
        return montos2;
    }

    [WebMethod]
    public Flujo getFlujo(string sucursal, int ano, int mes)
    {
        Flujo f = new Flujo();

        DataTable items = obtenerTabla("ItemsCuentas", "SELECT T6.[itemName],T5.cuenta FROM " + MAER + ".[ItemCuenta] T5 JOIN " + MAER + ".[Items] T6 ON T6.id = T5.item ORDER BY T6.[itemName]");

        if (mes == 1)
        {
            f.FLUJOENE = getMontos(flujo(sucursal, 1, ano),items);
            f.PPTOENE = PresupuestoMensual(sucursal, 0, ano);
        }
        else if (mes == 2)
        {
            f.FLUJOFEB = getMontos(flujo(sucursal, 2, ano),items);
            f.PPTOFEB = PresupuestoMensual(sucursal, 1, ano);
        }
        else if (mes == 3)
        {
            f.FLUJOMAR = getMontos(flujo(sucursal, 3, ano),items);
            f.PPTOMAR = PresupuestoMensual(sucursal, 2, ano);
        }
        else if (mes == 4)
        {
            f.FLUJOABR = getMontos(flujo(sucursal, 4, ano),items);
            f.PPTOABR = PresupuestoMensual(sucursal, 3, ano);
        }
        else if (mes == 5)
        {
            f.FLUJOMAY = getMontos(flujo(sucursal, 5, ano),items);
            f.PPTOMAY = PresupuestoMensual(sucursal, 4, ano);
        }
        else if (mes == 6)
        {
            f.FLUJOJUN = getMontos(flujo(sucursal, 6, ano),items);
            f.PPTOJUN = PresupuestoMensual(sucursal, 5, ano);
        }
        else if (mes == 7)
        {
            f.FLUJOJUL = getMontos(flujo(sucursal, 7, ano),items);
            f.PPTOJUL = PresupuestoMensual(sucursal, 6, ano);
        }
        else if (mes == 8)
        {
            f.FLUJOAGO = getMontos(flujo(sucursal, 8, ano),items);
            f.PPTOAGO = PresupuestoMensual(sucursal, 7, ano);
        }
        else if (mes == 9)
        {
            f.FLUJOSEP = getMontos(flujo(sucursal, 9, ano),items);
            f.PPTOSEP = PresupuestoMensual(sucursal, 8, ano);
        }
        else if (mes == 10)
        {
            f.FLUJOOCT = getMontos(flujo(sucursal, 10, ano),items);
            f.PPTOOCT = PresupuestoMensual(sucursal, 9, ano);
        }
        else if (mes == 11)
        {
            f.FLUJONOV = getMontos(flujo(sucursal, 11, ano),items);
            f.PPTONOV = PresupuestoMensual(sucursal, 10, ano);
        }
        else if (mes == 12)
        {
            f.FLUJODIC = getMontos(flujo(sucursal, 12, ano), items);
            f.PPTODIC = PresupuestoMensual(sucursal, 11, ano);
        }
        f.MESNUMERO = mes;
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
            query = " SELECT convert(int,sum(T4.[Credit]-T4.[Debit])) as Column1, T4.[Account] " +
                    " FROM " + SAP + ".[JDT1] T4 " +
                    " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' GROUP BY T4.[Account]";
        }
        else if(sucursal.CompareTo("01") == 0)
        {
            query = " SELECT convert(int,sum(T4.[Credit]-T4.[Debit])) as Column1, T4.[Account]" +
                    " FROM " + SAP + ".[OACT] T1" +
                    " INNER JOIN " + SAP + ".[JDT1] T4 ON T4.[Account]=T1.[AcctCode]" +
                    " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' AND (T1.[Segment_1]='01' OR T1.[Segment_1]='05' OR (T1.[Segment_1]='00' AND T1.AcctCode!='_SYS00000001166')) GROUP BY T4.[Account]";
        }
        else if (sucursal.CompareTo("23") == 0)
        {
            query = " SELECT convert(int,sum(T4.[Credit]-T4.[Debit])) as Column1, T4.[Account]" +
                    " FROM " + SAP + ".[OACT] T1" +
                    " INNER JOIN " + SAP + ".[JDT1] T4 ON T4.[Account]=T1.[AcctCode]" +
                    " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' AND (T1.[Segment_1]='23' OR T1.AcctCode='_SYS00000001166') GROUP BY T4.[Account]";
        }
        else 
        {
            query = " SELECT convert(int,sum(T4.[Credit]-T4.[Debit])) as Column1, T4.[Account]" +
                    " FROM " + SAP + ".[OACT] T1" +
                    " INNER JOIN " + SAP + ".[JDT1] T4 ON T4.[Account]=T1.[AcctCode]" +
                    " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' AND T1.[Segment_1]='" + sucursal + "' GROUP BY T4.[Account]";
        }
       
        return obtenerTabla("MES",query);
    }

    public DataTable PresupuestoMensual(string sucursal, int mes, int ano)
    {
        string query;
        if (sucursal.CompareTo("00") == 0)
        {
            query = " SELECT 	T4.itemName, SUM(T1.CredLTotal-T1.DebLTotal)/1000 as Column1" +
                     " FROM 	" + SAP + ".BGT1					T1 " +
                     " JOIN 	" + SAP + ".OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	" + MAER + ".ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	" + MAER + ".Items			T4		ON		T4.id=T3.item " +
                     " JOIN     " + SAP + ".OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' " +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }
        else if (sucursal.CompareTo("01") == 0)
        {
            query =  " SELECT 	T4.itemName, SUM(T1.CredLTotal-T1.DebLTotal)/1000 as Column1" +
                     " FROM 	" + SAP + ".BGT1					T1 " +
                     " JOIN 	" + SAP + ".OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	" + MAER + ".ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	" + MAER + ".Items			T4		ON		T4.id=T3.item " +
                     " JOIN     " + SAP + ".OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND ([Segment_1]='01' OR [Segment_1]='05' OR ([Segment_1]='00' AND T1.AcctCode!='_SYS00000001166')) " +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }
        else if (sucursal.CompareTo("23") == 0)
        {
            query =  " SELECT 	T4.itemName, SUM(T1.CredLTotal-T1.DebLTotal)/1000 as Column1" +
                     " FROM 	" + SAP + ".BGT1					T1 " +
                     " JOIN 	" + SAP + ".OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	" + MAER + ".ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	" + MAER + ".Items			T4		ON		T4.id=T3.item " +
                     " JOIN     " + SAP + ".OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND ([Segment_1]='23' OR T1.AcctCode='_SYS00000001166')" +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }
        else
        {
            query =  " SELECT 	T4.itemName, SUM(T1.CredLTotal-T1.DebLTotal)/1000 as Column1" +
                     " FROM 	" + SAP + ".BGT1					T1 " +
                     " JOIN 	" + SAP + ".OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                     " JOIN 	" + MAER + ".ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                     " JOIN 	" + MAER + ".Items			T4		ON		T4.id=T3.item " +
                     " JOIN     " + SAP + ".OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                     " WHERE 	T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND [Segment_1]='"+sucursal+"'" +
                     " AND 		Line_ID='" + mes + "' GROUP BY 	T4.ItemName";
        }

        return obtenerTabla("PresupuestoMensual",query);
    }

    [WebMethod]
    public DataTable getCuentas()
    {
        String query = " select distinct(AcctName), AcctCode, Segment_0, Segment_1, Segment_2, Segment_3, Segment_4, GroupMask" +
                       " from " + SAP + ".[OACT], " + MAER + ".[ItemCuenta]" +
                       " where AcctCode NOT IN (select cuenta from " + MAER + ".[itemcuenta]) AND levels=5 AND GroupMask>3" +
                       " order by GroupMask,Segment_0,Segment_1,AcctName";

        return obtenerTabla("Cuentas",query);
    }

    [WebMethod]
    public int guardar(List<string> codigos, string itemId)
    {
        int result=0;
        foreach (string c in codigos)
        {
            String query = "INSERT INTO " + MAER + ".[ItemCuenta](cuenta,item) VALUES('" + c + "','" + itemId + "')";
            SqlConnection cn = new SqlConnection(coneccionString);
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
        //La primera linea de la query es para borrar cuentas que ya no existan en SAP
        //Esto lo debo preguntar porque los registros de las cuentas me imagino que se mantienen
        String query = " DELETE " + MAER + ".[itemCuenta] WHERE cuenta NOT IN (SELECT AcctCode FROM " + SAP + ".[OACT]);"+
                       " SELECT DISTINCT(AcctName), AcctCode, Segment_0, Segment_1, Segment_2, Segment_3, Segment_4, GroupMask"+
                       " FROM " + MAER + ".[ItemCuenta] T1 INNER JOIN " + SAP + ".[OACT] T2"+
                       " ON T1.cuenta=T2.AcctCode"+
                       " WHERE T1.item='"+id+"'"+
                       " ORDER BY GroupMask,Segment_0,Segment_1,AcctName";

        return obtenerTabla("CuentasItem",query);
    }

    [WebMethod]
    public int quitar(List<string> cuentas)
    {
        int results = 0;
        foreach (string c in cuentas)
        {
            String query = "DELETE " + MAER + ".[ItemCuenta] WHERE cuenta='"+c+"'";
            SqlConnection cn = new SqlConnection(coneccionString);
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
        string query;

        if(sucursal.CompareTo("00") == 0)
        {
            query = " SELECT T5.ItemName,T1.CredLTotal/1000, T1.DebLTotal/1000,t3.AcctName,Line_ID " +
                    " FROM " + SAP + ".BGT1 T1 " +
                    " JOIN " + SAP + ".OBGT T2 ON T1.BudgId = T2.AbsId " +
                    " JOIN Maspan.dbo.oact T3 ON T2.AcctCode=T3.AcctCode " +
                    " JOIN " + MAER + ".ItemCuenta T4 ON T1.acctcode=T4.cuenta " +
                    " JOIN " + MAER + ".Items T5 ON T5.id=T4.item " +
                    " WHERE T2.FinancYear>='"+ano+"-01-01 00:00.000' AND T2.FinancYear<='"+ano+"-12-01 00:00.000' " +
                    " AND T5.id='"+idItem+"' ";
        }
        else if (sucursal.CompareTo("01") == 0)
        {
            query = " SELECT T5.ItemName,T1.CredLTotal/1000, T1.DebLTotal/1000,t3.AcctName,Line_ID " +
                    " FROM " + SAP + ".BGT1 T1 " +
                    " JOIN " + SAP + ".OBGT T2 ON T1.BudgId = T2.AbsId " +
                    " JOIN Maspan.dbo.oact T3 ON T2.AcctCode=T3.AcctCode " +
                    " JOIN " + MAER + ".ItemCuenta T4 ON T1.acctcode=T4.cuenta " +
                    " JOIN " + MAER + ".Items T5 ON T5.id=T4.item " +
                    " WHERE T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND (T3.[Segment_1]='01' OR T3.[Segment_1]='05' OR (T3.[Segment_1]='00' AND T1.AcctCode!='_SYS00000001166')) " +
                    " AND T5.id='"+idItem+"' ";
        }else if (sucursal.CompareTo("23") == 0)
        {
            query = " SELECT T5.ItemName,T1.CredLTotal/1000, T1.DebLTotal/1000,t3.AcctName,Line_ID " +
                    " FROM " + SAP + ".BGT1 T1 " +
                    " JOIN " + SAP + ".OBGT T2 ON T1.BudgId = T2.AbsId " +
                    " JOIN " + SAP + ".OACT T3 ON T2.AcctCode=T3.AcctCode " +
                    " JOIN " + MAER + ".ItemCuenta T4 ON T1.acctcode=T4.cuenta " +
                    " JOIN " + MAER + ".Items T5 ON T5.id=T4.item " +
                    " WHERE T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND (T3.[Segment_1]='23' OR T1.AcctCode='_SYS00000001166')" +
                    " AND T5.id='"+idItem+"' "; 
        }else
        {
            query = " SELECT T5.ItemName,T1.CredLTotal/1000, T1.DebLTotal/1000,t3.AcctName,Line_ID " +
                    " FROM " + SAP + ".BGT1 T1 " +
                    " JOIN " + SAP + ".OBGT T2 ON T1.BudgId = T2.AbsId " +
                    " JOIN " + SAP + ".OACT T3 ON T2.AcctCode=T3.AcctCode " +
                    " JOIN " + MAER + ".ItemCuenta T4 ON T1.acctcode=T4.cuenta " +
                    " JOIN " + MAER + ".Items T5 ON T5.id=T4.item " +
                    " WHERE T2.FinancYear>='"+ano+"-01-01 00:00.000' AND T2.FinancYear<='"+ano+"-12-01 00:00.000' " +
                    " AND T5.id='"+idItem+"' " +
                    " AND T3.Segment_1='" + sucursal + "'";
        }

        return obtenerTabla("Presupuesto",query);
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
    
    [WebMethod]
    public int cambiarNivel(Usuario u, List<Sucursal> sucursales, string nivel)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            string level;
            if (nivel == "1") level = "Panaderías";
            else level = "Zonas";
            int resultado = 0;

            foreach (Sucursal s in sucursales)
            {
                if (existe(MAER + ".[NivelSucursal]", "codigo='"+s.Code+"'"))
                {
                    resultado += Ejecutar("UPDATE " + MAER + ".[NivelSucursal] SET nivel='"+level+"' WHERE codigo='"+s.Code+"'");
                }
                else
                {
                    resultado += Ejecutar("INSERT INTO " + MAER + ".[NivelSucursal] (nivel,codigo) VALUES ('"+level+"', '"+s.Code+"')");
                }
            }
            if (sucursales.Count == resultado) return 1;
            else return -1;
        }
        else return 0;
    }

    [WebMethod]
    public DataTable getSucursales2(Usuario u)
    {
        if (existe("PracticaDb.dbo.Usuario", "userName='" + u.user + "' AND password='" + u.pass + "'"))
        {
            return obtenerTabla("Sucursales","SELECT T1.*,T2.Nivel FROM " + SAP + ".[OASC] T1 LEFT JOIN " + MAER + ".[NivelSucursal] T2 ON T1.Code=T2.codigo WHERE SegmentId='1' AND Code!='05' AND Code!='00' ORDER BY NIVEL DESC");
        }
        else
        {
            return null;
        }
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
    public Flujo getMOC(string sucursal, int mes, int ano)
    {
        DataTable items = obtenerTabla("ItemsCuentas", "SELECT T6.[itemName],T5.cuenta FROM " + MAER + ".[ItemCuenta] T5 JOIN " + MAER + ".[Items] T6 ON T6.id = T5.item WHERE orden<='28' ORDER BY T6.[itemName]");
        Flujo f = new Flujo();
        f.FLUJO = getMontos(flujo(sucursal, mes, ano), items);
        f.SUCURSAL = sucursal;
        
        return f;
    }
}
