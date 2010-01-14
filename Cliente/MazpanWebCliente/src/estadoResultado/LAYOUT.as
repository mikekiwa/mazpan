package estadoResultado
{
	import flash.display.DisplayObject;
	
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
	
	public class LAYOUT
	{
		private var pdf:PDF;
		
		public function LAYOUT()
		{
			pdf = new PDF(Orientation.LANDSCAPE,Unit.MM,Size.LETTER);
			pdf.setMargins(7,10,7,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
		}
		
		public function generarGrafico(grafico:DisplayObject, img:DisplayObject, ano:String, item:String):void
		{
			pdf.addImage(img,null,0,0);
			pdf.setFontSize(25);
			pdf.addText(item+" año "+ano,90,20);
			pdf.addImage(grafico,null,10,30,250,160);
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "Grafico.pdf");
		}

		public function generar(img:DisplayObject, array:Array, numColumns:int, mes:String, ano:int):void
		{
          	var itm:GridColumn = new GridColumn("", "itemName", 40, Align.CENTER, Align.LEFT);
			var ene:GridColumn = new GridColumn("ENE", "ENE", 14, Align.CENTER, Align.RIGHT);
			var feb:GridColumn = new GridColumn("FEB", "FEB", 14, Align.CENTER, Align.RIGHT);
			var mar:GridColumn = new GridColumn("MAR", "MAR", 14, Align.CENTER, Align.RIGHT);
			var abr:GridColumn = new GridColumn("ABR", "ABR", 14, Align.CENTER, Align.RIGHT);
			var may:GridColumn = new GridColumn("MAY", "MAY", 14, Align.CENTER, Align.RIGHT);
			var jun:GridColumn = new GridColumn("JUN", "JUN", 14, Align.CENTER, Align.RIGHT);
			var jul:GridColumn = new GridColumn("JUL", "JUL", 14, Align.CENTER, Align.RIGHT);
			var ago:GridColumn = new GridColumn("AGO", "AGO", 14, Align.CENTER, Align.RIGHT);
			var sep:GridColumn = new GridColumn("SEP", "SEP", 14, Align.CENTER, Align.RIGHT);
			var oct:GridColumn = new GridColumn("OCT", "OCT", 14, Align.CENTER, Align.RIGHT);
			var nov:GridColumn = new GridColumn("NOV", "NOV", 14, Align.CENTER, Align.RIGHT);
			var dic:GridColumn = new GridColumn("DIC", "DIC", 14, Align.CENTER, Align.RIGHT);
			var co0:GridColumn = new GridColumn("Ppto Mes", "", 15, Align.CENTER, Align.RIGHT);
			var co1:GridColumn = new GridColumn("Acum", "REAL", 16, Align.CENTER, Align.RIGHT);
			var co2:GridColumn = new GridColumn("Ppto", "PPTO", 16, Align.CENTER, Align.RIGHT);
			var co3:GridColumn = new GridColumn("Desv", "DESV", 11, Align.CENTER, Align.RIGHT);
			
			var columnas:Array=new Array(itm,ene);
			if(numColumns>=1) columnas.push(feb);
	        if(numColumns>=2) columnas.push(mar);
	        if(numColumns>=3) columnas.push(abr);
	        if(numColumns>=4) columnas.push(may);
	        if(numColumns>=5) columnas.push(jun);
	        if(numColumns>=6) columnas.push(jul);
	        if(numColumns>=7) columnas.push(ago);
	        if(numColumns>=8) columnas.push(sep);
	        if(numColumns>=9) columnas.push(oct);
	        if(numColumns>=10) columnas.push(nov);
	        if(numColumns>=11) columnas.push(dic);
			columnas.push(co0,co1,co2,co3);
          	
          	var grid:Grid = new Grid(array,0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), true, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	grid.columns=columnas;
          	
          	pdf.addImage(img,null,20);
          	pdf.setFontSize(22);
          	pdf.addText("Estado de Resultado "+mes+" de "+ano, 90, 20);
          	pdf.setFontSize(8);
          	pdf.addText("En miles de pesos",130,25);
          	pdf.addGrid(grid, (11-numColumns)*7.5, 18, false);
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "estadoResultado.pdf");
		} 
	}
}