package gastosVentas
{
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.data.Grid;
	import org.alivepdf.data.GridColumn;
	import org.alivepdf.drawing.Joint;
	import org.alivepdf.fonts.CoreFont;
	import org.alivepdf.fonts.FontFamily;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	
	public class LayoutVentas
	{
		private var pdf:PDF;
		
		public function LayoutVentas()
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.setMargins(10,10,10,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
		}

		public function generar(array:Array, mes:String,ano:int, en:String):void
		{
		 	var itemname:GridColumn = new GridColumn("Descripcion Articulo", 		"itemname", 	85, Align.CENTER, Align.LEFT);
			var anterior:GridColumn = new GridColumn(mes+" "+(ano-1), 				"anterior", 	30, Align.CENTER, Align.RIGHT);
			var quantity:GridColumn = new GridColumn(mes+" "+ano, 					"quantity", 	30, Align.CENTER, Align.RIGHT);
			var presupuesto:GridColumn = new GridColumn("Presupuesto "+mes+" "+ano, "presupuesto", 	35, Align.CENTER, Align.RIGHT);
			var desviacion:GridColumn = new GridColumn("Desv. %", 					"desviacion", 	15, Align.CENTER, Align.RIGHT);
						
			var columnas:Array=new Array(itemname,anterior,quantity,presupuesto,desviacion);
			var grid:Grid;
          	
          	pdf.setFontSize(22);
          	pdf.writeText(22,"Ventas "+mes+" "+ano+" - "+en+"\n");
          	pdf.setFontSize(8);
          	
          	var aux:Array = new Array();
	        for(var i:int=0; i<array.length; i++)
          	{
          		if(array[i].tipo==0)//titulo o nombre socio
          		{
          			pdf.addCell(85, 5,array[i].itemname, 1);
          	 	}
          	 	else if(array[i].tipo==1)//campos de repeticion
          	 	{
          	 		aux.push(array[i]);
          	 	}
          	 	else if(array[i].tipo==2)//campo de subtotal de cliente
          	 	{
          	 		if(array[i].anterior!=0 || array[i].quantity!=0 || array[i].presupuesto!=0) aux.push(array[i]);
          	 		if(array[i+1].anterior!=0 || array[i+1].quantity!=0 || array[i+1].presupuesto!=0) aux.push(array[i+1]);
          	 		i++;
          	 		pdf.writeText(5,"\n");
          	 		grid = new Grid(aux, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
	          		grid.columns=columnas;
	          	   	pdf.addGrid(grid, 0, 0, true);
          	 		aux = new Array();
          	 		pdf.writeText(8,"\n");
          	 	}
          	 	else if(array[i].tipo==3)//campo de total de documento
          	 	{
          	 		pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8,false);
          	
          	 		if(array[i].anterior!=0 || array[i].quantity!=0 || array[i].presupuesto!=0)
          	 		{
	          	 		pdf.addCell(85,5,array[i].itemname,		1);
	          	 		pdf.addCell(30,	5,array[i].anterior,	1,	0,	Align.RIGHT);
	          	 		pdf.addCell(30,	5,array[i].quantity,	1,	0,	Align.RIGHT);
	          	 		pdf.addCell(35,	5,array[i].presupuesto,	1,	0,	Align.RIGHT);
	          	 		pdf.addCell(15,	5,array[i].desviacion,	1,	0,	Align.RIGHT);
	          	 		pdf.writeText(5,"\n");
          	 		}
          	 	}
          	}
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php",'inline', "Ventas"+mes+ano+".pdf");
		}
	}
}