using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Descripción breve de Flujo
/// </summary>
public class Flujo
{
    private DataTable flujoEne;
    private DataTable pptoEne;

    private DataTable flujoFeb;
    private DataTable pptoFeb;

    private DataTable flujoMar;
    private DataTable pptoMar;

    private DataTable flujoAbr;
    private DataTable pptoAbr;

    private DataTable flujoMay;
    private DataTable pptoMay;

    private DataTable flujoJun;
    private DataTable pptoJun;

    private DataTable flujoJul;
    private DataTable pptoJul;

    private DataTable flujoAgo;
    private DataTable pptoAgo;

    private DataTable flujoSep;
    private DataTable pptoSep;

    private DataTable flujoOct;
    private DataTable pptoOct;

    private DataTable flujoNov;
    private DataTable pptoNov;

    private DataTable flujoDic;
    private DataTable pptoDic;

	public Flujo()
	{
	}

    public DataTable FLUJOENE
    {
        set { flujoEne = value; }
        get { return flujoEne; }
    }
    public DataTable FLUJOFEB
    {
        set { flujoFeb = value; }
        get { return flujoFeb; }
    }
    public DataTable FLUJOMAR
    {
        set { flujoMar = value; }
        get { return flujoMar; }
    }
    public DataTable FLUJOABR
    {
        set { flujoAbr = value; }
        get { return flujoAbr; }
    }
    public DataTable FLUJOMAY
    {
        set { flujoMay = value; }
        get { return flujoMay; }
    }
    public DataTable FLUJOJUN
    {
        set { flujoJun = value; }
        get { return flujoJun; }
    }
    public DataTable FLUJOJUL
    {
        set { flujoJul = value; }
        get { return flujoJul; }
    }
    public DataTable FLUJOAGO
    {
        set { flujoAgo = value; }
        get { return flujoAgo; }
    }
    public DataTable FLUJOSEP
    {
        set { flujoSep = value; }
        get { return flujoSep; }
    }
    public DataTable FLUJOOCT
    {
        set { flujoOct = value; }
        get { return flujoOct; }
    }
    public DataTable FLUJONOV
    {
        set { flujoNov = value; }
        get { return flujoNov; }
    }
    public DataTable FLUJODIC
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
