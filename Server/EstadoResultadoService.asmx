<%@ WebService Language="C#" CodeBehind="/App_Code/EstadoResultadoService.cs" Class="EstadoResultadoService" %>

using System;
using System.Collections;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

/// <summary>
/// Summary description for EstadoResultadoService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/Service/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class EstadoResultadoService : System.Web.Services.WebService
{
    private string url = Coneccion.coneccionString;
    private string SAP = Coneccion.SapDbMaspan;
    private string MAER = Coneccion.PracticaDbMaspan;

    public EstadoResultadoService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
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
        string item = "";
        if (montos.Count > 0) item = montos[0].itemName;

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
            f.FLUJOENE = getMontos(flujo(sucursal, 1, ano), items);
            f.PPTOENE = PresupuestoMensual(sucursal, 0, ano); ;
        }
        else if (mes == 2)
        {
            f.FLUJOFEB = getMontos(flujo(sucursal, 2, ano), items);
            f.PPTOFEB = PresupuestoMensual(sucursal, 1, ano);
        }
        else if (mes == 3)
        {
            f.FLUJOMAR = getMontos(flujo(sucursal, 3, ano), items);
            f.PPTOMAR = PresupuestoMensual(sucursal, 2, ano);
        }
        else if (mes == 4)
        {
            f.FLUJOABR = getMontos(flujo(sucursal, 4, ano), items);
            f.PPTOABR = PresupuestoMensual(sucursal, 3, ano);
        }
        else if (mes == 5)
        {
            f.FLUJOMAY = getMontos(flujo(sucursal, 5, ano), items);
            f.PPTOMAY = PresupuestoMensual(sucursal, 4, ano);
        }
        else if (mes == 6)
        {
            f.FLUJOJUN = getMontos(flujo(sucursal, 6, ano), items);
            f.PPTOJUN = PresupuestoMensual(sucursal, 5, ano);
        }
        else if (mes == 7)
        {
            f.FLUJOJUL = getMontos(flujo(sucursal, 7, ano), items);
            f.PPTOJUL = PresupuestoMensual(sucursal, 6, ano);
        }
        else if (mes == 8)
        {
            f.FLUJOAGO = getMontos(flujo(sucursal, 8, ano), items);
            f.PPTOAGO = PresupuestoMensual(sucursal, 7, ano);
        }
        else if (mes == 9)
        {
            f.FLUJOSEP = getMontos(flujo(sucursal, 9, ano), items);
            f.PPTOSEP = PresupuestoMensual(sucursal, 8, ano);
        }
        else if (mes == 10)
        {
            f.FLUJOOCT = getMontos(flujo(sucursal, 10, ano), items);
            f.PPTOOCT = PresupuestoMensual(sucursal, 9, ano);
        }
        else if (mes == 11)
        {
            f.FLUJONOV = getMontos(flujo(sucursal, 11, ano), items);
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

    public DataTable flujo(string tipo, int mes, int ano)
    {
        DateTime f1 = new DateTime(ano, mes, 01);
        DateTime f2 = f1.AddMonths(1);
        string fi,ft;

        if (f1.Month > 9) fi = f1.Year + "-" + f1.Month + "-01 00:00.000";
        else fi = f1.Year + "-0" + f1.Month + "-01 00:00.000";
        if (f2.Month > 9) ft = f2.Year + "-" + f2.Month + "-01 00:00.000";
        else ft = f2.Year + "-0" + f2.Month + "-01 00:00.000";

        DataTable cuentas = obtenerTabla("Sucursales", "SELECT * FROM " + MAER + ".[NivelSucursal] T2 WHERE T2.Nivel='"+tipo+"'");

        string query;
        if (tipo == "Zonas")
        {
            query = " SELECT convert(int,sum(T4.[Credit]-T4.[Debit])) as Column1, T4.[Account] " +
                    " FROM " + SAP + ".[OACT] T1 " +
                    " JOIN " + SAP + ".[JDT1] T4 ON T4.[Account]=T1.[AcctCode] " +
                    " WHERE RefDate>='"+fi+"' AND RefDate<'"+ft+"' AND (";

            if (cuentas.Rows.Count > 0)
            {
                int i = 0;
                foreach (DataRow row in cuentas.Rows)
                {
                    if (i == 0) query += " T1.[Segment_1]='" + row[1].ToString() + "' ";
                    else query += " OR T1.[Segment_1]='" + row[1].ToString() + "' ";
                    i++;
                }
            }
            query += " )  AND T1.AcctCode!='_SYS00000001166' " +
                     " GROUP BY T4.[Account] ";
        }
        else
        {
            query = " SELECT convert(int,sum(T4.[Credit]-T4.[Debit])) as Column1, T4.[Account] " +
                    " FROM " + SAP + ".[OACT] T1 " +
                    " JOIN " + SAP + ".[JDT1] T4 ON T4.[Account]=T1.[AcctCode] " +
                    " WHERE RefDate>='" + fi + "' AND RefDate<'" + ft + "' AND (";

            if (cuentas.Rows.Count > 0)
                for (int i = 0; i < cuentas.Rows.Count; i++)
                    if (i == 0) query += " T1.[Segment_1]='" + cuentas.Rows[i][1].ToString() + "' ";
                    else query += " OR T1.[Segment_1]='" + cuentas.Rows[i][1].ToString() + "' ";

            query += " OR T1.AcctCode='_SYS00000001166') " +
                     " GROUP BY T4.[Account] ";
        }

        return obtenerTabla("MES", query);
    }

    private DataTable obtenerTabla(string nombre, string query)
    {
        DataTable dt = new DataTable();
        dt.TableName = nombre;

        SqlConnection cn = new SqlConnection(url);
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

    public DataTable PresupuestoMensual(string tipo, int mes, int ano)
    {
        DataTable cuentas= obtenerTabla("Sucursales", "SELECT * FROM " + MAER + ".[NivelSucursal] T2 WHERE T2.Nivel='" + tipo + "'");

        string query;
        if (tipo == "Zonas")
        {
            query = " SELECT 	T4.itemName, SUM(T1.CredLTotal-T1.DebLTotal)/1000 as Column1" +
                    " FROM 	" + SAP + ".BGT1					T1 " +
                    " JOIN 	" + SAP + ".OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                    " JOIN 	" + MAER + ".ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                    " JOIN 	" + MAER + ".Items			T4		ON		T4.id=T3.item " +
                    " JOIN  " + SAP + ".OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                    " WHERE T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000'  AND (";

            if (cuentas.Rows.Count > 0)
            {
                int i = 0;
                foreach (DataRow row in cuentas.Rows)
                {
                    if (i == 0) query += " T5.[Segment_1]='" + row[1].ToString() + "' ";
                    else query += " OR T5.[Segment_1]='" + row[1].ToString() + "' ";
                    i++;
                }
            }
            query += " )  AND T5.AcctCode!='_SYS00000001166' " +
                     " AND Line_ID='" + mes + "' GROUP BY T4.ItemName";
        }
        else
        {
            query = " SELECT 	T4.itemName, SUM(T1.CredLTotal-T1.DebLTotal)/1000 as Column1" +
                    " FROM 	" + SAP + ".BGT1					T1 " +
                    " JOIN 	" + SAP + ".OBGT					T2		ON		T1.BudgId = T2.AbsId " +
                    " JOIN 	" + MAER + ".ItemCuenta		T3		ON		T1.acctcode=T3.cuenta " +
                    " JOIN 	" + MAER + ".Items			T4		ON		T4.id=T3.item " +
                    " JOIN  " + SAP + ".OACT                 T5      ON      T5.AcctCode=T1.acctcode" +
                    " WHERE T2.FinancYear>='" + ano + "-01-01 00:00.000' AND T2.FinancYear<='" + ano + "-12-01 00:00.000' AND (";

            if (cuentas.Rows.Count > 0)
                for (int i = 0; i < cuentas.Rows.Count; i++)
                    if (i == 0) query += " T5.[Segment_1]='" + cuentas.Rows[i][1].ToString() + "' ";
                    else query += " OR T5.[Segment_1]='" + cuentas.Rows[i][1].ToString() + "' ";

            query += " OR T5.AcctCode='_SYS00000001166') " +
                     " AND Line_ID='" + mes + "' GROUP BY T4.ItemName";
        }
        
        return obtenerTabla("PresupuestoMensual", query);
    }
}


