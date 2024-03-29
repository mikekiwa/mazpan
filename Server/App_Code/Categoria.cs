﻿using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Categoria
/// </summary>
public class Categoria
{
    private string i;//id
    private string n;//nombre
    private string d;//descripcion
    private string p;//porcentaje
    private int it;//items
    private int c;//cumplidos

	public Categoria()
	{
	}

    public string id
    {
        set { i = value; }
        get { return i; }
    }
    public string nombre
    {
        set { n = value; }
        get { return n ; }
    }
    public string descripcion
    {
        set { d = value; }
        get { return d; }
    }
    public string porcentaje
    {
        set { p = value; }
        get { return p; }
    }
    public int items
    {
        set { it = value; }
        get { return it; }
    }
    public int cumplidos
    {
        set { c = value; }
        get { return c; }
    }
}
