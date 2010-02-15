using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Planta
/// </summary>
public class Planta
{
    private string c;//codigo
    private string n;//nombre
    private string d;//descripcion
    private string e;//encargado
    private string pm;//puesta en marcha

	public Planta()
	{
	}

    public string codigo
    {
        set { c = value; }
        get { return c; }
    }
    public string nombre
    {
        set { n = value; }
        get { return n; }
    }
    public string descripcion
    {
        set { d = value; }
        get { return d; }
    }
    public string encargado
    {
        set { e = value; }
        get { return e; }
    }
    public string puestaMarcha
    {
        set { pm = value; }
        get { return pm; }
    }
}
