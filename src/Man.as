package
{
	
	/**
	 * ...
	 * @author 何雨航
	 */
	public class Man extends Creature
	{
		public function Man(map:Map)
		{
			super(map);
		}
		
		public function build(name:String, pos:Array):void
		{
		moveto(pos);
		}
	
	}

}