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
/// Summary description for Merma
/// </summary>
public class Merma
{
    private DataTable dt1;//
    private DataTable dt2;//
	public Merma()
	{
	}
    public DataTable Mermas
    {
        set { dt1 = value; }
        get { return dt1; }
    }
    public DataTable Producido
    {
        set { dt2 = value; }
        get { return dt2; }
    }
}
