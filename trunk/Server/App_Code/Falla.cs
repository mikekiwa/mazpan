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
/// Summary description for Falla
/// </summary>
public class Falla
{
    private string i;//id
    private string h;//hora
    private string f;//fecha
    private string n;//nombre
    private string t;//turno
    private string c;//codigo

	public Falla()
	{
		//
		// TODO: Add constructor logic here
		//id,horas---> sql
	}

    public string id
    {
        set { i = value; }
        get { return i; }
    }
    public string hora
    {
        set { h = value; }
        get { return h; }
    }
    public string fecha
    {
        set { f = value; }
        get { return f; }
    }
    public string nombre
    {
        set { n = value; }
        get { return n; }
    }
    public string turno
    {
        set { t = value; }
        get { return t; }
    }
    public string codigo
    {
        set { c = value; }
        get { return c; }
    }
}
