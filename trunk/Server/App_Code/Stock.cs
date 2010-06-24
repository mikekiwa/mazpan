using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// Summary description for Stock
/// </summary>
public class Stock
{
    private DataTable dt1;
    private DataTable dt2;

    private string c;//codigo
    private string p;//nombre producto
    private string v;//valor acumulado ó valor
    private string t;//numero de unidades de item

	public Stock()
	{
	}

    public DataTable StockLocal
    {
        set { dt1 = value; }
        get { return dt1; }
    }
    public DataTable StockSistema
    {
        set { dt2 = value; }
        get { return dt2; }
    }

    public string codigo
    {
        set { c = value; }
        get { return c; }
    }
    public string nombre
    {
        set { p = value; }
        get { return p; }
    }
    public string valor
    {
        set { v = value; }
        get { return v; }
    }
    public string cantidad
    {
        set { t = value; }
        get { return t; }
    }
}
