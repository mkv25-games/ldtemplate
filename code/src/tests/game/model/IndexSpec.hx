package tests.game.model;

import hxpect.core.BaseSpec;

import net.mkv25.game.Failsafe;
import net.mkv25.game.Index;

class IndexSpec extends BaseSpec
{
	override public function run():Void
	{
		describe("Index", function()
		{
			describe("Failsafe", function()
			{
				it("should throw an error if called more then once", function()
				{
					expect(function() { Failsafe.trigger(); } ).to.not.throwException();
					expect(function() { Failsafe.trigger(); } ).to.throwException("The glass has already been broken.");
				});
			});
		});
	}
	
}