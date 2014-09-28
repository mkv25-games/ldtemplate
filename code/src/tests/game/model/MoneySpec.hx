package tests.game.model;

import hxpect.core.BaseSpec;
import net.mkv25.game.model.Money;

class MoneySpec extends BaseSpec
{
	override public function run()
	{
		var money:Money;
		beforeEach(function()
		{
			money = new Money(10);
		});
		
		describe("Money", function()
		{
			describe("Really basic interactions", function()
			{
				it("should add an amount to the total", function()
				{
					expect(money.value).to.be(10);
					
					money.add(7);
					
					expect(money.value).to.be(17);
				});
				
				it("should subtract an amount from the total", function()
				{
					expect(money.value).to.be(10);
					
					money.subtract(4);
					
					expect(money.value).to.be(6);
				});
			});
			
			describe("Change events", function()
			{
				var changeEvents:Int;
					
				beforeEach(function() {
					changeEvents = 0;
					money = new Money(0);
					money.changed.add(function(?model)
					{
						changeEvents++;
					});
				});
				
				it("should dispatch a change event when the internal value of money changes", function()
				{
					money.add(5);
					expect(changeEvents).to.be(1);
					
					money.subtract(5);
					expect(changeEvents).to.be(2);
				});
				
				it("should not dispatch a change event if the value of money did not change", function()
				{
					money.add(0);
					expect(changeEvents).to.be(0);
					
					money.subtract(0);
					expect(changeEvents).to.be(0);
				});
			});
		});
	}
}