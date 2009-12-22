using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;


/// <summary>
/// Descripción breve de ComponenteService
/// </summary>
[WebService(Namespace = "http://tempuri.org/ComponentesService")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class ComponenteService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;

    public ComponenteService ()
    {
    }

    [WebMethod]
    public int addComponente(Componente c)
    {
        String select = "SELECT COUNT(*) FROM Componentes WHERE codigo = '" + c.codigo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {//Si dato no duplicado, no exite en la BD
                String query = "INSERT INTO Componentes([tipo],[codigo],[sistema],[nombre],[costo],[vidaUtil],[descripcion],[marca],[ano],[pais],[modelo],[fabricante],[puestaMarcha])" +
                                " VALUES('"+c.tipo+"','"+c.codigo+"','"+c.sistema+"','"+c.nombre+"','"+c.costo+"','"+c.vidaUtil+"','"+c.descripcion+"','"+c.marca+"','"+c.ano+"','"+c.pais+"','"+c.modelo+"','"+c.fabricante+"','"+c.puestaMarcha+"')";
                SqlConnection cn = new SqlConnection(coneccionString);
                cn.Open();
                SqlCommand insert = new SqlCommand(query, cn);

                int result = insert.ExecuteNonQuery();
                cn.Close();
                return result;
            }
            else 
            {
                return -1;
            }
        }

        selectConn.Close();

        return 0;
    }

    [WebMethod]
    public DataTable allComponentes()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Componentes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM Componentes";

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

    [WebMethod(Description = "Elimina un componente por codigo")]
    public int delComponente(string codigo)
    {
        String query = "DELETE FROM Componentes WHERE codigo='" + codigo + "'";
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        SqlCommand delete = new SqlCommand(query, cn);

        try
        {
            int result = delete.ExecuteNonQuery();
            cn.Close();
            return result;
        }
        catch
        {
            cn.Close();
            return -2;
        }
    }

    [WebMethod]
    public DataTable getComponente(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Componente";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM Componentes WHERE codigo='"+codigo+"'";

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

    [WebMethod]
    public int addEspecificacion(List<Especificacion> especificaciones, string codigo)
    {
        String queryDelete = "DELETE FROM DatosRelevantesComponentes WHERE codigo='" + codigo + "'";
        SqlConnection cndel = new SqlConnection(coneccionString);
        cndel.Open();
        SqlCommand delete = new SqlCommand(queryDelete, cndel);

        try
        {
            delete.ExecuteNonQuery();
            cndel.Close();
        }
        catch
        {
            cndel.Close();
            return -2;
        }

        SqlConnection cn = new SqlConnection(coneccionString);
        int result=0;
        cn.Open();
        try
        {
            foreach (Especificacion e in especificaciones)
            {
                String query = "INSERT INTO DatosRelevantesComponentes(especificacion, valor, codigo)" +
                               " VALUES('" + e.especificacion + "','" + e.valor + "','" + codigo + "')";

                SqlCommand insert = new SqlCommand(query, cn);

                result += insert.ExecuteNonQuery();

            }
            cn.Close();
        }
        catch
        {//Puede ser que el codigo ya no exista, (por la concurrencia)
            cn.Close();
            return -2;
        }
        if(especificaciones.Count==result) return 1;
        return 0;
    }

    [WebMethod]
    public DataTable getEspecificacion(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "DatosRelevantesComponentes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM DatosRelevantesComponentes WHERE codigo='" + codigo + "'";

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

    [WebMethod]
    public int addMantenciones(List<Mantencion> mantenciones, string codigo, string puestaMarcha)
    {
        String queryDelete = "DELETE FROM ActividadMantencionComponentes WHERE codigo='" + codigo + "'";
        SqlConnection cndel = new SqlConnection(coneccionString);
        cndel.Open();
        SqlCommand delete = new SqlCommand(queryDelete, cndel);

        try
        {
            delete.ExecuteNonQuery();
            cndel.Close();
        }
        catch
        {
            cndel.Close();
            return -2;
        }

        SqlConnection cn = new SqlConnection(coneccionString);
        int result = 0;
        cn.Open();
        try
        {
            int orden = 0;
            foreach(Mantencion m in mantenciones)
            {
                orden++;
                String query = "INSERT INTO ActividadMantencionComponentes(id,actividad, orden, tipo, frecuencia, codigo)" +
                              " VALUES('"+codigo+"-"+orden+"','"+m.actividad+"','"+orden+"','"+m.mantencion+"','"+m.frecuencia+"','"+codigo+"');"+
                              " INSERT INTO PlanActividadComponentes(planificada,realizada,estado,frecuencia,idActividad)" +
                              " VALUES('" + puestaMarcha + "','','false','" + m.frecuencia + "','" + codigo + "-" + orden + "')";
                
                SqlCommand insert = new SqlCommand(query, cn);

                result += insert.ExecuteNonQuery();


                string[] fecha = puestaMarcha.Split('/');
                int dia = Convert.ToInt32(fecha[0]);
                int mes = Convert.ToInt32(fecha[1]);
                int año = Convert.ToInt32(fecha[2]);

                DateTime t = new DateTime(año, mes, dia);
                DateTime tf = new DateTime();
                if (m.frecuencia == "Diaria")  tf = t.AddDays(1);
                if (m.frecuencia == "Mensual") tf = t.AddMonths(1);
                if (m.frecuencia == "Anual")   tf = t.AddYears(1);
                string planificada = tf.Day+"/"+tf.Month+"/"+tf.Year;

                addActividad(planificada,m.frecuencia,codigo+"-"+orden);
            }
            cn.Close();
        }
        catch
        {//Puede ser que el codigo ya no exista, (por la concurrencia)
            cn.Close();
            return -2;
        }
        if (mantenciones.Count == result) return 1;
        return 0;
    }

    [WebMethod]
    public DataTable getMantencion(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "ActividadMantencionComponentes";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM ActividadMantencionComponentes WHERE codigo='" + codigo + "'";

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

    [WebMethod]
    public DataTable getActividades()
    {
        DataTable dt = new DataTable();
        dt.TableName = "ActividadesDelPlan";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();

        string query = "select PlanActividadComponentes.id,planificada,realizada,PlanActividadComponentes.frecuencia,estado,nombre " +
                       " from PlanActividadComponentes join ActividadMantencionComponentes "+
                       " on ActividadMantencionComponentes.id=PlanActividadComponentes.idActividad "+
                       " join Componentes "+
                       " on componentes.codigo=ActividadMantencionComponentes.codigo "+
                       " WHERE estado='No Realizada' "+
                       " order by id DESC";

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

    [WebMethod]
    public int addActividad(string planificada, string frecuencia, string idActividad)
    {
        String query = " INSERT INTO PlanActividadComponentes(planificada,realizada,estado,frecuencia,idActividad)" +
                       " VALUES('" + planificada + "','','No Realizada','" + frecuencia + "','" + idActividad + "')";
        return 0;
    }

    [WebMethod]
    public int realizarActividad(Actividad a)
    {
        String select = "SELECT COUNT(*) FROM PlanActividadComponentes WHERE id = '" + a.id + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectExistencia = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectExistencia.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) != 0)
            {//Si dato exite en la BD
                DateTime hoy = DateTime.Today;
                string fechaString = hoy.Year + "/" + hoy.Month + "/" + hoy.Day;
                int dia = DateTime.Today.Day;
                int mes = DateTime.Today.Month;
                int año = DateTime.Today.Year;

                DateTime t = new DateTime(año,mes,dia);
                DateTime tf = new DateTime();
                if(a.frecuencia == "Diaria")  tf = t.AddDays(1);
                if(a.frecuencia == "Mensual") tf = t.AddMonths(1);
                if (a.frecuencia == "Anual")  tf = t.AddYears(1);
                string planificada = tf.Year + "/" + tf.Month + "/" + tf.Day;

                String query = "UPDATE PlanActividadComponentes SET realizada='"+fechaString+"' WHERE id='"+a.id+"'" +
                               " INSERT INTO PlanActividadComponentes(planificada,realizada,estado,frecuencia,idActividad)"+
                               " VALUES('"+planificada+"','','No Realizada','"+a.frecuencia+"','"+a.idActividad+"')";
                SqlConnection cn = new SqlConnection(coneccionString);
                cn.Open();
                SqlCommand insert = new SqlCommand(query, cn);

                int result = insert.ExecuteNonQuery();
                cn.Close();
                return result;
            }
            else
            {
                return -1;
            }
        }

        selectConn.Close();

        return 0;
    }

    [WebMethod]
    public int realizarActividad2(string id, string frecuencia, string idActividad)
    {
        String select = "SELECT COUNT(*) FROM PlanActividadComponentes WHERE id = '" + id + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectExistencia = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectExistencia.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) != 0)
            {//Si dato exite en la BD
                DateTime hoy = DateTime.Today;
                string fechaString = hoy.Year + "/" + hoy.Month + "/" + hoy.Day;
                int dia = DateTime.Today.Day;
                int mes = DateTime.Today.Month;
                int año = DateTime.Today.Year;

                DateTime t = new DateTime(año, mes, dia);
                DateTime tf = new DateTime();
                if (frecuencia == "Diaria") tf = t.AddDays(1);
                if (frecuencia == "Mensual") tf = t.AddMonths(1);
                if (frecuencia == "Anual") tf = t.AddYears(1);
                string planificada = tf.Year + "/" + tf.Month + "/" + tf.Day;

                String query = "UPDATE PlanActividadComponentes SET realizada='" + fechaString + "', estado='Realizada' WHERE id='" + id + "'" +
                               " INSERT INTO PlanActividadComponentes(planificada,realizada,estado,frecuencia,idActividad)" +
                               " VALUES('" + planificada + "','','No Realizada','" + frecuencia + "','" + idActividad + "')";
                SqlConnection cn = new SqlConnection(coneccionString);
                cn.Open();
                SqlCommand insert = new SqlCommand(query, cn);

                int result = insert.ExecuteNonQuery();
                cn.Close();
                return result;
            }
            else
            {
                return -1;
            }
        }

        selectConn.Close();

        return 0;
    }
}

