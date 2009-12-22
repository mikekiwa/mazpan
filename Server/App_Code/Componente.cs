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
/// Descripción breve de Componente
/// </summary>
public class Componente
{
    private string c;//codigo
    private string t;//tipo
    private string s;//sistema
    private string n;//nombre
    private string cost;//costo
    private string vu;//vida util
	private string d;//descripcion
    private string m;//marca
    private string a;//año
    private string p;//pais
    private string mod;//modelo
    private string f;//fabricante
    private string pm;//puesta en marcha

	public Componente()
	{
	}
    public string codigo
    {
        set { c = value; }
        get { return c; }
    }
    public string costo
    {
        set { cost = value; }
        get { return cost; }
    }

    public string nombre
    {
        set { n = value; }
        get { return n; }
    }
    public string vidaUtil
    {
        set { vu = value; }
        get { return vu; }
    }
    public string descripcion
    {
        set { d = value; }
        get { return d; }
    }
    public string ano
    {
        set { a = value; }
        get { return a; }
    }
    public string marca
    {
        set { m = value; }
        get { return m; }
    }
    public string modelo
    {
        set { mod = value; }
        get { return mod; }
    }
    public string fabricante
    {
        set { f = value; }
        get { return f; }
    }
    public string pais
    {
        set { p = value; }
        get { return p; }
    }
    public string tipo
    {
        set { t = value; }
        get { return t; }
    }
    public string sistema
    {
        set { s = value; }
        get { return s; }
    }
    public string puestaMarcha
    {
        set { pm = value; }
        get { return pm; }
    }

}
