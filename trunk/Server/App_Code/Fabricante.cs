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
/// Descripción breve de Fabricante
/// </summary>
public class Fabricante
{
    private string ma;//marce
    private string a;//año
    private string p;//pais
    private string mo;//modelo
    private string s;//serie
    private string f;//fabricante

	public Fabricante()
	{
	}
    public string marca
    {
        set { ma = value; }
        get { return ma; }
    }
    public string ano
    {
        set { a = value; }
        get { return a; }
    }
    public string pais
    {
        set { p = value; }
        get { return p; }
    }
    public string modelo
    {
        set { mo = value; }
        get { return mo; }
    }
    public string serie
    {
        set { s = value; }
        get { return s; }
    }
    public string fabricante
    {
        set { f = value; }
        get { return f; }
    }
    
}
