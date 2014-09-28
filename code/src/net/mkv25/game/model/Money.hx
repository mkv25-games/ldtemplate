package net.mkv25.game.model;

import net.mkv25.base.core.CoreModel;

class Money extends CoreModel
{
	public var value(default, null):Int;

	public function new(value:Int = 0) 
	{
		super();
		
		this.value = value;
	}
	
	public function add(amount:Int):Void
	{
		value = value + amount;
		changed.dispatch(this);
	}
}