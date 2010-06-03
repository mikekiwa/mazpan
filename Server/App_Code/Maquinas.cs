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
/// Summary description for Maquinas
/// </summary>
public class Maquinas
{
    private string m;//maquinas
    private string f;//fecha
	
    public Maquinas()
	{
	}

    public string maquinas
    {
        set{ m = value; }
        get{ return m; }
    }
    public string fecha
    {
        set { f = value; }
        get { return f; }
    }
}
