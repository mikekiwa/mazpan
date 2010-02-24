package misClases
{
	public class Venta
	{
		public var itemname:String;
		public var tipo:int;
		public var quantity:String;
		public var anterior:String;
		public var presupuesto:String;
		public var desviacion:String;
		
		public function Venta(_itemName:String,_tipo:int=0,_anterior:String='',_quantity:String='',_presupuesto:String='',_desviacion:String='')
		{
			itemname = _itemName;
			tipo = _tipo;
			quantity = _quantity;
			anterior = _anterior;
			presupuesto = _presupuesto;
			desviacion = _desviacion;
		}
	}
}