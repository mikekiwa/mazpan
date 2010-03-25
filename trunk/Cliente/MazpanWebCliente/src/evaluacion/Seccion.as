package evaluacion
{
	public class Seccion
	{
		public var id:String;
		public var id1:String;
		public var nombre:String;
		public var nombre1:String;
		public var descripcion:String;
		public var editable:Boolean;
		public var editable1:Boolean;
		public var porcentaje:int;
		
		public function Seccion(_id:String=null, _nombre:String=null, _descripcion:String=null,	_editable:Boolean=false,
								_id1:String=null,_nombre1:String=null,_descripcion1:String=null,_editable1:Boolean=false,_porcentaje:int=0)
		{
			id = _id;
			id1 = _id1;
			nombre = _nombre;
			nombre1 = _nombre1;
			descripcion = _descripcion;
			if(_descripcion1!=null){ descripcion = _descripcion1;}
			editable = _editable;
			editable1 = _editable1;
			porcentaje = _porcentaje;
		}

	}
}