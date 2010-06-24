using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Descripción breve de Flujo
/// </summary>
public class Flujo
{
    private List<Monto> flujoEne;
    private DataTable pptoEne;

    private List<Monto> flujoFeb;
    private DataTable pptoFeb;

    private List<Monto> flujoMar;
    private DataTable pptoMar;

    private List<Monto> flujoAbr;
    private DataTable pptoAbr;

    private List<Monto> flujoMay;
    private DataTable pptoMay;

    private List<Monto> flujoJun;
    private DataTable pptoJun;

    private List<Monto> flujoJul;
    private DataTable pptoJul;

    private List<Monto> flujoAgo;
    private DataTable pptoAgo;

    private List<Monto> flujoSep;
    private DataTable pptoSep;

    private List<Monto> flujoOct;
    private DataTable pptoOct;

    private List<Monto> flujoNov;
    private DataTable pptoNov;

    private List<Monto> flujoDic;
    private DataTable pptoDic;

    private int m;//mes numero

	public Flujo()
	{
	}

    public int MESNUMERO
    {
        set { m = value; }
        get { return m; }
    }

    public List<Monto> FLUJOENE
    {
        set { flujoEne = value; }
        get { return flujoEne; }
    }
    public List<Monto> FLUJOFEB
    {
        set { flujoFeb = value; }
        get { return flujoFeb; }
    }
    public List<Monto> FLUJOMAR
    {
        set { flujoMar = value; }
        get { return flujoMar; }
    }
    public List<Monto> FLUJOABR
    {
        set { flujoAbr = value; }
        get { return flujoAbr; }
    }
    public List<Monto> FLUJOMAY
    {
        set { flujoMay = value; }
        get { return flujoMay; }
    }
    public List<Monto> FLUJOJUN
    {
        set { flujoJun = value; }
        get { return flujoJun; }
    }
    public List<Monto> FLUJOJUL
    {
        set { flujoJul = value; }
        get { return flujoJul; }
    }
    public List<Monto> FLUJOAGO
    {
        set { flujoAgo = value; }
        get { return flujoAgo; }
    }
    public List<Monto> FLUJOSEP
    {
        set { flujoSep = value; }
        get { return flujoSep; }
    }
    public List<Monto> FLUJOOCT
    {
        set { flujoOct = value; }
        get { return flujoOct; }
    }
    public List<Monto> FLUJONOV
    {
        set { flujoNov = value; }
        get { return flujoNov; }
    }
    public List<Monto> FLUJODIC
    {
        set { flujoDic = value; }
        get { return flujoDic; }
    }
    public DataTable PPTOENE
    {
        set { pptoEne = value; }
        get { return pptoEne; }
    }
    public DataTable PPTOFEB
    {
        set { pptoFeb = value; }
        get { return pptoFeb; }
    }
    public DataTable PPTOMAR
    {
        set { pptoMar = value; }
        get { return pptoMar; }
    }
    public DataTable PPTOABR
    {
        set { pptoAbr = value; }
        get { return pptoAbr; }
    }
    public DataTable PPTOMAY
    {
        set { pptoMay = value; }
        get { return pptoMay; }
    }
    public DataTable PPTOJUN
    {
        set { pptoJun = value; }
        get { return pptoJun; }
    }
    public DataTable PPTOJUL
    {
        set { pptoJul = value; }
        get { return pptoJul; }
    }
    public DataTable PPTOAGO
    {
        set { pptoAgo = value; }
        get { return pptoAgo; }
    }
    public DataTable PPTOSEP
    {
        set { pptoSep = value; }
        get { return pptoSep; }
    }
    public DataTable PPTOOCT
    {
        set { pptoOct = value; }
        get { return pptoOct; }
    }
    public DataTable PPTONOV
    {
        set { pptoNov = value; }
        get { return pptoNov; }
    }
    public DataTable PPTODIC
    {
        set { pptoDic = value; }
        get { return pptoDic; }
    }

}
