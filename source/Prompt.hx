package;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;

/**
 * ...
 * @author 
 */
class Prompt extends MusicBeatSubstate
{
	public var okc:Void->Void;
	public var cancelc:Void->Void;
	var theText:String = '';
	var goAnyway:Bool = false;
	var panel:FlxSprite;
	var panelbg:FlxSprite;
	var buttonAccept:FlxButton;
	var buttonNo:FlxButton;
	var cornerSize:Int = 10;
	public function new(promptText:String = '', okCallback:Void->Void, cancelCallback:Void->Void, acceptOnDefault:Bool = false) 
	{
		okc = okCallback;
		cancelc = cancelCallback;
		theText = promptText;
		goAnyway = acceptOnDefault;
		buttonAccept = new FlxButton(473.3, 450, 'OK', function() {
            if(okc != null)
                okc();
	    	close();
        });
		buttonNo = new FlxButton(633.3, 450, 'CANCEL', function() {
            if(cancelc != null)
                cancelc();
		    close();
        });
		super();	
	}

	override public function create():Void 
	{
		super.create();
		if (goAnyway) {
			if(okc != null)
                okc();
			close();
		} else {
            panel = new FlxSprite(0, 0);
            panelbg = new FlxSprite(0, 0);
            makeSelectorGraphic(panel, 300, 150, 0xff999999);
            makeSelectorGraphic(panelbg, 302, 165, 0xff000000);
            panel.scrollFactor.set();
            panel.screenCenter();
            panelbg.scrollFactor.set();
            panelbg.screenCenter();

            add(panelbg);
            add(panel);
            add(buttonAccept);
            add(buttonNo);
            var textshit:FlxText = new FlxText(buttonNo.width * 2, panel.y, 300, theText, 16);
            textshit.alignment = 'center';
            add(textshit);
            textshit.screenCenter();
            buttonAccept.screenCenter();
            buttonNo.screenCenter();
            buttonAccept.x -= buttonNo.width / 1.5;
            buttonAccept.y = panel.y + panel.height - 30;
            buttonNo.x += buttonNo.width / 1.5;
            buttonNo.y = panel.y + panel.height - 30;
            textshit.scrollFactor.set();
		}
	}

	function makeSelectorGraphic(panel:FlxSprite,w,h,color:FlxColor)
	{
		panel.makeGraphic(w, h, color);
		panel.pixels.fillRect(new Rectangle(0, 190, panel.width, 5), 0x0);

		// Why did i do this? Because i'm a lmao stupid, of course
		// also i wanted to understand better how fillRect works so i did this shit lol???
		panel.pixels.fillRect(new Rectangle(0, 0, cornerSize, cornerSize), 0x0);														 //top left
		drawCircleCornerOnSelector(panel,false, false,color);
		panel.pixels.fillRect(new Rectangle(panel.width - cornerSize, 0, cornerSize, cornerSize), 0x0);							 //top right
		drawCircleCornerOnSelector(panel,true, false,color);
		panel.pixels.fillRect(new Rectangle(0, panel.height - cornerSize, cornerSize, cornerSize), 0x0);							 //bottom left
		drawCircleCornerOnSelector(panel,false, true,color);
		panel.pixels.fillRect(new Rectangle(panel.width - cornerSize, panel.height - cornerSize, cornerSize, cornerSize), 0x0); //bottom right
		drawCircleCornerOnSelector(panel,true, true,color);
	}

	function drawCircleCornerOnSelector(panel:FlxSprite,flipX:Bool, flipY:Bool,color:FlxColor)
	{
		var antiX:Float = (panel.width - cornerSize);
		var antiY:Float = flipY ? (panel.height - 1) : 0;
		if(flipY) antiY -= 2;
		panel.pixels.fillRect(new Rectangle((flipX ? antiX : 1), Std.int(Math.abs(antiY - 8)), 10, 3), color);
		if(flipY) antiY += 1;
		panel.pixels.fillRect(new Rectangle((flipX ? antiX : 2), Std.int(Math.abs(antiY - 6)),  9, 2), color);
		if(flipY) antiY += 1;
		panel.pixels.fillRect(new Rectangle((flipX ? antiX : 3), Std.int(Math.abs(antiY - 5)),  8, 1), color);
		panel.pixels.fillRect(new Rectangle((flipX ? antiX : 4), Std.int(Math.abs(antiY - 4)),  7, 1), color);
		panel.pixels.fillRect(new Rectangle((flipX ? antiX : 5), Std.int(Math.abs(antiY - 3)),  6, 1), color);
		panel.pixels.fillRect(new Rectangle((flipX ? antiX : 6), Std.int(Math.abs(antiY - 2)),  5, 1), color);
		panel.pixels.fillRect(new Rectangle((flipX ? antiX : 8), Std.int(Math.abs(antiY - 1)),  3, 1), color);
	}
}