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
/// Summary description for ClienteVentas
/// </summary>
public class ClienteVentas
{
    private string n;//nombre
    private string c;//codigo
    private Tablas t;//tablas
    private int m;//mes
    private int a;//ano

	public ClienteVentas()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public string CardCode
    {
        set { c = value; }
        get { return c; }
    }
    public string CardName
    {
        set { n = value; }
        get { return n; }
    }
    public int mes
    {
        set { m = value; }
        get { return m; }
    }
    public int ano
    {
        set { a = value; }
        get { return a; }
    }
    public Tablas Tablas
    {
        set { t = value; }
        get { return t; }
    }
}
