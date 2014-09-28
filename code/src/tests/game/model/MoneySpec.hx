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
			money = new Money(0);
		});
		
		describe("Money", function()
		{
			describe("Deliberately failing test, hint: the test is wrong, not the implementation.", function()
			{
				it("should add an amount to the total", function()
				{
					expect(money.value).to.be(1);
					
					money.add(5);
					
					expect(money.value).to.be(5);
				});
			});
		});
	}
}