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
    private string c;
    private int o;
    private List<int> m;
    private int pp;//PPTO
    private int a;//año

	public Flujo()
	{
	}
    public int ano
    {
        set { a = value; }
        get { return a; }
    }
    public int ppto
    {
        set { pp = value; }
        get { return pp; }
    }
    public List<int> meses
    {
        set { m = value; }
        get { return m; }
    }
    public string cuenta
    {
        set { c = value; }
        get { return c; }
    }
    public int orden
    {
        set { o = value; }
        get { return o; }
    }

}
