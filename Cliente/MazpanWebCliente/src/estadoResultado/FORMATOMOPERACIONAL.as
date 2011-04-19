package estadoResultado
{
	import misClases.Constantes;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	
	public class FORMATOMOPERACIONAL
	{
		private var pdf:PDF;
		
		public function FORMATOMOPERACIONAL()
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.setMargins(7,10,7,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
		}
		
		
		public function generarMOC(datos:Array,ano:String,mes:String):void
		{
			pdf.setFontSize(20)
			pdf.addCell(200,4,"ESTADO DE RESULTADO MASPAN\n",0,1,Align.CENTER);
			pdf.writeText(4,"\n");
			pdf.addCell(200,4,mes+" "+ano+"\n",0,1,Align.CENTER);
			pdf.writeText(6,"\n");
			pdf.writeText(6,"\n");
			
			pdf.setFontSize(8);
			pdf.addCell(30,4,"");
			pdf.addCell(70,4,"");
			pdf.addCell(50,8,"M. OPERACIONAL \n M$",1,0,Align.CENTER);
			pdf.addCell(20,8,"\n%",1,0,Align.CENTER);
			pdf.writeText(10,"\n");
			
			var i:int=0;
			for(i=0; i<datos.length && datos[i].Tipo!=1; i++)
			{
				pdf.addCell(30,4,"");
				pdf.addCell(70,4,datos[i].Name,0);
				pdf.addCell(50,4,datos[i].Valor,0,0,Align.RIGHT);
				pdf.addCell(20,4,datos[i].Porcentaje,0,0,Align.RIGHT);
				pdf.writeText(4,"\n");
			}
			
			pdf.addCell(30,4,"");
			pdf.addCell(140,0.3,"",1);
			pdf.writeText(1,"\n");
			pdf.addCell(30,4,"");
			pdf.addCell(70,4,"Total Zonas\n",0,0,Align.RIGHT);
			pdf.addCell(50,4,datos[i].Valor,0,0,Align.RIGHT);
			pdf.addCell(20,4,datos[i].Porcentaje,0,0,Align.RIGHT);
			pdf.writeText(4,"\n");
			
			pdf.addCell(30,4,"");
			pdf.addCell(70,4,"DIVISIÓN MAYORISTAS\n");
			pdf.writeText(4,"\n");
			
			i++;
			for(; i<datos.length && datos[i].Tipo!=2; i++)
			{
				pdf.addCell(30,4,"");
				pdf.addCell(70,4,datos[i].Name,0);
				pdf.addCell(50,4,datos[i].Valor,0,0,Align.RIGHT);
				pdf.addCell(20,4,datos[i].Porcentaje,0,0,Align.RIGHT);
				pdf.writeText(4,"\n");
			}
			
			pdf.addCell(30,4,"");
			pdf.addCell(140,0.3,"",1);
			pdf.writeText(1,"\n");
			pdf.addCell(30,4,"");
			pdf.addCell(70,4,"Total Zonas\n",0,0,Align.RIGHT);
			pdf.addCell(50,4,datos[i].Valor,0,0,Align.RIGHT);
			pdf.addCell(20,4,datos[i].Porcentaje,0,0,Align.RIGHT);
			pdf.writeText(4,"\n");
			
			pdf.addCell(30,4,"");
			pdf.addCell(140,0.3,"",1);
			pdf.writeText(1,"\n");
			pdf.addCell(30,4,"");
			pdf.addCell(70,4,"MARGEN OPERACIONAL CONSOLIDADO\n");
			pdf.addCell(50,4,datos[i+1].Valor,0,0,Align.RIGHT);
			pdf.addCell(20,4,datos[i+1].Porcentaje,0,0,Align.RIGHT);
			pdf.writeText(4,"\n");
			pdf.addCell(30,4,"");
			pdf.addCell(140,0.3,"",1);
			pdf.writeText(1,"\n");
			pdf.addCell(30,4,"");
			pdf.addCell(140,0.3,"",1);
			pdf.save(Method.REMOTE, Constantes.createPhp, 'inline', "DatosLinea.pdf");	
		}

	}
}