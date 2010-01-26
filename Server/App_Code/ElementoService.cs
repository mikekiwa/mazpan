using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;


/// <summary>
/// Descripción breve de ElementoService
/// </summary>
[WebService(Namespace = "http://tempuri.org/ElementoService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class ElementoService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;

    public ElementoService ()
    {
    }

    /// <summary>
    /// Permite ver si un elemento ya existe
    /// </summary>
    /// <param name="codigo">el codigo del elemento por el que se desea consultar</param>
    /// <returns>true si el componente exite, false EOC</returns>
    [WebMethod]
    public bool existe(string codigo)
    {
        String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[Elemento] WHERE codigo = '" + codigo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand select = new SqlCommand(query, selectConn);
        SqlDataReader reader = select.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return false;
        }
    }


    /// <summary>
    /// retorna 2 si el super de elemento no es valido
    ///         1 si se completa la insercion
    ///         0 si el Elemento ya existe
    ///        -1 si no se pueden insertar los datos basicos del Elemento
    ///        -2 si no se puede insertar especificaciones del Elemento
    ///        -3 si no se puede insertar mantenciones del Elemento
    ///        -4 si no se puede insertar actividades de mantencion del Elemento
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod(Description="Permite agregar un elemento")]
    public int addElemento(Elemento e)
    {
        if(!existe(e.codigo))
        {
            if (e.superClass.CompareTo("CMP") == 0) return addComponente(e);
            
            return 2;
        }

        return 0;//EOC
    }
    
    
    /// <summary>
    /// retorna una tabla con los elementos requeridos
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod(Description = "Permite obtener todos los elementos de la super clase especificada")]
    public DataTable allElementos(string superClass)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Elementos";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM [PracticaDb].[dbo].[Elemento] WHERE super='"+superClass+"'";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }
    

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="query">
    /// La consulta que se desea ejecutar
    /// </param>
    private int Ejecutar(string query)
    {
        SqlConnection conn = new SqlConnection(coneccionString);
        conn.Open();
        SqlCommand insert = new SqlCommand(query, conn);

        try
        {
            insert.ExecuteNonQuery();
            conn.Close();
        }
        catch
        {
            conn.Close();
            return 0;
        }
        return 1;
    }


    /// <summary>
    /// Elimina un Elemento por codigo
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="codigo">codigo del elemento que se desea eliminar</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod(Description = "Elimina un Elemento por codigo")]
    public int delElemento(string codigo)
    {
        String query = "DELETE FROM [PracticaDB].[dbo].[Elemento] WHERE codigo='" + codigo + "'";
        int result = Ejecutar(query);

        if(result==1) return 1;
        else return 0;
    }


    /// <summary>
    /// Recive una cadana de texto con formato dd/mm/aaaa y la lleva a un DateTime
    /// </summary>
    /// <param name="fecha">Cadana de texto con formato dd/mm/aaaa</param>
    /// <returns>Fecha como un tipo DateTime</returns>
    private DateTime toDateTime(string fecha)
    {
        string[] date = fecha.Split('/');
        int dia = Convert.ToInt32(date[0]);
        int mes = Convert.ToInt32(date[1]);
        int año = Convert.ToInt32(date[2]);

        return new DateTime(año, mes, dia);
    }


    /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos de la maquina
    ///        -2 si no se puede insertar especificaciones de la maquina
    ///        -3 si no se puede insertar mantenciones de la maquina
    ///        -4 si no se puede insertar actividades de mantencion de la maquina
    ///        -5 si no se puede insertar los componentes de la maquina
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int addMaquina(Elemento m)
    {
        String query = " INSERT INTO [PracticaDb].[dbo].[Elemento](tipo,codigo,puestaMarcha,nombre,ubicacion,estado,condicionRecepcion,costo,horasVidaUtil,horasActuales,horasDiariasPromedio,descripcion,marca,ano,pais,modelo,serie,fabricante)" +
                       " VALUES('" + m.tipo + "','" + m.codigo + "','" + m.puestaMarcha + "','" + m.nombre + "','" + m.ubicacion + "',''" + m.estado + "','" + m.condicionRecepcion + "','" + m.costo + "','" + m.horasVidaUtil + "','" + m.horasActuales + "','" + m.horasDiariasPromedio + "','" + m.descripcion + "','" + m.fabricante.marca + "','" + m.fabricante.ano + "','" + m.fabricante.pais + "','" + m.fabricante.modelo + "','" + m.fabricante.serie + "','" + m.fabricante.fabricante + "')";
        
        if (Ejecutar(query) == 1)//si insercion exitosa
            if (addEspecificaciones(m.especificaciones, m.codigo) == 1)//si insercion exitosa
                if (addActividades(m.mantenciones, m.codigo) == 1)
                    if (addActividades(m.mantenciones, m.codigo, m.puestaMarcha) == 1)
                        
                    else return -4;
                else return -3;
            else return -2;
        else return -1;
    }

    /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos del componente
    ///        -2 si no se puede insertar especificaciones del componente
    ///        -3 si no se puede insertar mantenciones del componente
    ///        -4 si no se puede insertar actividades de mantencion del componente
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int addComponente(Elemento c)
    {

        DateTime t = toDateTime(c.puestaMarcha);
        string puestaMarcha = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";

        string query = " INSERT INTO [PracticaDb].[dbo].[Elemento]([super],[tipo],[codigo],[sistema],[nombre],[costo],[vidaUtil],[descripcion],[marca],[ano],[pais],[modelo],[fabricante],[puestaMarcha])" +
                       " VALUES('CMP','" + c.tipo + "','" + c.codigo + "','" + c.sistema + "','" + c.nombre + "','" + c.costo + "','" + c.vidaUtil + "','" + c.descripcion + "','" + c.fabricante.marca + "','" + c.fabricante.ano + "','" + c.fabricante.pais + "','" + c.fabricante.modelo + "','" + c.fabricante.fabricante + "','" + puestaMarcha + "')";

        if (Ejecutar(query) == 1)//si insercion exitosa
            if (addEspecificaciones(c.especificaciones, c.codigo) == 1)//si insercion exitosa
                if (addActividades(c.mantenciones, c.codigo) == 1)
                    if (addPlan(c.mantenciones, c.codigo, c.puestaMarcha) == 1) return 1;
                    else return -4;
                else return -3;
            else return -2;
        else return -1;
    }


    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="especificaciones">Lista de especificaciones</param>
    /// <param name="codigo">codigo del elemento</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addEspecificaciones(List<Especificacion> especificaciones, string codigo)
    {
        int result = 0;

        foreach (Especificacion e in especificaciones)
        {
            result += Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Especificaciones](especificacion, valor, codigo) " +
                               " VALUES('" + e.especificacion + "','" + e.valor + "','" + codigo + "') ");
        }

        if (especificaciones.Count == result) return 1;
        else return 0;
    }


    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="mantenciones">Lista de mantenciones</param>
    /// <param name="codigo">codigo del elemento</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addActividades(List<Mantencion> mantenciones, string codigo)
    {
        int orden = 0;
        int result = 0;
        foreach (Mantencion m in mantenciones)
        {
            orden++;
            result += Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Actividades](actividad, orden, mantencion, frecuencia, codigo)" +
                               " VALUES('" + m.actividad + "','" + orden + "','" + m.mantencion + "','" + m.frecuencia + "','" + codigo + "')");
        }

        if (mantenciones.Count == result) return 1;
        else return 0;
    }


    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="mantenciones">Lista de mantenciones</param>
    /// <param name="codigo">codigo del elemento</param>
    /// <param name="puestaMarcha">string con la fecha de la puesta en marcha del componente</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addPlan(List<Mantencion> mantenciones, string codigo, string puestaMarcha)
    {
        int result = 0;
        foreach (Mantencion m in mantenciones)
        {
            DateTime t = toDateTime(puestaMarcha);
            DateTime fechas_planificada = new DateTime();
            if (m.frecuencia == "Diario") fechas_planificada = t.AddDays(1);
            if (m.frecuencia == "Semanal") fechas_planificada = t.AddDays(7);
            if (m.frecuencia == "Mensual") fechas_planificada = t.AddMonths(1);
            if (m.frecuencia == "Anual") fechas_planificada = t.AddYears(1);

            //Con esto evitamos que nos aparezca un sabado o domingo en el plan
            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Saturday") == 0) fechas_planificada = fechas_planificada.AddDays(2);
            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Sunday") == 0) fechas_planificada = fechas_planificada.AddDays(1);

            string planificada = fechas_planificada.Year + "-" + fechas_planificada.Month + "-" + fechas_planificada.Day + " 00:00.000";

            result += Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Plan]([planificada],[realizada],[frecuencia],[actividad],[codigo])"    +
                               " VALUES('" + planificada + "','','" + m.frecuencia + "','"+m.actividad+"','" + codigo + "')"            );
        }

        if (mantenciones.Count == result) return 1;
        else return 0;
    }


    [WebMethod]
    public DataTable getActividades()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Plan";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();

        DateTime hoy = DateTime.Now;
        string fecha = hoy.Year + "-" + hoy.Month + "-" + hoy.Day + " 00:00.000";

        string query = " SELECT	T1.nombre, T2.actividad, T2.id, T2.planificada, T2.frecuencia, T2.codigo "+
                       " FROM	PracticaDb.dbo.Elemento		    T1 "+
                       " JOIN	PracticaDb.dbo.[Plan]			T2	on T1.codigo=T2.codigo  "+
                       " WHERE	T2.realizada<T2.planificada		AND T2.planificada<='" + fecha + "'";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }


    /// <summary>
    /// retorna 1 sí la insercion de todos las activiades fue exitosa
    ///        -1 sí la insercion de algunos datos fue exitosa
    ///         0 EOC
    /// </summary>
    /// <param name="actividades">Lista de las actividades de mantencion que se quieren marcar como realizadas</param>
    /// <returns>1 sí la insercion de todos las activiades fue exitosa, -1 sí la insercion de algunos datos fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int realizarActividades(List<Mantencion> actividades)
    {   
        int result = 0;
        foreach (Mantencion m in actividades)
        {
            DateTime t = DateTime.Now;
            DateTime fechas_planificada = new DateTime();
            if (m.frecuencia == "Diario") fechas_planificada = t.AddDays(1);
            if (m.frecuencia == "Semanal") fechas_planificada = t.AddDays(7);
            if (m.frecuencia == "Mensual") fechas_planificada = t.AddMonths(1);
            if (m.frecuencia == "Anual") fechas_planificada = t.AddYears(1);

            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Saturday")==0) fechas_planificada = fechas_planificada.AddDays(2);
            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Sunday") == 0) fechas_planificada = fechas_planificada.AddDays(1);

            string planificada = fechas_planificada.Year + "-" + fechas_planificada.Month + "-" + fechas_planificada.Day + " 00:00.000";

            int resultAux = Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Plan]([planificada],[realizada],[frecuencia],[actividad],[codigo])" +
                                     " VALUES('" + planificada + "','','" + m.frecuencia + "','" + m.actividad + "','" + m.codigo + "')");

            if (resultAux == 1)
            {
                string realizada = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";
                result += Ejecutar(" UPDATE [PracticaDb].[dbo].[Plan] SET realizada='" + realizada + "' WHERE id='" + m.id + "'");
            }
            else
            {
                return 0;
            }
        }

        if(actividades.Count == result) return 1;
        else return -1;
    }
}

