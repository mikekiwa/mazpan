using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Personal
/// </summary>
public class Personal
{
    private string r;//rut
    private string n;//nombres
    private string ap;//apellidoPaterno
    private string am;//apellidoMaterno
    private string p;//planta
    private string m;//mayorista

	public Personal()
	{
	}

    public string rut
    {
        set { r = value; }
        get { return r; }
    }
    public string nombres
    {
        set { n = value; }
        get { return n; }
    }
    public string apellidoPaterno
    {
        set { ap = value; }
        get { return ap; }
    }
    public string apellidoMaterno
    {
        set { am = value; }
        get { return am; }
    }
    public string planta
    {
        set { p = value; }
        get { return p; }
    }
    public string mayorista
    {
        set { m = value; }
        get { return m; }
    }
}
