using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Tecnico
/// </summary>
public class Tecnico
{
    private string i;//id
    private string r;//rut tecnico
    private string e;//especialidad
    private string o;//otro
    private Personal p;//Personal
	
    public Tecnico()
	{
	}

    public string id
    {
        set { i = value; }
        get { return i; }
    }
    public string rutTecnico
    {
        set { r = value; }
        get { return r; }
    }
    public string especialidad
    {
        set { e = value; }
        get { return e; }
    }
    public string otro
    {
        set { o = value; }
        get { return o; }
    }
    public Personal personal
    {
        set { p = value; }
        get { return p; }
    }
}
