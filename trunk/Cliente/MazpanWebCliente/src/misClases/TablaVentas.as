package misClases
{
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.formatters.NumberFormatter;
	import flash.display.Sprite;

	public class TablaVentas extends DataGrid
	{
		override protected function drawRowBackground(s:Sprite,rowIndex:int,y:Number,height:Number,color:uint,dataIndex:int):void  
		{  
			var dp:ArrayCollection = dataProvider as ArrayCollection;
			var item:Object;
			var formato:NumberFormatter = new NumberFormatter();
			formato.precision=0;
			formato.useThousandsSeparator=true;
			formato.thousandsSeparatorFrom=".";
			formato.thousandsSeparatorTo=".";
			formato.decimalSeparatorFrom=",";
			formato.decimalSeparatorTo=",";
			
			if( dataIndex < dp.length ) item = dp.getItemAt(dataIndex);
			if( item != null )
			{
				if(item.tipo==0) color = 0xDDDDDD;
			 	if(item.tipo==1) color = 0xEEEEEE;
			 	if(item.tipo==2) color = 0xAAAAAA;
			 	if(item.tipo==3) color = 0x999999;
			 	if(item.tipo!=0 && item.tipo!=1 && item.tipo!=2 && item.tipo!=3) color = 0xFFFFFF;
			 	
			 	item.quantity = formato.format(item.quantity);
			 	item.anterior = formato.format(item.anterior);
			 	item.presupuesto = formato.format(item.presupuesto);
			}
			super.drawRowBackground(s,rowIndex,y,height,color,dataIndex);  
		}
	}
}