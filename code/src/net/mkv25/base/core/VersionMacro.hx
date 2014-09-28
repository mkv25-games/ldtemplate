package net.mkv25.base.core;

#if macro
import sys.io.File;
import sys.FileSystem;
#end
import haxe.macro.Expr;
import haxe.macro.Context;
 
class VersionMacro
{
    macro public static function getGameVersion(projectFileName:String="application.xml"):Expr
    {
		var filepath = "./" + projectFileName;
		
		if (FileSystem.exists(filepath))
		{
			var xml = Xml.parse(File.getContent(filepath));
			var fast = new haxe.xml.Fast(xml.firstElement());
	 
			return Context.makeExpr(fast.node.meta.att.version, Context.currentPos());
		}
		else
		{
			return Context.makeExpr("x", Context.currentPos());
		}
    }
}