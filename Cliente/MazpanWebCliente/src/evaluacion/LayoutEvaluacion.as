package evaluacion
{
	import misClases.Constantes;
	
	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.data.Grid;
	import org.alivepdf.data.GridColumn;
	import org.alivepdf.drawing.Joint;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	
	public class LayoutEvaluacion
	{
		private var pdf:PDF;
		
		public function LayoutEvaluacion()
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.setMargins(10,10,10,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
		}
		public function crear(_local:Object,_trabajador:Object,_evaluaciones:Array,_categorias:Array,_fecha:String):void
		{
			pdf.setFontSize(18);
			pdf.writeText(12,"Evaluacion "+_fecha+"\n");
			pdf.setFontSize(12);
			pdf.writeText(6,"	Local: "+_local.WhsName+"\n");
			pdf.writeText(6,"	Trabajador: "+_trabajador.CardName+"\n");
			var i:int=0;
			var j:int=0;
			var columnas:Array;
			var grid:Grid;
			
			pdf.writeText(6,"\nNota: Items que cumple marcados con 'X'.");			
			for(i=0; i<_evaluaciones.length; i++)
			{
				if(_evaluaciones[i].className=="myLabel")
				{
					pdf.writeText(8,"\n");
					var cumple:GridColumn  = new GridColumn("", "cumplido",  20, Align.CENTER, Align.CENTER);
					var colCategoria:GridColumn = new GridColumn(_evaluaciones[i].text, "nombre", 155, Align.LEFT, Align.LEFT);
					columnas = new Array(colCategoria,cumple);
					grid = new Grid(new Array, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
		      		grid.columns=columnas;
		      	   	pdf.addGrid(grid, 0, 0, true);
		      	   	//pdf.writeText(8,"\n");
			
					//pdf.writeText(6,"\n");
					//pdf.addCell(155,6,_evaluaciones[i].text,1);
					//pdf.writeText(6,"\n");pdf.writeText(1,"\n");
				}
				else if(_evaluaciones[i].className=="HBox")
				{
					var combos:Array = _evaluaciones[i].getChildren();
					for(j=0; j<combos.length; j++)
					{
						if(combos[j].className=="CheckBox")
						{
							var cbx:CheckBox = combos[j];
							 
							pdf.addCell(155,5,combos[j].label,1);
							if(cbx.selected) pdf.addCell(20,5,"X",1,0,Align.CENTER);
							else pdf.addCell(20,5," ",1);
							
							pdf.writeText(5,"\n");
						}
					}
				}
			}
						
			pdf.writeText(8,"\n");
			var total:Number=0;
			var miscategorias:Array=new Array;
			for(i=0; i<_categorias.length; i++)
			{
				var c:Object = new Object;
				c.nombre = _categorias[i].text+" ("+_categorias[i].porcentaje+")";
				if(int(_categorias[i].items)!=0)
				{
					c.cumplimiento = int(_categorias[i].porcentaje)*int(_categorias[i].cumplidos)/int(_categorias[i].items);
					total += int(_categorias[i].porcentaje)*int(_categorias[i].cumplidos)/int(_categorias[i].items);
				}
				else
				{
					c.cumplimiento = _categorias[i].porcentaje;
					total+=_categorias[i].porcentaje;
				}
				miscategorias.push(c);
			}
			var cat:Object = new Object;
			cat.nombre="Total";
			cat.cumplimiento = total;
			miscategorias.push(cat);	
			
			var categoria:GridColumn = new GridColumn("Categoria ", "nombre", 		145, Align.LEFT, Align.LEFT);
			var cumplido:GridColumn  = new GridColumn("% Cumplido", "cumplimiento",  30, Align.CENTER, Align.RIGHT);
			
			columnas=new Array(categoria,cumplido);
			grid = new Grid(miscategorias, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
      		grid.columns=columnas;
      	   	pdf.addGrid(grid, 0, 0, true);
			
			pdf.save(Method.REMOTE, Constantes.createPhp, 'inline', "Evaluacion-"+_trabajador.CardCode+".pdf");
		}
		public function mostrar(local:String,nTrabajador:String,cTrabajador:String,evaluaciones:Array,categorias:Array,fecha:String,resumenEvaluacion:Array,index:int,meses:ArrayCollection):void
		{
			pdf.setFontSize(18);
			var fechaArr:Array = fecha.split('/');
			var mes:int = fechaArr[1];
			
			fecha = fechaArr[0]+"-"+meses.getItemAt(mes-1)+"-"+fechaArr[2];
			
			pdf.writeText(12,"Evaluacion "+fecha+"\n");
			pdf.setFontSize(12);
			pdf.writeText(6,"	Local: "+local+"\n");
			pdf.writeText(6,"	Trabajador: "+nTrabajador+"\n");
			var i:int=0;
			var j:int=0;
			var itemsCategoria:Array = new Array;
			var grid:Grid;
			var columnas:Array;
			
			pdf.writeText(6,"\nNota: Items que cumple marcados con 'X'.");			
			pdf.writeText(8,"\n");
			
			
			for(i=0; i<evaluaciones.length; i++)
			{
				if(evaluaciones[i].cumple=="True" || evaluaciones[i].cumple=="1") evaluaciones[i].cumplido = "X";
			}
			
			var cumple:GridColumn  = new GridColumn("", "cumplido",  20, Align.CENTER, Align.CENTER);
			var colCategoria:GridColumn;
			for(i=0; i<categorias.length; i++)
			{
				itemsCategoria = new Array;
				colCategoria = new GridColumn(categorias[i].nombre, "nombre", 155, Align.LEFT, Align.LEFT);
				for(j=0; j<evaluaciones.length; j++)
				{
					if(evaluaciones[j].id==categorias[i].id) itemsCategoria.push(evaluaciones[j]);
				}
				columnas = new Array(colCategoria,cumple);
				grid = new Grid(itemsCategoria, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
	      		grid.columns=columnas;
	      	   	pdf.addGrid(grid, 0, 0, true);
	      	   	pdf.writeText(8,"\n");
			}
			
			var categotias_ac:Array = new Array;
			var continuar:Boolean = true;
			for(i=index+1; i<resumenEvaluacion.length && continuar; i++)
			{
				if(resumenEvaluacion[i].tipo!=null && resumenEvaluacion[i].tipo==2) categotias_ac.push(resumenEvaluacion[i]);
				else continuar = false;
			}
			
			for(i=0; i<categotias_ac.length; i++)
			{
				for(j=0;j<categorias.length; j++)
				{
					if(categotias_ac[i].nombre==categorias[j].nombre) categotias_ac[i].nombre = categotias_ac[i].nombre + " ("+categorias[j].porcentaje+")";
				}
			}
			
			resumenEvaluacion[index].nombre = "Total";
			categotias_ac.push(resumenEvaluacion[index]);
			
			var categoria:GridColumn = new GridColumn("Categoria ", "nombre", 		145, Align.LEFT, Align.LEFT);
			var cumplido:GridColumn  = new GridColumn("% Cumplido", "cumplimiento",  30, Align.CENTER, Align.RIGHT);
			
			columnas=new Array(categoria,cumplido);
			grid = new Grid(categotias_ac, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
      		grid.columns=columnas;
      	   	pdf.addGrid(grid, 0, 0, true);
			
			pdf.save(Method.REMOTE, Constantes.createPhp, 'inline', "Evaluacion-"+cTrabajador+".pdf");
		}
	}
}